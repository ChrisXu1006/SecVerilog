//=========================================================================
// Blocking Cache Controller
// Compared to the older version, low and high security level can share 
// caches based on addres space. Whether a request is cacheable is based on
// addres rather than security level where the requests come from
//=========================================================================

`ifndef PLAB3_MEM_BLOCKING_CACHE_SEC_FSM1_V
`define PLAB3_MEM_BLOCKING_CACHE_SEC_FSM1_V


`include "plab3-mem-PrefetchBuffer.v"
`include "plab3-mem-BlockingL2Cache.v"
`include "plab5-mcore-proc2mem-trans.v"

module plab3_mem_BlockingCacheSec_fsm1
#(
	parameter	mode = 0,	// 0 for instruction, 1 for data

	parameter	p_mem_nbytes = 256,	// Cache size in bytes
	parameter	p_num_banks	 = 0,   // Total number of cache banks
	parameter   reset_addr   = 32'hc000, // reset cacheable address

	// opaque field from the cache and memory side
	parameter	p_opaque_nbits = 8,

	// local parameters not meant to be set from outside
	parameter	dbw	 = 128,	// Short name for data bitwidth
	parameter	abw	 = 32,	// Short name for addr bitwidth
	parameter	clw	 = 128,	// Short name for cacheline bitwidth

	parameter	o = p_opaque_nbits
)
(
	input											clk,
	input											reset,

	// Cache Request from processor
	
	input	[`VC_MEM_REQ_MSG_NBITS(o,abw,dbw)-1:0]	procreq_msg,
	input											procreq_val,
	input											procreq_domain,
	output											procreq_rdy,

	// Cache Response to processor
	output	reg										fail,
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

	// The cache register stores the boundry address of cacheable or
	// uncacheable. 

	reg[31:0]	cache_control_reg = reset_addr;

	// Prefetch Buffer wires
	wire[1:0]									pre_found;
	
	reg [`VC_MEM_REQ_MSG_NBITS(o,abw,dbw)-1:0]	proc2prebufreq_msg;
	reg											proc2prebufreq_val;
	wire										proc2prebufreq_rdy;

	wire [`VC_MEM_RESP_MSG_NBITS(o,dbw)-1:0]	prebuf2procresp_msg;
	wire										prebuf2procresp_val;
	reg											prebuf2procresp_rdy;

	wire [`VC_MEM_REQ_MSG_NBITS(o,abw,clw)-1:0]	prebuf2memreq_msg;
	wire										prebuf2memreq_val;
	reg											prebuf2memreq_rdy;

	reg  [`VC_MEM_RESP_MSG_NBITS(o,clw)-1:0]	mem2prebufresp_msg;
	reg 										mem2prebufresp_val;
	wire										mem2prebufresp_rdy;

	plab3_mem_PrefetchBuffer
	#(
		.p_mem_nbytes		(p_mem_nbytes),
		.p_num_banks		(p_num_banks),
		.p_opaque_nbits		(p_opaque_nbits)
	)
	prebuffer
	(
		.clk				(clk),
		.reset				(reset),

		.found				(pre_found),

		.procreq_msg		(proc2prebufreq_msg),
		.procreq_val		(proc2prebufreq_val),
		.procreq_rdy		(proc2prebufreq_rdy),

		.procresp_msg		(prebuf2procresp_msg),
		.procresp_val		(prebuf2procresp_val),
		.procresp_rdy		(prebuf2procresp_rdy),

		.memreq_msg			(prebuf2memreq_msg),
		.memreq_val			(prebuf2memreq_val),
		.memreq_rdy			(prebuf2memreq_rdy),

		.insecure			(insecure),

		.memresp_msg		(mem2prebufresp_msg),
		.memresp_val		(mem2prebufresp_val),
		.memresp_rdy		(mem2prebufresp_rdy)
	);

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
	plab3_mem_BlockingL2Cache
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

		.insecure			(insecure),

		.memresp_msg		(mem2cacheresp_msg),
		.memresp_val		(mem2cacheresp_val),
		.memresp_rdy		(mem2cacheresp_rdy)
	);

	// use a gt comparator to chech the current request is cacheable or not
	wire cacheable;
	
	vc_GtComparator #(32) sec_checker
	(
		.in0	(cache_control_reg),
		.in1	(req_addr),
		.out	(cacheable)
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
	
	localparam	STATE_IDLE			  = 5'd0;
	localparam  STATE_REQ_TYPE		  = 5'd1;
	localparam  STATE_PREFETCH_REQ    = 5'd2;
	localparam  STATE_PREFETCH_WAIT   = 5'd3;
	localparam  STATE_PREFETCH_RESP	  = 5'd4;
	localparam  STATE_SEC_CHECK		  = 5'd5;
	localparam  STATE_DIR_MEM_REQ	  = 5'd6;
	localparam	STATE_DIR_MEM_WAIT	  = 5'd7;
	localparam  STATE_DIR_MEM_RESP    = 5'd8;
	localparam  STATE_CACHE_REQ		  = 5'd9;
	localparam  STATE_CACHE_WAIT	  = 5'd10;
	localparam  STATE_CACHE_RESP	  = 5'd11;
	localparam  STATE_CACHE_MEM_REQ	  = 5'd12;
	localparam  STATE_CACHE_MEM_WAIT  = 5'd13;
	localparam  STATE_CACHE_MEM_RESP  = 5'd14;
	localparam  STATE_PREFETCH_MEM_RESP = 5'd15;
	localparam  STATE_CH_CTRLREG	  = 5'd16;
	localparam  STATE_EMPTY_RESP	  = 5'd17;

	//----------------------------------------------------------------------
	// State
	//----------------------------------------------------------------------
	
	reg [4:0]	state_reg;
	reg [4:0]	state_next;

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
				if ( procreq_val )	state_next = STATE_REQ_TYPE;

			STATE_REQ_TYPE:
				if ( req_addr == 32'h0000 )
									state_next = STATE_DIR_MEM_REQ;
		   else if ( req_addr == 32'h0004 && cur_domain == 1'b1 )
									state_next = STATE_CH_CTRLREG;
		   else if ( req_addr == 32'h0004 && cur_domain == 1'b0 )
									state_next = STATE_EMPTY_RESP;
				else				state_next = STATE_PREFETCH_REQ;

			STATE_PREFETCH_REQ:
				state_next = STATE_PREFETCH_WAIT;
			
			STATE_PREFETCH_WAIT:
				if ( pre_found == 1 || prebuf2procresp_val )	
									state_next = STATE_PREFETCH_RESP;
		   else if ( pre_found == 2 ) 
									state_next = STATE_SEC_CHECK;
		   else if ( prebuf2memreq_val )
									state_next = STATE_CACHE_MEM_REQ;
			
			STATE_PREFETCH_RESP:
				state_next = STATE_IDLE;

			STATE_SEC_CHECK:
				if ( cacheable )	state_next = STATE_CACHE_REQ;
				else				state_next = STATE_DIR_MEM_REQ;

			STATE_DIR_MEM_REQ:
				state_next = STATE_DIR_MEM_WAIT;
			
			STATE_DIR_MEM_WAIT:
				if ( memresp_val )  state_next = STATE_DIR_MEM_RESP;

			STATE_DIR_MEM_RESP:
				state_next = STATE_IDLE;

			STATE_CACHE_REQ:
				state_next = STATE_CACHE_WAIT;
			
			STATE_CACHE_WAIT:
				if ( cache2procresp_val )
									state_next = STATE_CACHE_RESP;
		   else if ( cache2memreq_val )
									state_next = STATE_CACHE_MEM_REQ;

			STATE_CACHE_RESP:
				state_next = STATE_IDLE;
			
			STATE_CACHE_MEM_REQ:
				if ( memreq_rdy)	state_next = STATE_CACHE_MEM_WAIT;

			STATE_CACHE_MEM_WAIT:
				if ( insecure && req_type == `VC_MEM_REQ_MSG_TYPE_PRELW)	   
									state_next = STATE_PREFETCH_MEM_RESP;
		   else if ( insecure )
									state_next = STATE_CACHE_WAIT;
		   else if ( memresp_val && req_type == `VC_MEM_REQ_MSG_TYPE_PRELW )
									state_next = STATE_PREFETCH_MEM_RESP;
		   else if ( memresp_val )	state_next = STATE_CACHE_MEM_RESP;	

			STATE_CACHE_MEM_RESP:
				state_next = STATE_CACHE_WAIT;
			
			STATE_PREFETCH_MEM_RESP:
				state_next = STATE_PREFETCH_WAIT;

			STATE_CH_CTRLREG:
				state_next = STATE_IDLE;
	
			STATE_EMPTY_RESP:
				state_next = STATE_IDLE;
		endcase
	end

	//----------------------------------------------------------------------
	// State Outputs
	//----------------------------------------------------------------------
	
	reg [`VC_MEM_REQ_MSG_NBITS(o,abw,clw)-1:0]		req_msg_extend;
	reg [`VC_MEM_REQ_MSG_NBITS(o,abw,dbw)-1:0]		req_msg;
	reg	[`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-1:0]	req_addr;
	reg [`VC_MEM_REQ_MSG_DATA_NBITS(o,abw,dbw)-1:0]	req_data;
	reg [`VC_MEM_RESP_MSG_NBITS(o,clw)-1:0]			resp_msg;
	reg												resp_domain;
	reg												cur_domain;

	wire [`VC_MEM_REQ_MSG_TYPE_NBITS(o,abw,dbw)-1:0]req_type;
	wire [`VC_MEM_RESP_MSG_NBITS(o,dbw)-1:0] fake_resp_msg;

	assign req_type = req_msg[`VC_MEM_REQ_MSG_TYPE_FIELD(o,abw,dbw)];
	vc_MemReq2Resp#(o,abw,dbw) Req2Reso_trans
	(
		.req  (req_msg),
		.resp (fake_resp_msg)
	);

	// register corresponding data
	always @(posedge clk) begin
		if ( state_reg == STATE_IDLE && procreq_val ) begin
			req_msg_extend <= procreq_msg_extend;
			req_msg		   <= procreq_msg;
			req_addr	   <= procreq_msg[`VC_MEM_REQ_MSG_ADDR_FIELD(o,abw,dbw)];
			req_data	   <= procreq_msg[`VC_MEM_REQ_MSG_DATA_FIELD(o,abw,dbw)];
			cur_domain	   <= procreq_domain; 
		end

		else if ( state_reg == STATE_CACHE_WAIT ) begin
			req_msg_extend <= cache2memreq_msg;
			req_msg		   <= req_msg;
			req_addr	   <= req_addr;
			req_data	   <= req_data;
			cur_domain	   <= cur_domain;
		end

		else begin
			req_msg_extend <= req_msg_extend;
			req_msg		   <= req_msg;
			req_addr	   <= req_addr;
			req_data	   <= req_data;
			cur_domain     <= cur_domain;
		end
	end

	always @(posedge clk) begin
		if ( state_reg == STATE_DIR_MEM_WAIT && memresp_val ) begin
			resp_msg    <= memresp_msg;		
			resp_domain <= memresp_domain;
		end
		
		else if ( state_reg == STATE_CACHE_MEM_WAIT && memresp_val ) begin
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
		procresp_domain = cur_domain;
		memreq_msg		= 'hx;
		memreq_domain	= 1'hx;
		memreq_val		= 1'b0;
		memresp_rdy		= 1'b1;

		case ( state_reg )

			STATE_IDLE: begin
				procreq_rdy			= 1'b1;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;	
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_REQ_TYPE: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;	
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_PREFETCH_REQ: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_msg  = req_msg;
				proc2prebufreq_val  = 1'b1;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;	
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_PREFETCH_WAIT: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;	
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_PREFETCH_RESP: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= prebuf2procresp_msg;
				procresp_val		= 1'b1;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;	
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_SEC_CHECK: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_DIR_MEM_REQ: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				memreq_msg			= req_msg_extend;
				memreq_domain		= cur_domain;
				memreq_val			= 1'b1;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_DIR_MEM_WAIT: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				memreq_msg			= 'hx;
				memreq_domain		= 1'b0;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_DIR_MEM_RESP: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= memresp_msg_simple;
				procresp_val		= 1'b1;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_CACHE_REQ: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				proc2cachereq_msg	= req_msg;
			    proc2cachereq_domain= procreq_domain;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;
				proc2cachereq_val	= 1'b1;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_CACHE_WAIT: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				proc2cachereq_msg	= 'hx;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;
				proc2cachereq_val	= 1'b0;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end
			
			STATE_CACHE_RESP: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= cache2procresp_msg;
				procresp_val		= 1'b1;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;
				proc2cachereq_val	= 1'b0;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_CACHE_MEM_REQ: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				memreq_msg			= req_msg_extend;
				memreq_domain		= cur_domain;
				memreq_val			= 1'b1;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;
				proc2cachereq_val	= 1'b0;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_CACHE_MEM_WAIT: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				memreq_msg			= 'hx;
				memreq_domain		= 1'bx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;
				proc2cachereq_val	= 1'b0;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

			STATE_CACHE_MEM_RESP: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				mem2cacheresp_msg	 = resp_msg;
				mem2cacheresp_val	 = 1'b1;
				mem2cacheresp_domain = resp_domain;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;
				proc2cachereq_val	= 1'b0;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
			end

			STATE_PREFETCH_MEM_RESP: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= 'hx;
				procresp_val		= 1'b0;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				mem2prebufresp_msg	= resp_msg;
				mem2prebufresp_val  = 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
				proc2cachereq_val	= 1'b0;	
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
			end

			STATE_CH_CTRLREG: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= fake_resp_msg;
				procresp_val		= 1'b1;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;	
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
				cache_control_reg	= req_data;
			end

			STATE_EMPTY_RESP: begin
				procreq_rdy			= 1'b0;
				procresp_msg		= fake_resp_msg;
				procresp_val		= 1'b1;
				memreq_msg			= 'hx;
				memreq_domain		= 1'hx;
				memreq_val			= 1'b0;
				memresp_rdy			= 1'b1;
				proc2prebufreq_val  = 1'b0;
				prebuf2procresp_rdy = 1'b1;
			    prebuf2memreq_rdy	= 1'b1;
			    mem2prebufresp_val  = 1'b0;	
				proc2cachereq_val	= 1'b0;
				cache2procresp_rdy	= 1'b1;
				cache2memreq_rdy	= 1'b1;
				mem2cacheresp_val	= 1'b0;
			end

		endcase
	end

	// fail signal
	always @(*) begin
		if ( insecure )
			fail = 1'b1;
		else if ( state_reg === STATE_IDLE )
			fail = 1'b0;
	end	

// Debug Logic
always @(cache_control_reg) begin
	$display("The control register value is %h set by %h", cache_control_reg, cur_domain);
end

endmodule
`endif 


