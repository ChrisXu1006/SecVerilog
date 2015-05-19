//=========================================================================
// Blocking Cache Controller
//=========================================================================

`ifndef PLAB3_MEM_BLOCKING_CACHE_SEC_FSM_V
`define PLAB3_MEM_BLOCKING_CACHE_SEC_FSM_V

`include "plab3-mem-BlockingCacheAlt.v"
`include "plab5-mcore-proc2mem-trans.v"

module plab3_mem_BlockingCacheSec_fsm
#(
	parameter	mode = 0,	// 0 for instruction, 1 for data

	parameter	p_mem_nbytes = 256,	// Cache size in bytes
	parameter	p_num_banks	 = 0,   // Total number of cache banks

	// opaque field from the cache and memory side
	parameter	p_opaque_nbits = 8,

	// local parameters not meant to be set from outside
	parameter	dbw	 = 32,	// Short name for data bitwidth
	parameter	abw	 = 32,	// Short name for addr bitwidth
	parameter	clw	 = 128,	// Short name for cacheline bitwidth

	parameter	o = p_opaque_nbits
)
(
	input											clk,
	input											reset,

	// input signal for control register in cache
	input											cacheable,

	// Cache Request from processor
	
	input	[`VC_MEM_REQ_MSG_NBITS(o,abw,dbw)-1:0]	procreq_msg,
	input											procreq_val,
	input											procreq_domain,
	output											procreq_rdy,

	// Cache Response to processor
	output	[`VC_MEM_RESP_MSG_NBITS(o,dbw)-1:0]		procresp_msg,
	output											procresp_val,
	output											procresp_domain,
	input											procresp_rdy,

	// Memory Request to the main memory
	output	[`VC_MEM_REQ_MSG_NBITS(o,abw,clw)-1:0]	memreq_msg,
	output											memreq_domain,
	output											memreq_val,
	input											memreq_rdy,

	// Memory Response from the main memory
	input											insecure,
	input	[`VC_MEM_RESP_MSG_NBITS(o,clw)-1:0]		memresp_msg,
	input											memresp_domain,
	input											memresp_val,
	output											memresp_rdy
);

	reg												procreq_rdy;
	reg	[`VC_MEM_RESP_MSG_NBITS(o,dbw)-1:0]			procresp_msg;
	reg												procresp_val;
	reg												procresp_domain;
	
	reg	[`VC_MEM_REQ_MSG_NBITS(o,abw,clw)-1:0]		memreq_msg;
	reg												memreq_domain;
	reg												memreq_val;
	reg												memresp_rdy;

	// this register will control which security domains are allowed to be
	// cached, 1 means only high security level can be loaded into cache,
	// 0 indicates both high and low security level can be cacheable

	reg	cache_control_reg;

	always @(*) begin
		if ( reset )
			cache_control_reg = 1'b1;
		else
			cache_control_reg = cacheable;
	end

	// Cache's wires
	reg [`VC_MEM_REQ_MSG_NBITS(o,abw,dbw)-1:0]	proc2cachereq_msg;
	reg											proc2cachereq_val;
	reg											proc2cachereq_domain;
	wire										proc2cachereq_rdy;

	wire [`VC_MEM_RESP_MSG_NBITS(o,dbw)-1:0]	cache2procresp_msg;
	wire										cache2procresp_val;
	wire										cache2procresp_domain;
	reg											cache2procresp_rdy;

	wire [`VC_MEM_REQ_MSG_NBITS(o,abw,clw)-1:0]	cache2memreq_msg;
	wire										cache2memreq_val;
	wire										cache2memreq_domain;
	reg											cache2memreq_rdy;

	reg  [`VC_MEM_RESP_MSG_NBITS(o,clw)-1:0]	mem2cacheresp_msg;
	reg 										mem2cacheresp_val;
	reg 										mem2cacheresp_domain;
	wire										mem2cacheresp_rdy;

	// Cache 
	plab3_mem_BlockingCacheAlt
	#(
		.mode				(mode),
		.p_mem_nbytes		(p_mem_nbytes),
		.p_num_banks		(p_num_banks),
		.p_opaque_nbits		(p_opaque_nbits)
	)
	cache
	(
		.clk				(clk),
		.reset				(reset),

		.cachereq_msg		(proc2cachereq_msg),
		.cachereq_val		(proc2cachereq_val),
		.cachereq_rdy		(proc2cachereq_rdy),

		.cacheresp_msg		(cache2procresp_msg),
		.cacheresp_val		(cache2procresp_val),
		.cacheresp_rdy		(cache2procresp_rdy),

		.memreq_msg			(cache2memreq_msg),
		.memreq_val			(cache2memreq_val),
		.memreq_rdy			(cache2memreq_rdy),

		.memresp_msg		(mem2cacheresp_msg),
		.memresp_val		(mem2cacheresp_val),
		.memresp_rdy		(mem2cacheresp_rdy)
	);

	// use a gt comparator to chech the current request is cacheable or not
	wire secure;
	
	vc_GEtComparator #(1) sec_checker
	(
		.in0	(procresp_domain_pre),
		.in1	(cache_control_reg),
		.out	(secure)
	);

	// since the bitwidth of processor request/response is inconsistent with 
	// memory request/response, so we need a translation module to do the
	// translation job
	wire [`VC_MEM_REQ_MSG_NBITS(o,abw,clw)-1:0]	procreq_msg_extend;
	wire [`VC_MEM_RESP_MSG_NBITS(o,dbw)-1:0]	memresp_msg_simple;

	plab5_mcore_proc2mem_trans
	#(
		.opaque_nbits	(o),
		.addr_nbits		(abw),
		.proc_data_nbits(dbw),
		.mem_data_nbits	(clw)
	)
	procmem_trans
	(
		.proc_req_msg	(procreq_msg),
		.mem_req_msg	(procreq_msg_extend),

		.mem_resp_msg	(resp_msg),
		.proc_resp_msg	(memresp_msg_simple)
	);

	//----------------------------------------------------------------------
	// State Definitions
	//----------------------------------------------------------------------
	
	localparam	STATE_IDLE			  = 4'd0;
	localparam  STATE_SEC_CHECK		  = 4'd1;
	localparam  STATE_LOW_MEM_REQ	  = 4'd2;
	localparam	STATE_LOW_MEM_WAIT	  = 4'd3;
	localparam  STATE_LOW_MEM_RESP    = 4'd4;
	localparam  STATE_HIGH_CACHE_REQ  = 4'd5;
	localparam  STATE_HIGH_CACHE_WAIT = 4'd6;
	localparam  STATE_HIGH_CACHE_RESP = 4'd7;
	localparam  STATE_HIGH_MEM_REQ	  = 4'd8;
	localparam  STATE_HIGH_MEM_WAIT	  = 4'd9;
	localparam  STATE_HIGH_MEM_RESP   = 4'd10;

	//----------------------------------------------------------------------
	// State
	//----------------------------------------------------------------------
	
	reg [3:0]	state_reg;
	reg [3:0]	state_next;

	always @(posedge clk) begin
		if ( reset ) begin
			state_reg <= STATE_IDLE;
		end
		else begin
			state_reg <= state_next;
		end
	end

	//----------------------------------------------------------------------
	// State Transitions
	//----------------------------------------------------------------------
	
	always @(*) begin

		state_next = state_reg;
		
		case ( state_reg )

			STATE_IDLE:
				if ( procreq_val )	state_next = STATE_SEC_CHECK;
			
			STATE_SEC_CHECK:
				if ( secure)		state_next = STATE_HIGH_CACHE_REQ;
				else				state_next = STATE_LOW_MEM_REQ;

			STATE_LOW_MEM_REQ:
				state_next = STATE_LOW_MEM_WAIT;
			
			STATE_LOW_MEM_WAIT:
				if ( memresp_val )  state_next = STATE_LOW_MEM_RESP;

			STATE_LOW_MEM_RESP:
				state_next = STATE_IDLE;

			STATE_HIGH_CACHE_REQ:
				state_next = STATE_HIGH_CACHE_WAIT;
			
			STATE_HIGH_CACHE_WAIT:
				if ( cache2procresp_val )
									state_next = STATE_HIGH_CACHE_RESP;
		   else if ( cache2memreq_val )
									state_next = STATE_HIGH_MEM_REQ;

			STATE_HIGH_CACHE_RESP:
				state_next = STATE_IDLE;
			
			STATE_HIGH_MEM_REQ:
				state_next = STATE_HIGH_MEM_WAIT;

			STATE_HIGH_MEM_WAIT:
				if ( memresp_val ) state_next = STATE_HIGH_MEM_RESP;	

			STATE_HIGH_MEM_RESP:
				state_next = STATE_HIGH_CACHE_WAIT;
		endcase
	end

	//----------------------------------------------------------------------
	// State Outputs
	//----------------------------------------------------------------------
	
	reg [`VC_MEM_REQ_MSG_NBITS(o,abw,clw)-1:0]	req_msg_extend;
	reg [`VC_MEM_REQ_MSG_NBITS(o,abw,dbw)-1:0]	req_msg;
	reg [`VC_MEM_RESP_MSG_NBITS(o,clw)-1:0]		resp_msg;
	reg											resp_domain;
	reg											procresp_domain_pre;
	
	// register corresponding data
	always @(posedge clk) begin
		if ( state_reg == STATE_IDLE && procreq_val ) begin
			req_msg_extend  <= procreq_msg_extend;
			req_msg			<= procreq_msg;
			procresp_domain_pre <= procreq_domain; 
		end

		else if ( state_reg == STATE_HIGH_CACHE_WAIT ) begin
			req_msg_extend <= cache2memreq_msg;
			req_msg		   <= req_msg;
			procresp_domain_pre <= procresp_domain_pre;
		end

		else begin
			req_msg_extend <= req_msg_extend;
			req_msg		   <= req_msg;
			procresp_domain_pre <= procresp_domain_pre;
		end
	end

	always @(posedge clk) begin
		if ( state_reg == STATE_LOW_MEM_WAIT && memresp_val ) begin
			resp_msg    <= memresp_msg;		
			resp_domain <= memresp_domain;
		end
		
		else if ( state_reg == STATE_HIGH_MEM_WAIT && memresp_val ) begin
			resp_msg    <= memresp_msg;
			resp_domain <= memresp_domain;
		end
		
		else begin
			resp_msg    <= resp_msg;
			resp_domain <= resp_domain;
		end
	end

	
	always @(*) begin

		procreq_rdy		= 1'b1;
		procresp_msg	= 'hx;
		procresp_val	= 1'b0;
		memreq_msg		= 'hx;
		memreq_domain	= 1'hx;
		memreq_val		= 1'b0;
		memresp_rdy		= 1'b1;

		case ( state_reg )

			STATE_IDLE: begin
				procreq_rdy			= 1'b1;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				procresp_domain		= 1'bx;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_SEC_CHECK: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				procresp_domain		= 1'hx;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_LOW_MEM_REQ: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				procresp_domain		= 1'hx;
				memreq_msg			= req_msg_extend;
				memreq_domain		= 1'b0;
				memreq_val			= 1'b1;
				memresp_rdy			= 1'b1;
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_LOW_MEM_WAIT: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				procresp_domain		= 1'hx;
				memreq_msg			= 'hx;
				memreq_domain		= 1'b0;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_LOW_MEM_RESP: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= memresp_msg_simple;
				procresp_val		= 1'b1;
				procresp_domain		= 1'b0;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_HIGH_CACHE_REQ: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				procresp_domain		= 1'hx;
				proc2cachereq_msg	= req_msg;
			    proc2cachereq_domain= procreq_domain;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2cachereq_val	= 1'b1;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_HIGH_CACHE_WAIT: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				procresp_domain		= 1'hx;
				proc2cachereq_msg	= 'hx;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2cachereq_val	= 1'b0;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end
			
			STATE_HIGH_CACHE_RESP: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= cache2procresp_msg;
				procresp_val		= 1'b1;
				procresp_domain		= 1'b1;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2cachereq_val	= 1'b0;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_HIGH_MEM_REQ: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				procresp_domain		= 'hx;
				memreq_msg			= req_msg_extend;
				memreq_domain		= procresp_domain_pre;
				memreq_val			= 1'b1;
				memresp_rdy			= 1'b1;
				proc2cachereq_val	= 1'b0;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_HIGH_MEM_WAIT: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				procresp_domain		= 'hx;
				memreq_msg			= 'hx;
				memreq_domain		= 1'bx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2cachereq_val	= 1'b0;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_HIGH_MEM_RESP: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				procresp_domain		= 'hx;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				mem2cacheresp_msg	 = resp_msg;
				mem2cacheresp_val	 = 1'b1;
				mem2cacheresp_domain = resp_domain;
				proc2cachereq_val	= 1'b0;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
			end

		endcase
	end

endmodule
`endif 


