//=========================================================================
// Blocking Cache Controller
//=========================================================================

`ifndef PLAB3_MEM_BLOCKING_CACHE_SEC_V
`define PLAB3_MEM_BLOCKING_CACHE_SEC_V

`include "plab3-mem-BlockingCacheAlt.v"
`include "plab5-mcore-proc2mem-trans.v"

module plab3_mem_BlockingCacheSec
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

	reg	cache_control_reg = 1'b1;

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
		.cachereq_domain	(proc2cachereq_domain),
		.cachereq_rdy		(proc2cachereq_rdy),

		.cacheresp_msg		(cache2procresp_msg),
		.cacheresp_val		(cache2procresp_val),
		.cacheresp_domain	(cache2procresp_domain),
		.cacheresp_rdy		(cache2procresp_rdy),

		.memreq_msg			(cache2memreq_msg),
		.memreq_val			(cache2memreq_val),
		.memreq_domain		(cache2memreq_domain),
		.memreq_rdy			(cache2memreq_rdy),

		.insecure			(insecure),
		.memresp_msg		(mem2cacheresp_msg),
		.memresp_val		(mem2cacheresp_val),
		.memresp_domain		(mem2cacheresp_domain),
		.memresp_rdy		(mem2cacheresp_rdy)
	);

	// Use a gt comparator to check the current request is cacheable or not
	wire	secure;
	
	vc_GEtComparator #(1) sec_checker
	(
		.in0		(procreq_domain),
		.in1		(cache_control_reg),
		.out		(secure)
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

		.mem_resp_msg	(memresp_msg),
		.proc_resp_msg	(memresp_msg_simple)
	);

	//  Reset control signal when reset signal is high
	always @(*)	begin
		if ( reset ) begin
			procreq_rdy	 = 1'b1;
			procresp_val = 1'b0;
			memreq_val	 = 1'b0;
			memresp_rdy  = 1'b1;

			proc2cachereq_val  = 1'b0;
			cache2procresp_rdy = 1'b0;
			cache2memreq_rdy   = 1'b0;
			mem2cacheresp_val  = 1'b0;
		end	
	end

	//  When there are requests from processor, based on the secure signal 
	//  to determine processor request should be sent to caches or 
	//  the main memory
	always @(posedge clk) begin

		// if secure, processor requests should be sent to caches, 
		// Otherwise, it will be directly passed to the main memory
		if ( secure ) begin 
			proc2cachereq_msg	 = procreq_msg;
			proc2cachereq_val	 = procreq_val;
			proc2cachereq_domain = procreq_domain;
			procreq_rdy	= proc2cachereq_rdy;
		end

		else begin
			memreq_msg	  = procreq_msg_extend;
			memreq_val	  = procreq_val;
			memreq_domain = procreq_domain;
			procreq_rdy = memreq_rdy;
			proc2cachereq_val = 1'b0;
		end
	end

	// When there are responses from memory, based on the secure signal
	// to determine memory response should be sent to caches or directly
	// return to processors
	always @(posedge clk) begin 

		// if secure, memory responses should be sent to caches,
		// Otherwise, it will be dircectly passed to processors
		if ( secure ) begin
			mem2cacheresp_msg	 = memresp_msg;
			mem2cacheresp_val	 = memresp_val;
			mem2cacheresp_domain = memresp_domain;
			memresp_rdy	= mem2cacheresp_domain;
		end

		else begin
			procresp_msg	= memresp_msg_simple;
			procresp_val	= memresp_val;
			procresp_domain	= memresp_domain;
			memresp_rdy		= procresp_rdy;	
			mem2cacheresp_val = 1'b0;
		end
	end

	// If there are requests from cache to memory, unconditionaly pass
	always @(*) begin

		if ( cache2memreq_val ) begin

			memreq_msg		= cache2memreq_msg;
			memreq_val		= cache2memreq_val;
			memreq_domain	= cache2memreq_domain;
			cache2memreq_rdy = memreq_rdy;

		end
	end

	// If there are responses from cache to processor, unconditionally 
	// pass
	always @(*) begin

		if ( cache2procresp_val ) begin

			procresp_msg	= cache2procresp_msg;
			procresp_val	= cache2procresp_val;
			procresp_domain = cache2procresp_domain;
			cache2procresp_rdy = procresp_rdy;
		
		end
	end


endmodule

`endif


