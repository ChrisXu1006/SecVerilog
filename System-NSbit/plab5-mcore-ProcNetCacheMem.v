//========================================================================
// 2-Cores Processor-Network-Cache-Memory
//========================================================================

`ifndef PLAB5_MCORE_PROC_NET_CACHE_MEM_V
`define PLAB5_MCORE_PROC_NET_CACHE_MEM_V
`define PLAB4_NET_NUM_PORTS_2

`include "vc-mem-msgs.v"
`include "plab2-proc-PipelinedProcBypass.v"
`include "plab2-proc-PIC.v"
`include "plab3-mem-BlockingCacheSec.v"
`include "plab3-mem-BlockingCacheSec-FSM.v"
`include "plab3-mem-BlockingCacheSec-FSM1.v"
`include "plab3-mem-BlockingCacheAlt-sectag.v"
`include "plab5-mcore-define.v"
`include "plab5-mcore-proc-acc.v"
`include "plab5-mcore-proc-acc-insecure.v"
`include "plab5-mcore-mem-addr-ctrl.v"
`include "plab5-mcore-mem-addr-ctrl-FSM.v"
`include "plab5-mcore-MemNet-sep.v"
`include "plab5-mcore-TestMem_uni.v"

module plab5_mcore_ProcNetCacheMem
#(
	parameter	p_mem_nbytes  = 1 << 16,
	parameter	p_inst_nbytes = 256,
	parameter	p_data_nbytes = 256,

	parameter	p_num_cores	= 2,

	// local params not meant to be set from outside
	
	parameter	c_opaque_nbits	= 8,
	parameter	c_addr_nbits	= 32,
	parameter	c_data_nbits	= 32,
	parameter	c_memline_nbits	= 128,

	// short name for local params, more convenient for following code
	parameter	o	= c_opaque_nbits,
	parameter	a	= c_addr_nbits,
	parameter	d	= c_data_nbits,
	parameter	l	= c_memline_nbits

)
(
	input	clk,
	input	reset,

	input	mem_clear,

	// proc0 manager ports
	
	input	[31:0]	proc0_from_mngr_msg,
	input			proc0_from_mngr_val,
	output			proc0_from_mngr_rdy,

	output	[31:0]	proc0_to_mngr_msg,
	output			proc0_to_mngr_val,
	input			proc0_to_mngr_rdy,

	output			stats_en_proc0,

	// proc1 manager ports
	
	input	[31:0]	proc1_from_mngr_msg,
	input			proc1_from_mngr_val,
	output			proc1_from_mngr_rdy,

	output	[31:0]	proc1_to_mngr_msg,
	output			proc1_to_mngr_val,
	input			proc1_to_mngr_rdy,

	output			stats_en_proc1

);

	// processor message sizes
	
	localparam c_procreq_nbits	= `VC_MEM_REQ_MSG_NBITS(o,a,d);
	localparam c_procresp_nbits	= `VC_MEM_RESP_MSG_NBITS(o,d);

	// short name for the memory message sizes
	
	localparam prq	= c_procreq_nbits;
	localparam prs	= c_procresp_nbits;

	localparam crq	= `VC_MEM_REQ_MSG_NBITS(o,a,d);
	localparam crqc = `VC_MEM_REQ_MSG_NBITS(o,a,d) - d;
	localparam crqd = d;
	localparam crs	= `VC_MEM_RESP_MSG_NBITS(o,d);
	localparam crsc = `VC_MEM_RESP_MSG_NBITS(o,d) - d;
	localparam crsd = d;

	localparam mrq	= `VC_MEM_REQ_MSG_NBITS(o,a,l);
	localparam mrqc	= `VC_MEM_REQ_MSG_NBITS(o,a,l) - l;
	localparam mrqd	= l;
	localparam mrs	= `VC_MEM_RESP_MSG_NBITS(o,l);
	localparam mrsc	= `VC_MEM_RESP_MSG_NBITS(o,l) - l;
	localparam mrsd	= l;

	// define processor name
	
	`define PLAB5_MCORE_PROC0 proc0
	`define PLAB5_MCORE_PROC1 proc1

	// define processor wires
	
	// wires connected to processor0
	
	wire	[prq-1:0]	inst_net_req_in_msg_proc_d0;
	wire				inst_net_req_in_val_d0;
	wire				inst_net_req_in_rdy_d0;

	wire	[prs-1:0]	inst_proc_resp_out_msg_proc_d0;
	wire				inst_proc_resp_out_val_d0;
	wire				inst_proc_resp_out_rdy_d0;

	wire	[prq-1:0]	data_net_req_in_msg_proc_d0;
	wire				data_net_req_in_val_d0;
	wire				data_net_req_in_rdy_d0;

	wire	[prs-1:0]	data_proc_resp_out_msg_proc_d0;
	wire				data_proc_resp_out_val_d0;
	wire				data_proc_resp_out_rdy_d0;

	wire				cacheable_p0;
	wire				req_in_domain_d0;
	
	wire				par_en_p0;
	wire	[31:0]		par_addr_p0;		

	wire				intr_rq_p0;
	wire				intr_set_p0;
	wire				intr_ack_p0;
	wire				intr_val_p0;

	// wires connected to processor1
	
	wire	[prq-1:0]	inst_net_req_in_msg_proc_d1;
	wire				inst_net_req_in_domain_d1;
	wire				inst_net_req_in_val_d1;
	wire				inst_net_req_in_rdy_d1;

	wire	[prs-1:0]	inst_proc_resp_out_msg_proc_d1;
	wire				inst_proc_resp_out_val_d1;
	wire				inst_proc_resp_out_rdy_d1;

	wire	[prq-1:0]	data_net_req_in_msg_proc_d1;
	wire				data_net_req_in_val_d1;
	wire				data_net_req_in_rdy_d1;

	wire	[prs-1:0]	data_proc_resp_out_msg_proc_d1;
	wire				data_proc_resp_out_val_d1;
	wire				data_proc_resp_out_rdy_d1;

	wire				cacheable_p1;
	wire				req_in_domain_d1;
	
	wire				par_en_p1;
	wire	[31:0]		par_addr_p1;

	wire				intr_rq_p1;
	wire				intr_set_p1;
	wire				intr_ack_p1;
	wire				intr_val_p1;

	// Processor module claim
	
	plab2_proc_PipelinedProcBypass
	#(
		.p_num_cores	(p_num_cores),
		.p_core_id		(0),
		.c_reset_vector	(32'h1000)
	)
	proc0
	(
		.clk			(clk),
		.reset			(reset),

		.sec_domain		(1'b0),
		.req_domain		(req_in_domain_d0),

		.intr_rq		(intr_rq_p0),
		.intr_set		(intr_set_p0),
		.intr_ack		(intr_ack_p0),
		.intr_val		(intr_val_p0),

		.cacheable		(cacheable_p0),

		.par_en			(par_en_p0),
		.par_addr		(par_addr_p0),
		
		.imemreq_msg	(inst_net_req_in_msg_proc_d0),
		.imemreq_val	(inst_net_req_in_val_d0),
		.imemreq_rdy	(inst_net_req_in_rdy_d0),

		.imemresp_msg	(inst_proc_resp_out_msg_proc_d0),
		.imemresp_val	(inst_proc_resp_out_val_d0),
		.imemresp_rdy	(inst_proc_resp_out_rdy_d0),

		.dmemreq_msg	(data_net_req_in_msg_proc_d0),
		.dmemreq_val	(data_net_req_in_val_d0),
		.dmemreq_rdy	(data_net_req_in_rdy_d0),

		.dmemresp_msg	(data_proc_resp_out_msg_proc_d0),
		.dmemresp_val	(data_proc_resp_out_val_d0),
		.dmemresp_rdy	(data_proc_resp_out_rdy_d0),

		.from_mngr_msg	(proc0_from_mngr_msg),
		.from_mngr_val	(proc0_from_mngr_val),
		.from_mngr_rdy	(proc0_from_mngr_rdy),

		.to_mngr_msg	(proc0_to_mngr_msg),
		.to_mngr_val	(proc0_to_mngr_val),
		.to_mngr_rdy	(proc0_to_mngr_rdy),

		.stats_en		(stats_en_proc0)
	);

	plab2_proc_PipelinedProcBypass
	#(
		.p_num_cores	(p_num_cores),
		.p_core_id		(1),
		.c_reset_vector	(32'h2000)
	)
	proc1
	(
		.clk			(clk),
		.reset			(reset),

		.sec_domain		(1'b1),
		.req_domain		(req_in_domain_d1),

		.intr_rq		(intr_rq_p1),
		.intr_set		(intr_set_p1),
		.intr_ack		(intr_ack_p1),
		.intr_val		(intr_val_p1),

		.cacheable		(cacheable_p1),

		.par_en			(par_en_p1),
		.par_addr		(par_addr_p1),
		
		.imemreq_msg	(inst_net_req_in_msg_proc_d1),
		.imemreq_val	(inst_net_req_in_val_d1),
		.imemreq_rdy	(inst_net_req_in_rdy_d1),

		.imemresp_msg	(inst_proc_resp_out_msg_proc_d1),
		.imemresp_val	(inst_proc_resp_out_val_d1),
		.imemresp_rdy	(inst_proc_resp_out_rdy_d1),

		.dmemreq_msg	(data_net_req_in_msg_proc_d1),
		.dmemreq_val	(data_net_req_in_val_d1),
		.dmemreq_rdy	(data_net_req_in_rdy_d1),

		.dmemresp_msg	(data_proc_resp_out_msg_proc_d1),
		.dmemresp_val	(data_proc_resp_out_val_d1),
		.dmemresp_rdy	(data_proc_resp_out_rdy_d1),

		.from_mngr_msg	(proc1_from_mngr_msg),
		.from_mngr_val	(proc1_from_mngr_val),
		.from_mngr_rdy	(proc1_from_mngr_rdy),

		.to_mngr_msg	(proc1_to_mngr_msg),
		.to_mngr_val	(proc1_to_mngr_val),
		.to_mngr_rdy	(proc1_to_mngr_rdy),

		.stats_en		(stats_en_proc1)
	);

	// Programmable Interrupt Handler
	plab2_proc_PIC PIC
	(
		.clk			(clk),
		.reset			(reset),

		.intr_rq_p0		(intr_rq_p0),
		.intr_rq_p1		(intr_rq_p1),
		.intr_set_p0	(intr_set_p0),
		.intr_set_p1	(intr_set_p1),
		
		.intr_ack_p0	(intr_ack_p0),
		.intr_ack_p1	(intr_ack_p1),
		.intr_val_p0	(intr_val_p0),
		.intr_val_p1	(intr_val_p1)
	);

	// network wires
	wire   inst_net_resp_out_domain_d0;
	wire   inst_net_resp_out_domain_d1;
	wire   data_net_resp_out_domain_d0;
	wire   data_net_resp_out_domain_d1;

	wire [prs-1:0]	inst_net_resp_out_msg_proc_d0;
	wire			inst_net_resp_out_val_d0;
	wire			inst_net_resp_out_rdy_d0;

	wire [prs-1:0]	inst_net_resp_out_msg_proc_d1;
	wire			inst_net_resp_out_val_d1;
	wire			inst_net_resp_out_rdy_d1;

	wire [prs-1:0]	data_net_resp_out_msg_proc_d0;
	wire			data_net_resp_out_val_d0;
	wire			data_net_resp_out_rdy_d0;

	wire [prs-1:0]	data_net_resp_out_msg_proc_d1;
	wire			data_net_resp_out_val_d1;
	wire			data_net_resp_out_rdy_d1;

	// processor0 instruction response access control
	`ifdef PROC_ACC_SECURE
		plab5_mcore_proc_resp_acc
	`elsif PROC_ACC_INSECURE
		plab5_mcore_proc_resp_acc_insecure
	`endif
	#(
		.p_opaque_nbits		(o),
		.p_addr_nbits		(a),
		.p_data_nbits		(d)
	)
	inst_resp_acc_p0
	(
		.clk				(clk),
		.resp_sec_level		(inst_net_resp_out_domain_d0),
		.proc_sec_level		(req_in_domain_d0),

		.net_resp_val		(inst_net_resp_out_val_d0),
		.net_resp_rdy		(inst_net_resp_out_rdy_d0),
		.net_resp_msg		(inst_net_resp_out_msg_proc_d0),

		.proc_resp_val		(inst_proc_resp_out_val_d0),
		.proc_resp_rdy		(inst_proc_resp_out_rdy_d0),
		.proc_resp_msg		(inst_proc_resp_out_msg_proc_d0)
	);

	// processor1 instruction response access control
	`ifdef PROC_ACC_SECURE
		plab5_mcore_proc_resp_acc
	`elsif PROC_ACC_INSECURE
		plab5_mcore_proc_resp_acc_insecure
	`endif
	#(
		.p_opaque_nbits		(o),
		.p_addr_nbits		(a),
		.p_data_nbits		(d)
	)
	inst_resp_acc_p1
	(
		.clk				(clk),
		.resp_sec_level		(inst_net_resp_out_domain_d1),
		.proc_sec_level		(req_in_domain_d1),

		.net_resp_val		(inst_net_resp_out_val_d1),
		.net_resp_rdy		(inst_net_resp_out_rdy_d1),
		.net_resp_msg		(inst_net_resp_out_msg_proc_d1),

		.proc_resp_val		(inst_proc_resp_out_val_d1),
		.proc_resp_rdy		(inst_proc_resp_out_rdy_d1),
		.proc_resp_msg		(inst_proc_resp_out_msg_proc_d1)
	);

	// processor0 data response access control
	`ifdef PROC_ACC_SECURE
		plab5_mcore_proc_resp_acc
	`elsif PROC_ACC_INSECURE
		plab5_mcore_proc_resp_acc_insecure
	`endif
	#(
		.p_opaque_nbits		(o),
		.p_addr_nbits		(a),
		.p_data_nbits		(d)
	)
	data_resp_acc_p0
	(
		.clk				(clk),
		.resp_sec_level		(data_net_resp_out_domain_d0),
		.proc_sec_level		(req_in_domain_d0),

		.net_resp_val		(data_net_resp_out_val_d0),
		.net_resp_rdy		(data_net_resp_out_rdy_d0),
		.net_resp_msg		(data_net_resp_out_msg_proc_d0),

		.proc_resp_val		(data_proc_resp_out_val_d0),
		.proc_resp_rdy		(data_proc_resp_out_rdy_d0),
		.proc_resp_msg		(data_proc_resp_out_msg_proc_d0)
	);

	// processor1 data response access control
	`ifdef PROC_ACC_SECURE
		plab5_mcore_proc_resp_acc
	`elsif PROC_ACC_INSECURE
		plab5_mcore_proc_resp_acc_insecure
	`endif
	#(
		.p_opaque_nbits		(o),
		.p_addr_nbits		(a),
		.p_data_nbits		(d)
	)
	data_resp_acc_p1
	(
		.clk				(clk),
		.resp_sec_level		(data_net_resp_out_domain_d1),
		.proc_sec_level		(req_in_domain_d1),

		.net_resp_val		(data_net_resp_out_val_d1),
		.net_resp_rdy		(data_net_resp_out_rdy_d1),
		.net_resp_msg		(data_net_resp_out_msg_proc_d1),

		.proc_resp_val		(data_proc_resp_out_val_d1),
		.proc_resp_rdy		(data_proc_resp_out_rdy_d1),
		.proc_resp_msg		(data_proc_resp_out_msg_proc_d1)
	);
	
	// declare cache-related wires
	// req0/resp0 connected to router0, req1/resp1 connected to router1
	
	wire	[crqc-1:0]		inst_cachereq0_control;
	wire	[crqd-1:0]		inst_cachereq0_data;
	wire					inst_cachereq0_val;
	wire					inst_cachereq0_rdy;
	wire					inst_cachereq0_domain;

	wire	[crsc-1:0]		inst_cacheresp0_control;
	wire	[crsd-1:0]		inst_cacheresp0_data;
	wire					inst_cacheresp0_val;
	wire					inst_cacheresp0_rdy;
	wire					inst_cacheresp0_domain;

	wire	[crqc-1:0]		inst_cachereq1_control;
	wire	[crqd-1:0]		inst_cachereq1_data;
	wire					inst_cachereq1_val;
	wire					inst_cachereq1_rdy;
	wire					inst_cachereq1_domain;

	wire	[crsc-1:0]		inst_cacheresp1_control;
	wire	[crsd-1:0]		inst_cacheresp1_data;
	wire					inst_cacheresp1_val;
	wire					inst_cacheresp1_rdy;
	wire					inst_cacheresp1_domain;

	wire	[crqc-1:0]		data_cachereq0_control;
	wire	[crqd-1:0]		data_cachereq0_data;
	wire					data_cachereq0_val;
	wire					data_cachereq0_rdy;
	wire					data_cachereq0_domain;

	wire	[crsc-1:0]		data_cacheresp0_control;
	wire	[crsd-1:0]		data_cacheresp0_data;
	wire					data_cacheresp0_val;
	wire					data_cacheresp0_rdy;
	wire					data_cacheresp0_domain;

	wire	[crqc-1:0]		data_cachereq1_control;
	wire	[crqd-1:0]		data_cachereq1_data;
	wire					data_cachereq1_val;
	wire					data_cachereq1_rdy;
	wire					data_cachereq1_domain;

	wire	[crsc-1:0]		data_cacheresp1_control;
	wire	[crsd-1:0]		data_cacheresp1_data;
	wire					data_cacheresp1_val;
	wire					data_cacheresp1_rdy;
	wire					data_cacheresp1_domain;

	//assign  inst_cacheresp0_domain = inst_cachereq0_domain;
	//assign  data_cacheresp0_domain = data_cachereq0_domain;

	assign  inst_cachereq1_rdy	= 1;
	assign	inst_cacheresp1_val = 1;
	assign  data_cachereq1_rdy	= 1;
	assign  data_cacheresp1_val = 1;

	// inst refill net

	plab5_mcore_MemNet_Sep
	#(
		.p_mem_opaque_nbits			(o),
		.p_mem_addr_nbits			(a),
		.p_mem_data_nbits			(d),

		.p_num_ports				(p_num_cores),

		.p_single_bank				(1)
	)
	inst_net
	(
		.clk						(clk),
		.reset						(reset),

		.mode						(1'b0),

		.req_in_msg_p0				(inst_net_req_in_msg_proc_d0),
		.req_in_domain_p0			(req_in_domain_d0),
		.req_in_val_p0				(inst_net_req_in_val_d0),
		.req_in_rdy_p0				(inst_net_req_in_rdy_d0),

		.req_out_msg_control_p0		(inst_cachereq0_control),
		.req_out_msg_data_p0		(inst_cachereq0_data),
		.req_out_domain_p0			(inst_cachereq0_domain),
		.req_out_val_p0				(inst_cachereq0_val),
		.req_out_rdy_p0				(inst_cachereq0_rdy),

		.resp_in_msg_control_p0		(inst_cacheresp0_control),
		.resp_in_msg_data_p0		(inst_cacheresp0_data),
		.resp_in_domain_p0			(inst_cacheresp0_domain),
		.resp_in_val_p0				(inst_cacheresp0_val),
		.resp_in_rdy_p0				(inst_cacheresp0_rdy),

		.resp_out_msg_p0			(inst_net_resp_out_msg_proc_d0),
		.resp_out_domain_p0			(inst_net_resp_out_domain_d0),
		.resp_out_val_p0			(inst_net_resp_out_val_d0),
		.resp_out_rdy_p0			(inst_net_resp_out_rdy_d0),

		.req_in_msg_p1				(inst_net_req_in_msg_proc_d1),
		.req_in_domain_p1			(req_in_domain_d1),
		.req_in_val_p1				(inst_net_req_in_val_d1),
		.req_in_rdy_p1				(inst_net_req_in_rdy_d1),

		.req_out_msg_control_p1		(inst_cachereq1_control),
		.req_out_msg_data_p1		(inst_cachereq1_data),
		.req_out_domain_p1			(inst_cachereq1_domain),
		.req_out_val_p1				(inst_cachereq1_val),
		.req_out_rdy_p1				(inst_cachereq1_rdy),

		.resp_in_msg_control_p1		(inst_cacheresp1_control),
		.resp_in_msg_data_p1		(inst_cacheresp1_data),
		.resp_in_domain_p1			(inst_cacheresp1_domain),
		.resp_in_val_p1				(inst_cacheresp1_val),
		.resp_in_rdy_p1				(inst_cacheresp1_rdy),

		.resp_out_msg_p1			(inst_net_resp_out_msg_proc_d1),
		.resp_out_domain_p1			(inst_net_resp_out_domain_d1),
		.resp_out_val_p1			(inst_net_resp_out_val_d1),
		.resp_out_rdy_p1			(inst_net_resp_out_rdy_d1)

	);

	plab5_mcore_MemNet_Sep
	#(
		.p_mem_opaque_nbits			(o),
		.p_mem_addr_nbits			(a),
		.p_mem_data_nbits			(d),

		.p_num_ports				(p_num_cores),

		.p_single_bank				(1)
	)
	data_net
	(
		.clk						(clk),
		.reset						(reset),

		.mode						(1'b1),

		.req_in_msg_p0				(data_net_req_in_msg_proc_d0),
		.req_in_domain_p0			(req_in_domain_d0),
		.req_in_val_p0				(data_net_req_in_val_d0),
		.req_in_rdy_p0				(data_net_req_in_rdy_d0),

		.req_out_msg_control_p0		(data_cachereq0_control),
		.req_out_msg_data_p0		(data_cachereq0_data),
		.req_out_domain_p0			(data_cachereq0_domain),
		.req_out_val_p0				(data_cachereq0_val),
		.req_out_rdy_p0				(data_cachereq0_rdy),

		.resp_in_msg_control_p0		(data_cacheresp0_control),
		.resp_in_msg_data_p0		(data_cacheresp0_data),
		.resp_in_domain_p0			(data_cacheresp0_domain),
		.resp_in_val_p0				(data_cacheresp0_val),
		.resp_in_rdy_p0				(data_cacheresp0_rdy),

		.resp_out_msg_p0			(data_net_resp_out_msg_proc_d0),
		.resp_out_domain_p0			(data_net_resp_out_domain_d0),
		.resp_out_val_p0			(data_net_resp_out_val_d0),
		.resp_out_rdy_p0			(data_net_resp_out_rdy_d0),

		.req_in_msg_p1				(data_net_req_in_msg_proc_d1),
		.req_in_domain_p1			(req_in_domain_d1),
		.req_in_val_p1				(data_net_req_in_val_d1),
		.req_in_rdy_p1				(data_net_req_in_rdy_d1),

		.req_out_msg_control_p1		(data_cachereq1_control),
		.req_out_msg_data_p1		(data_cachereq1_data),
		.req_out_domain_p1			(data_cachereq1_domain),
		.req_out_val_p1				(data_cachereq1_val),
		.req_out_rdy_p1				(data_cachereq1_rdy),

		.resp_in_msg_control_p1		(data_cacheresp1_control),
		.resp_in_msg_data_p1		(data_cacheresp1_data),
		.resp_in_domain_p1			(data_cacheresp1_domain),
		.resp_in_val_p1				(data_cacheresp1_val),
		.resp_in_rdy_p1				(data_cacheresp1_rdy),

		.resp_out_msg_p1			(data_net_resp_out_msg_proc_d1),
		.resp_out_domain_p1			(data_net_resp_out_domain_d1),
		.resp_out_val_p1			(data_net_resp_out_val_d1),
		.resp_out_rdy_p1			(data_net_resp_out_rdy_d1)

	);

	// declare cache's wires
	
	wire [`VC_MEM_REQ_MSG_NBITS(o,a,d)-1:0]	inst_cachereq0_msg;
	wire [`VC_MEM_RESP_MSG_NBITS(o,d)-1:0]	inst_cacheresp0_msg;
	wire [`VC_MEM_REQ_MSG_NBITS(o,a,d)-1:0]	data_cachereq0_msg;
	wire [`VC_MEM_RESP_MSG_NBITS(o,d)-1:0]	data_cacheresp0_msg;

	wire [`VC_MEM_REQ_MSG_NBITS(o,a,l)-1:0]	inst_cache2memreq0_msg;
	wire									inst_cache2memreq0_val;
	wire									inst_cache2memreq0_rdy;

	wire [`VC_MEM_RESP_MSG_NBITS(o,l)-1:0]	inst_mem2cacheresp0_msg;
	wire									inst_mem2cacheresp0_val;
	wire									inst_mem2cacheresp0_rdy;

	wire [`VC_MEM_REQ_MSG_NBITS(o,a,l)-1:0] data_cache2memreq0_msg;
	wire									data_cache2memreq0_val;
	wire									data_cache2memreq0_rdy;

	wire [`VC_MEM_RESP_MSG_NBITS(o,l)-1:0]	data_mem2cacheresp0_msg;	
	wire									data_mem2cacheresp0_val;
	wire									data_mem2cacheresp0_rdy;

	// combine control and data signal to be one big message signal
	// to caches, or split message signal into control and data signals
	assign inst_cachereq0_msg  = {inst_cachereq0_control, inst_cachereq0_data};
	assign data_cachereq0_msg  = {data_cachereq0_control, data_cachereq0_data};
	assign {inst_cacheresp0_control, inst_cacheresp0_data} = inst_cacheresp0_msg;
	assign {data_cacheresp0_control, data_cacheresp0_data} = data_cacheresp0_msg;

	// shared instruction cache
	
	/*plab3_mem_BlockingCacheSec_fsm1
	#(
		.mode			    (0),
		.p_mem_nbytes		(p_inst_nbytes),
		.p_num_banks		(1),
		.p_opaque_nbits		(o)
	)
	icache
	(
		.clk				(clk),
		.reset				(reset),

		//.cacheable			(1'b1),

		.procreq_msg		(inst_cachereq0_msg),
		.procreq_val		(inst_cachereq0_val),
		.procreq_domain		(inst_cachereq0_domain),
		.procreq_rdy		(inst_cachereq0_rdy),

		.procresp_msg		(inst_cacheresp0_msg),
		.procresp_val		(inst_cacheresp0_val),
		.procresp_domain	(inst_cacheresp0_domain),
		.procresp_rdy		(inst_cacheresp0_rdy),

		.memreq_msg			(inst_cache2memreq0_msg),
		.memreq_domain		(inst_cache2memreq0_domain),
		.memreq_val			(inst_cache2memreq0_val),
		.memreq_rdy			(inst_cache2memreq0_rdy),
		
		.insecure			(inst_insecure),
		.memresp_msg		(inst_mem2cacheresp0_msg),
		.memresp_domain		(inst_mem2cacheresp0_domain),
		.memresp_val		(inst_mem2cacheresp0_val),
		.memresp_rdy		(inst_mem2cacheresp0_rdy)
	);*/
    plab3_mem_BlockingCacheAlt_Sectag
	#(
		.mode				(0),
		.p_mem_nbytes		(p_inst_nbytes),
		.p_num_banks		(1),
		.p_opaque_nbits		(o)
	)
	icache
	(
		.clk				(clk),
		.reset				(reset),

		.cachereq_msg		(inst_cachereq0_msg),
		.cachereq_val		(inst_cachereq0_val),
		.cachereq_domain	(inst_cachereq0_domain),
		.cachereq_rdy		(inst_cachereq0_rdy),

		.cacheresp_msg		(inst_cacheresp0_msg),
		.cacheresp_val		(inst_cacheresp0_val),
		.cacheresp_domain	(inst_cacheresp0_domain),
		.cacheresp_rdy		(inst_cacheresp0_rdy),

		.memreq_msg			(inst_cache2memreq0_msg),
		.memreq_domain		(inst_cache2memreq0_domain),
		.memreq_val			(inst_cache2memreq0_val),
		.memreq_rdy			(inst_cache2memreq0_rdy),

		.insecure			(inst_insecure),
		.memresp_msg		(inst_mem2cacheresp0_msg),
		.memresp_domain		(inst_mem2cacheresp0_domain),
		.memresp_val		(inst_mem2cacheresp0_val),
		.memresp_rdy		(inst_mem2cacheresp0_rdy)
	);

	// shared data cache
	//`ifdef CACHE_SECURE
	//	plab3_mem_BlockingCacheAlt
	//`elsif CACHE_INSECURE
	//	plab3_mem_BlockingCacheAlt_insecure
	//`endif
	plab3_mem_BlockingCacheSec_fsm1
	#(
		.mode				(1),
		.p_mem_nbytes		(p_data_nbytes),
		.p_num_banks		(1),
		.p_opaque_nbits		(o)
	)
	dcache
	(
		.clk				(clk),
		.reset				(reset),

		//.cacheable			(cacheable_p0),

		.procreq_msg		(data_cachereq0_msg),
		.procreq_val		(data_cachereq0_val),
		.procreq_domain		(data_cachereq0_domain),
		.procreq_rdy		(data_cachereq0_rdy),

		.procresp_msg		(data_cacheresp0_msg),
		.procresp_val		(data_cacheresp0_val),
		.procresp_domain	(data_cacheresp0_domain),
		.procresp_rdy		(data_cacheresp0_rdy),

		.memreq_msg			(data_cache2memreq0_msg),
		.memreq_domain		(data_cache2memreq0_domain),
		.memreq_val			(data_cache2memreq0_val),
		.memreq_rdy			(data_cache2memreq0_rdy),

		.insecure			(data_insecure),
		.memresp_msg		(data_mem2cacheresp0_msg),
		.memresp_domain		(data_mem2cacheresp0_domain),
		.memresp_val		(data_mem2cacheresp0_val),
		.memresp_rdy		(data_mem2cacheresp0_rdy)
	);
	
   /*plab3_mem_BlockingCacheAlt
   #(
		.mode				(1),
		.p_mem_nbytes		(p_data_nbytes),
		.p_num_banks		(1),
		.p_opaque_nbits		(o)
	)
	dcache
	(
		.clk				(clk),
		.reset				(reset),

		.cachereq_msg		(data_cachereq0_msg),
		.cachereq_val		(data_cachereq0_val),
		.cachereq_domain	(data_cachereq0_domain),
		.cachereq_rdy		(data_cachereq0_rdy),

		.cacheresp_msg		(data_cacheresp0_msg),
		.cacheresp_val		(data_cacheresp0_val),
		.cacheresp_domain	(data_cacheresp0_domain),
		.cacheresp_rdy		(data_cacheresp0_rdy),

		.memreq_msg			(data_cache2memreq0_msg),
		.memreq_domain		(data_cache2memreq0_domain),
		.memreq_val			(data_cache2memreq0_val),
		.memreq_rdy			(data_cache2memreq0_rdy),

		.insecure			(data_insecure),
		.memresp_msg		(data_mem2cacheresp0_msg),
		.memresp_domain		(data_mem2cacheresp0_domain),
		.memresp_val		(data_mem2cacheresp0_val),
		.memresp_rdy		(data_mem2cacheresp0_rdy)
	);*/

	// declare address/access control wire
	
	wire [mrqc-1:0]			inst_cache2memreq0_control;
	wire [mrqd-1:0]			inst_cache2memreq0_data;
	wire					inst_cache2memreq0_domain;

	wire [mrsc-1:0]			inst_mem2cacheresp0_control;
	wire [mrsd-1:0]			inst_mem2cacheresp0_data;
	wire					inst_mem2cacheresp0_domain;

	wire					inst_insecure;

	wire [mrqc-1:0]			data_cache2memreq0_control;
	wire [mrqd-1:0]			data_cache2memreq0_data;
	wire					data_cache2memreq0_domain;

	wire [mrsc-1:0]			data_mem2cacheresp0_control;
	wire [mrsd-1:0]			data_mem2cacheresp0_data;
	wire					data_mem2cacheresp0_domain;

	wire					data_insecure;

	// combine control/data signals into a big whole structure or
	// split a whole signal into control/data signals
	assign {inst_cache2memreq0_control, inst_cache2memreq0_data}
											= inst_cache2memreq0_msg;
	assign {data_cache2memreq0_control, data_cache2memreq0_data}
											= data_cache2memreq0_msg;
	assign	inst_mem2cacheresp0_msg 
			=	{inst_mem2cacheresp0_control, inst_mem2cacheresp0_data};
	assign	data_mem2cacheresp0_msg
			=	{data_mem2cacheresp0_control, data_mem2cacheresp0_data};

	// instruction memory address/access control module

	plab5_mcore_mem_addr_ctrl_fsm
	#(
		.mem_size				(p_mem_nbytes/2),
		.initial_par			(32'h4000),
		.p_opaque_nbits			(o),
		.p_addr_nbits			(a),
		.p_data_nbits			(l)
	)
	inst_mem_addr_ctrl
	(
		.clk					(clk),
		.reset					(reset),

		.par_en					(0),
		.par_addr				(par_addr_p1),
		
		.req_sec_level			(inst_cache2memreq0_domain),
		.resp_sec_level			(inst_mem2cacheresp0_domain),
		.insecure				(inst_insecure),

		.cache2mem_req_control	(inst_cache2memreq0_control),
		.cache2mem_req_data		(inst_cache2memreq0_data),
		.cache2mem_req_val		(inst_cache2memreq0_val),
		.cache2mem_req_rdy		(inst_cache2memreq0_rdy),

		.mem_req_control		(inst_memreq0_control),
		.mem_req_data			(inst_memreq0_data),
		.mem_req_val			(inst_memreq0_val),
		.mem_req_rdy			(inst_memreq0_rdy),

		.mem2cache_resp_control	(inst_mem2cacheresp0_control),
		.mem2cache_resp_data	(inst_mem2cacheresp0_data),
		.mem2cache_resp_val		(inst_mem2cacheresp0_val),
		.mem2cache_resp_rdy		(inst_mem2cacheresp0_rdy),

		.mem_resp_control		(inst_memresp0_control),
		.mem_resp_data			(inst_memresp0_data),
		.mem_resp_val			(inst_memresp0_val),
		.mem_resp_rdy			(inst_memresp0_rdy)
	);

	// data memory address/access control module

	plab5_mcore_mem_addr_ctrl_fsm
	#(
		.mem_size				(p_mem_nbytes/2),
		.initial_par			(32'hc000),
		.p_opaque_nbits			(o),
		.p_addr_nbits			(a),
		.p_data_nbits			(l)
	)
	data_mem_addr_ctrl
	(
		.clk					(clk),
		.reset					(reset),

		.par_en					(par_en_p0),
		.par_addr				(par_addr_p0),
		
		.req_sec_level			(data_cache2memreq0_domain),
		.resp_sec_level			(data_mem2cacheresp0_domain),
		.insecure				(data_insecure),

		.cache2mem_req_control	(data_cache2memreq0_control),
		.cache2mem_req_data		(data_cache2memreq0_data),
		.cache2mem_req_val		(data_cache2memreq0_val),
		.cache2mem_req_rdy		(data_cache2memreq0_rdy),

		.mem_req_control		(data_memreq0_control),
		.mem_req_data			(data_memreq0_data),
		.mem_req_val			(data_memreq0_val),
		.mem_req_rdy			(data_memreq0_rdy),

		.mem2cache_resp_control	(data_mem2cacheresp0_control),
		.mem2cache_resp_data	(data_mem2cacheresp0_data),
		.mem2cache_resp_val		(data_mem2cacheresp0_val),
		.mem2cache_resp_rdy		(data_mem2cacheresp0_rdy),

		.mem_resp_control		(data_memresp0_control),
		.mem_resp_data			(data_memresp0_data),
		.mem_resp_val			(data_memresp0_val),
		.mem_resp_rdy			(data_memresp0_rdy)
	);

	// declare memory's wire
	
	wire [mrqc-1:0]		inst_memreq0_control;
	wire [mrqd-1:0]		inst_memreq0_data;
	wire				inst_memreq0_val;
	wire				inst_memreq0_rdy;
	wire				inst_memreq0_domain;

	wire [mrqc-1:0]		data_memreq0_control;
	wire [mrqd-1:0]		data_memreq0_data;
	wire				data_memreq0_val;
	wire				data_memreq0_rdy;
	wire				data_memreq0_domain;

	wire [mrsc-1:0]		inst_memresp0_control;
	wire [mrsd-1:0]		inst_memresp0_data;
	wire				inst_memresp0_val;
	wire				inst_memresp0_rdy;
	wire				inst_memresp0_domain;

	wire [mrsc-1:0]		data_memresp0_control;
	wire [mrsd-1:0]		data_memresp0_data;
	wire				data_memresp0_val;
	wire				data_memresp0_rdy;
	wire				data_memresp0_domain;

	// shared instruction main memory
	
	plab5_mcore_TestMem_Uni	
	#(
		.p_mem_nbytes	(p_mem_nbytes/4), 
		.p_opaque_nbits	(o), 
		.p_addr_nbits	(a), 
		.p_data_nbits	(l)
	)
	inst_mem
	(
		.clk			(clk),
		.reset			(reset),

		.mode			(0),
		.mem_clear		(mem_clear),

		.memreq_val		(inst_memreq0_val),
		.memreq_rdy		(inst_memreq0_rdy),
		.memreq_control	(inst_memreq0_control),
		.memreq_data	(inst_memreq0_data),
		.memreq_domain	(inst_memreq0_domain),

		.memresp_val	(inst_memresp0_val),
		.memresp_rdy	(inst_memresp0_rdy),
		.memresp_control(inst_memresp0_control),
		.memresp_data	(inst_memresp0_data),
		.memresp_domain	(inst_memresp0_domain)
	);

	// shared data  main memory
	
	plab5_mcore_TestMem_Uni
	#(
		.p_mem_nbytes	(p_mem_nbytes/4),
		.p_opaque_nbits	(o),
		.p_addr_nbits	(a),
		.p_data_nbits	(l)
	)
	data_mem
	(
		.clk			(clk),
		.reset			(reset),

		.mode			(1),
		.mem_clear		(mem_clear),

		.memreq_val		(data_memreq0_val),
		.memreq_rdy		(data_memreq0_rdy),
		.memreq_control	(data_memreq0_control),
		.memreq_data	(data_memreq0_data),
		.memreq_domain	(1),

		.memresp_val	(data_memresp0_val),
		.memresp_rdy	(data_memresp0_rdy),
		.memresp_control(data_memresp0_control),
		.memresp_data	(data_memresp0_data),
		.memresp_domain	(data_memresp0_domain)
	);

endmodule
`endif /* PLAB5_MCORE_PROC_NET_CACHE_MEM_SEP_V */
