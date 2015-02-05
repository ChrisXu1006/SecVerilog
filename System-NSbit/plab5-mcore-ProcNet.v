//========================================================================
// 2-Cores Processor-Network-Memory
//========================================================================

`ifndef PLAB5_MCORE_PROC_NET_V
`define PLAB5_MCORE_PROC_NET_V
`define PLAB4_NET_NUM_PORTS_2

`include "vc-mem-msgs.v"
`include "plab2-proc-PipelinedProcBypass.v"
`include "plab3-mem-BlockingCacheAlt.v"
`include "plab5-mcore-proc2mem-trans.v"
`include "plab5-mcore-MemNet.v"
`include "plab5-mcore-procnet-hub.v"
`include "plab5-mcore-netmem-hub.v"

module plab5_mcore_ProcNet
#(
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
	parameter	l	= c_memline_nbits,

	parameter	c_memreq_nbits	= `VC_MEM_REQ_MSG_NBITS(o,a,l),
	parameter	c_memreq_cnbits	= c_memreq_nbits - l,
	parameter	c_memreq_dnbits	= l,

	parameter	c_memresp_nbits	= `VC_MEM_RESP_MSG_NBITS(o,l),
	parameter	c_memresp_cnbits= c_memresp_nbits - l,
	parameter	c_memresp_dnbits= l
)
(
	input	clk,
	input	reset,

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

	output			stats_en_proc1,

	// ports connected to memory
	// req0 and resp0 are connected to low-paritioned memory
	// req1 and resp1 are connected to high-paritioned memory 
	
	output	[c_memreq_cnbits-1:0]	inst_memreq0_control,
	output	[c_memreq_dnbits-1:0]	inst_memreq0_data,
	output							inst_memreq0_val,
	input							inst_memreq0_rdy,
	output							inst_memreq0_domain,

	input	[c_memresp_cnbits-1:0]	inst_memresp0_control,
	input	[c_memresp_dnbits-1:0]	inst_memresp0_data,
	input							inst_memresp0_val,
	output							inst_memresp0_rdy,
	input							inst_memresp0_domain,

	output	[c_memreq_cnbits-1:0]	inst_memreq1_control,
	output	[c_memreq_dnbits-1:0]	inst_memreq1_data,
	output							inst_memreq1_val,
	input							inst_memreq1_rdy,
	output							inst_memreq1_domain,

	input	[c_memresp_cnbits-1:0]	inst_memresp1_control,
	input	[c_memresp_dnbits-1:0]	inst_memresp1_data,
	input							inst_memresp1_val,
	output							inst_memresp1_rdy,
	input							inst_memresp1_domain,

	output	[c_memreq_cnbits-1:0]	data_memreq0_control,
	output	[c_memreq_dnbits-1:0]	data_memreq0_data,
	output							data_memreq0_val,
	input							data_memreq0_rdy,
	output							data_memreq0_domain,

	input	[c_memresp_cnbits-1:0]	data_memresp0_control,
	input	[c_memresp_dnbits-1:0]	data_memresp0_data,
	input							data_memresp0_val,
	output							data_memresp0_rdy,
	input							data_memresp0_domain,

	output	[c_memreq_cnbits-1:0]	data_memreq1_control,
	output	[c_memreq_dnbits-1:0]	data_memreq1_data,
	output							data_memreq1_val,
	input							data_memreq1_rdy,
	output							data_memreq1_domain,

	input	[c_memresp_cnbits-1:0]	data_memresp1_control,
	input	[c_memresp_dnbits-1:0]	data_memresp1_data,
	input							data_memresp1_val,
	output							data_memresp1_rdy,
	input							data_memresp1_domain

);

	// processor message sizes
	
	localparam c_procreq_nbits	= `VC_MEM_REQ_MSG_NBITS(o,a,d);
	localparam c_procresp_nbits	= `VC_MEM_RESP_MSG_NBITS(o,d);

	// short name for the memory message sizes
	
	localparam prq	= c_procreq_nbits;
	localparam prs	= c_procresp_nbits;

	localparam mrq	= c_memreq_nbits;
	localparam mrqc	= c_memreq_cnbits;
	localparam mrqd	= c_memreq_dnbits;
	localparam mrs	= c_memresp_nbits;
	localparam mrsc	= c_memresp_cnbits;
	localparam mrsd	= c_memresp_dnbits;

	// define processor name
	
	`define PLAB5_MCORE_PROC0 proc0
	`define PLAB5_MCORE_PROC1 proc1

	// define processor wires
	
	// wires connected to processor0
	
	wire	[prq-1:0]	inst_net_req_in_msg_proc_d0;
	wire				inst_net_req_in_val_d0;
	wire				inst_net_req_in_rdy_d0;

	wire	[prs-1:0]	inst_net_resp_out_msg_proc_d0;
	wire				inst_net_resp_out_val_d0;
	wire				inst_net_resp_out_rdy_d0;

	wire	[prq-1:0]	data_net_req_in_msg_proc_d0;
	wire				data_net_req_in_val_d0;
	wire				data_net_req_in_rdy_d0;

	wire	[prs-1:0]	data_net_resp_out_msg_proc_d0;
	wire				data_net_resp_out_val_d0;
	wire				data_net_resp_out_rdy_d0;

	// wires connected to processor1
	
	wire	[prq-1:0]	inst_net_req_in_msg_proc_d1;
	wire				inst_net_req_in_val_d1;
	wire				inst_net_req_in_rdy_d1;

	wire	[prs-1:0]	inst_net_resp_out_msg_proc_d1;
	wire				inst_net_resp_out_val_d1;
	wire				inst_net_resp_out_rdy_d1;

	wire	[prq-1:0]	data_net_req_in_msg_proc_d1;
	wire				data_net_req_in_val_d1;
	wire				data_net_req_in_rdy_d1;

	wire	[prs-1:0]	data_net_resp_out_msg_proc_d1;
	wire				data_net_resp_out_val_d1;
	wire				data_net_resp_out_rdy_d1;

	// Processor module claim
	
	plab2_proc_PipelinedProcBypass
	#(
		.p_num_cores	(p_num_cores),
		.p_core_id		(0)
	)
	proc0
	(
		.clk			(clk),
		.reset			(reset),

		.sec_domain		(1'b0),
		
		.imemreq_msg	(inst_net_req_in_msg_proc_d0),
		.imemreq_val	(inst_net_req_in_val_d0),
		.imemreq_rdy	(inst_net_req_in_rdy_d0),

		.imemresp_msg	(inst_net_resp_out_msg_proc_d0),
		.imemresp_val	(inst_net_resp_out_val_d0),
		.imemresp_rdy	(inst_net_resp_out_rdy_d0),

		.dmemreq_msg	(data_net_req_in_msg_proc_d0),
		.dmemreq_val	(data_net_req_in_val_d0),
		.dmemreq_rdy	(data_net_req_in_rdy_d0),

		.dmemresp_msg	(data_net_resp_out_msg_proc_d0),
		.dmemresp_val	(data_net_resp_out_val_d0),
		.dmemresp_rdy	(data_net_resp_out_rdy_d0),

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
		.p_core_id		(1)
	)
	proc1
	(
		.clk			(clk),
		.reset			(reset),

		.sec_domain		(1'b0),
		
		.imemreq_msg	(inst_net_req_in_msg_proc_d1),
		.imemreq_val	(inst_net_req_in_val_d1),
		.imemreq_rdy	(inst_net_req_in_rdy_d1),

		.imemresp_msg	(inst_net_resp_out_msg_proc_d1),
		.imemresp_val	(inst_net_resp_out_val_d1),
		.imemresp_rdy	(inst_net_resp_out_rdy_d1),

		.dmemreq_msg	(data_net_req_in_msg_proc_d1),
		.dmemreq_val	(data_net_req_in_val_d1),
		.dmemreq_rdy	(data_net_req_in_rdy_d1),

		.dmemresp_msg	(data_net_resp_out_msg_proc_d1),
		.dmemresp_val	(data_net_resp_out_val_d1),
		.dmemresp_rdy	(data_net_resp_out_rdy_d1),

		.from_mngr_msg	(proc1_from_mngr_msg),
		.from_mngr_val	(proc1_from_mngr_val),
		.from_mngr_rdy	(proc1_from_mngr_rdy),

		.to_mngr_msg	(proc1_to_mngr_msg),
		.to_mngr_val	(proc1_to_mngr_val),
		.to_mngr_rdy	(proc1_to_mngr_rdy),

		.stats_en		(stats_en_proc1)
	);

	// translate processor request to memory request 
	
	wire [mrq-1:0]	inst_net_req_in_msg_mem_d0;
	wire [mrq-1:0]	inst_net_req_in_msg_mem_d1;

	wire [mrs-1:0]	inst_net_resp_out_msg_mem_d0;
	wire [mrs-1:0]	inst_net_resp_out_msg_mem_d1;

	wire [mrq-1:0]	data_net_req_in_msg_mem_d0;
	wire [mrq-1:0]	data_net_req_in_msg_mem_d1;

	wire [mrs-1:0]	data_net_resp_out_msg_mem_d0;
	wire [mrs-1:0]	data_net_resp_out_msg_mem_d1;

	plab5_mcore_proc2mem_trans
	#(
		.opaque_nbits	(o),
		.addr_nbits		(a),
		.proc_data_nbits(d),
		.mem_data_nbits	(l)
	)
	trans_inst_proc0
	(
		.proc_req_msg	(inst_net_req_in_msg_proc_d0),
		.mem_resp_msg	(inst_net_resp_out_msg_mem_d0),
		.mem_req_msg	(inst_net_req_in_msg_mem_d0),
		.proc_resp_msg	(inst_net_resp_out_msg_proc_d0)
	);

	plab5_mcore_proc2mem_trans
	#(
		.opaque_nbits	(o),
		.addr_nbits		(a),
		.proc_data_nbits(d),
		.mem_data_nbits	(l)
	)
	trans_inst_proc1
	(
		.proc_req_msg	(inst_net_req_in_msg_proc_d1),
		.mem_resp_msg	(inst_net_resp_out_msg_mem_d1),
		.mem_req_msg	(inst_net_req_in_msg_mem_d1),
		.proc_resp_msg	(inst_net_resp_out_msg_proc_d1)
	);

	plab5_mcore_proc2mem_trans
	#(
		.opaque_nbits	(o),
		.addr_nbits		(a),
		.proc_data_nbits(d),
		.mem_data_nbits	(l)
	)
	trans_data_proc0
	(
		.proc_req_msg	(data_net_req_in_msg_proc_d0),
		.mem_resp_msg	(data_net_resp_out_msg_mem_d0),
		.mem_req_msg	(data_net_req_in_msg_mem_d0),
		.proc_resp_msg	(data_net_resp_out_msg_proc_d0)
	);

	plab5_mcore_proc2mem_trans
	#(
		.opaque_nbits	(o),
		.addr_nbits		(a),
		.proc_data_nbits(d),
		.mem_data_nbits	(l)
	)
	trans_data_proc1
	(
		.proc_req_msg	(data_net_req_in_msg_proc_d1),
		.mem_resp_msg	(data_net_resp_out_msg_mem_d1),
		.mem_req_msg	(data_net_req_in_msg_mem_d1),
		.proc_resp_msg	(data_net_resp_out_msg_proc_d1)
	);

	// declare network wires
	
	wire [`VC_PORT_PICK_NBITS(mrq,	p_num_cores)-1:0]	inst_net_req_in_msg;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	inst_net_req_in_val;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	inst_net_req_in_rdy;

	wire [`VC_PORT_PICK_NBITS(mrqc,	p_num_cores)-1:0]	inst_net_req_out_control;
	wire [`VC_PORT_PICK_NBITS(mrqd, p_num_cores)-1:0]	inst_net_req_out_data;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	inst_net_req_out_val;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	inst_net_req_out_rdy;  
  
	wire [`VC_PORT_PICK_NBITS(mrsc, p_num_cores)-1:0]	inst_net_resp_in_control;
	wire [`VC_PORT_PICK_NBITS(mrsd, p_num_cores)-1:0]	inst_net_resp_in_data;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	inst_net_resp_in_val;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	inst_net_resp_in_rdy;

	wire [`VC_PORT_PICK_NBITS(mrs,	p_num_cores)-1:0]	inst_net_resp_out_msg;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	inst_net_resp_out_val;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	inst_net_resp_out_rdy;

	wire [`VC_PORT_PICK_NBITS(mrq,	p_num_cores)-1:0]	data_net_req_in_msg;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	data_net_req_in_val;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	data_net_req_in_rdy;

	wire [`VC_PORT_PICK_NBITS(mrqc, p_num_cores)-1:0]	data_net_req_out_control;
	wire [`VC_PORT_PICK_NBITS(mrqd, p_num_cores)-1:0]	data_net_req_out_data;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	data_net_req_out_val;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	data_net_req_out_rdy;  
  
	wire [`VC_PORT_PICK_NBITS(mrsc, p_num_cores)-1:0]	data_net_resp_in_control;
	wire [`VC_PORT_PICK_NBITS(mrsd, p_num_cores)-1:0]	data_net_resp_in_data;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	data_net_resp_in_val;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	data_net_resp_in_rdy;

	wire [`VC_PORT_PICK_NBITS(mrs,	p_num_cores)-1:0]	data_net_resp_out_msg;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	data_net_resp_out_val;
	wire [`VC_PORT_PICK_NBITS(1,	p_num_cores)-1:0]	data_net_resp_out_rdy;

	wire [p_num_cores-1:0]  inst_net_req_out_domain;
	wire [p_num_cores-1:0]  data_net_req_out_domain;

	wire [p_num_cores-1:0]  inst_net_resp_in_domain;
	wire [p_num_cores-1:0]  data_net_resp_in_domain;  
	wire [p_num_cores-1:0]  inst_net_resp_out_domain;
	wire [p_num_cores-1:0]  data_net_resp_out_domain;

	
	// Hub between processor and network 
	
	plab5_mcore_procnet_hub
	#(
		.p_num_cores	(p_num_cores),

		.memreq_nbits	(mrq),
		.memreq_cnbits	(mrqc),
		.memreq_dnbits	(mrqd),

		.memresp_nbits	(mrs),
		.memresp_cnbits	(mrsc),
		.memresp_dnbits	(mrsd)
	)
	procnet_hub
	(
		.proc_inst_req_data_d0	(inst_net_req_in_msg_mem_d0),	
		.proc_inst_req_val_d0	(inst_net_req_in_val_d0),
		.proc_inst_req_rdy_d0	(inst_net_req_in_rdy_d0),

		.proc_inst_req_data_d1	(inst_net_req_in_msg_mem_d1),	
		.proc_inst_req_val_d1	(inst_net_req_in_val_d1),
		.proc_inst_req_rdy_d1	(inst_net_req_in_rdy_d1),

		.proc_data_req_data_d0	(data_net_req_in_msg_mem_d0),	
		.proc_data_req_val_d0	(data_net_req_in_val_d0),
		.proc_data_req_rdy_d0	(data_net_req_in_rdy_d0),

		.proc_data_req_data_d1	(data_net_req_in_msg_mem_d1),	
		.proc_data_req_val_d1	(data_net_req_in_val_d1),
		.proc_data_req_rdy_d1	(data_net_req_in_rdy_d1),
		
		.proc_inst_resp_data_d0	(inst_net_resp_out_msg_mem_d0),	
		.proc_inst_resp_val_d0	(inst_net_resp_out_val_d0),
		.proc_inst_resp_rdy_d0	(inst_net_resp_out_rdy_d0),

		.proc_inst_resp_data_d1	(inst_net_resp_out_msg_mem_d1),	
		.proc_inst_resp_val_d1	(inst_net_resp_out_val_d1),
		.proc_inst_resp_rdy_d1	(inst_net_resp_out_rdy_d1),

		.proc_data_resp_data_d0	(data_net_resp_out_msg_mem_d0),	
		.proc_data_resp_val_d0	(data_net_resp_out_val_d0),
		.proc_data_resp_rdy_d0	(data_net_resp_out_rdy_d0),

		.proc_data_resp_data_d1	(data_net_resp_out_msg_mem_d1),	
		.proc_data_resp_val_d1	(data_net_resp_out_val_d1),
		.proc_data_resp_rdy_d1	(data_net_resp_out_rdy_d1),

		.inst_net_req_in_msg	(inst_net_req_in_msg),
		.inst_net_req_in_val	(inst_net_req_in_val),
		.inst_net_req_in_rdy	(inst_net_req_in_rdy),

		.inst_net_resp_out_msg	(inst_net_resp_out_msg),
		.inst_net_resp_out_val	(inst_net_resp_out_val),
		.inst_net_resp_out_rdy	(inst_net_resp_out_rdy),

		.data_net_req_in_msg	(data_net_req_in_msg),
		.data_net_req_in_val	(data_net_req_in_val),
		.data_net_req_in_rdy	(data_net_req_in_rdy),

		.data_net_resp_out_msg	(data_net_resp_out_msg),
		.data_net_resp_out_val	(data_net_resp_out_val),
		.data_net_resp_out_rdy	(data_net_resp_out_rdy)
	);

	// inst refill net

	plab5_mcore_MemNet
	#(
		.p_mem_opaque_nbits   (o),
		.p_mem_addr_nbits     (a),
		.p_mem_data_nbits     (l),

		.p_num_ports          (p_num_cores),

		.p_single_bank        (0)
	)
	inst_net
	(
		.clk					(clk),
		.reset					(reset),

		.mode					(1'b0),

		.req_in_msg				(inst_net_req_in_msg),
		.req_in_val				(inst_net_req_in_val),
		.req_in_rdy				(inst_net_req_in_rdy),

		.req_out_msg_control	(inst_net_req_out_control),
		.req_out_msg_data		(inst_net_req_out_data),
		.req_out_domain			(inst_net_req_out_domain),
		.req_out_val			(inst_net_req_out_val),
		.req_out_rdy			(inst_net_req_out_rdy),

		.resp_in_msg_control	(inst_net_resp_in_control),
		.resp_in_msg_data		(inst_net_resp_in_data),
		.resp_in_domain			(inst_net_resp_in_domain),
		.resp_in_val			(inst_net_resp_in_val),
		.resp_in_rdy			(inst_net_resp_in_rdy),

		.resp_out_msg			(inst_net_resp_out_msg),
		.resp_out_domain		(inst_net_resp_out_domain),
		.resp_out_val			(inst_net_resp_out_val),
		.resp_out_rdy			(inst_net_resp_out_rdy)
	);

	// data refill net

	plab5_mcore_MemNet
	#(
		.p_mem_opaque_nbits   (o),
		.p_mem_addr_nbits     (a),
		.p_mem_data_nbits     (l),

		.p_num_ports          (p_num_cores),

		.p_single_bank        (0)
	)
	data_net
	(
		.clk					(clk),
		.reset					(reset),

		.mode					(1'b1),

		.req_in_msg				(data_net_req_in_msg),
		.req_in_val				(data_net_req_in_val),
		.req_in_rdy				(data_net_req_in_rdy),

		.req_out_msg_control	(data_net_req_out_control),
		.req_out_msg_data		(data_net_req_out_data),
		.req_out_domain			(data_net_req_out_domain),
		.req_out_val			(data_net_req_out_val),
		.req_out_rdy			(data_net_req_out_rdy),

		.resp_in_msg_control	(data_net_resp_in_control),
		.resp_in_msg_data		(data_net_resp_in_data),
		.resp_in_domain			(data_net_resp_in_domain),
		.resp_in_val			(data_net_resp_in_val),
		.resp_in_rdy			(data_net_resp_in_rdy),

		.resp_out_msg			(data_net_resp_out_msg),
		.resp_out_domain		(data_net_resp_out_domain),
		.resp_out_val			(data_net_resp_out_val),
		.resp_out_rdy			(data_net_resp_out_rdy)
	);

	// Hub conntected network and memory
	
	plab5_mcore_netmem_hub
	#(
		.p_num_cores	(p_num_cores),

		.memreq_nbits	(mrq),
		.memreq_cnbits	(mrqc),
		.memreq_dnbits	(mrqd),

		.memresp_nbits	(mrs),
		.memresp_cnbits	(mrsc),
		.memresp_dnbits	(mrsd)
	)
	netmem_hub
	(
		.inst_net_req_out_control	(inst_net_req_out_control),
		.inst_net_req_out_data		(inst_net_req_out_data),
		.inst_net_req_out_val		(inst_net_req_out_val),
		.inst_net_req_out_rdy		(inst_net_req_out_rdy),
		.inst_net_req_out_domain	(inst_net_req_out_domain),

		.data_net_req_out_control	(data_net_req_out_control),
		.data_net_req_out_data		(data_net_req_out_data),
		.data_net_req_out_val		(data_net_req_out_val),
		.data_net_req_out_rdy		(data_net_req_out_rdy),
		.data_net_req_out_domain	(data_net_req_out_domain),
		
		.inst_net_resp_in_control	(inst_net_resp_in_control),
		.inst_net_resp_in_data		(inst_net_resp_in_data),
		.inst_net_resp_in_val		(inst_net_resp_in_val),
		.inst_net_resp_in_rdy		(inst_net_resp_in_rdy),
		.inst_net_resp_in_domain	(inst_net_resp_in_domain),

		.data_net_resp_in_control	(data_net_resp_in_control),
		.data_net_resp_in_data		(data_net_resp_in_data),
		.data_net_resp_in_val		(data_net_resp_in_val),
		.data_net_resp_in_rdy		(data_net_resp_in_rdy),
		.data_net_resp_in_domain	(data_net_resp_in_domain),

		.inst_memreq0_control		(inst_memreq0_control),
		.inst_memreq0_data			(inst_memreq0_data),
		.inst_memreq0_val			(inst_memreq0_val),
		.inst_memreq0_rdy			(inst_memreq0_rdy),
		.inst_memreq0_domain		(inst_memreq0_domain),

		.inst_memreq1_control		(inst_memreq1_control),
		.inst_memreq1_data			(inst_memreq1_data),
		.inst_memreq1_val			(inst_memreq1_val),
		.inst_memreq1_rdy			(inst_memreq1_rdy),
		.inst_memreq1_domain		(inst_memreq1_domain),

		.data_memreq0_control		(data_memreq0_control),
		.data_memreq0_data			(data_memreq0_data),
		.data_memreq0_val			(data_memreq0_val),
		.data_memreq0_rdy			(data_memreq0_rdy),
		.data_memreq0_domain		(data_memreq0_domain),

		.data_memreq1_control		(data_memreq1_control),
		.data_memreq1_data			(data_memreq1_data),
		.data_memreq1_val			(data_memreq1_val),
		.data_memreq1_rdy			(data_memreq1_rdy),
		.data_memreq1_domain		(data_memreq1_domain),

		.inst_memresp0_control		(inst_memresp0_control),
		.inst_memresp0_data			(inst_memresp0_data),
		.inst_memresp0_val			(inst_memresp0_val),
		.inst_memresp0_rdy			(inst_memresp0_rdy),
		.inst_memresp0_domain		(inst_memresp0_domain),

		.inst_memresp1_control		(inst_memresp1_control),
		.inst_memresp1_data			(inst_memresp1_data),
		.inst_memresp1_val			(inst_memresp1_val),
		.inst_memresp1_rdy			(inst_memresp1_rdy),
		.inst_memresp1_domain		(inst_memresp1_domain),

		.data_memresp0_control		(data_memresp0_control),
		.data_memresp0_data			(data_memresp0_data),
		.data_memresp0_val			(data_memresp0_val),
		.data_memresp0_rdy			(data_memresp0_rdy),
		.data_memresp0_domain		(data_memresp0_domain),

		.data_memresp1_control		(data_memresp1_control),
		.data_memresp1_data			(data_memresp1_data),
		.data_memresp1_val			(data_memresp1_val),
		.data_memresp1_rdy			(data_memresp1_rdy),
		.data_memresp1_domain		(data_memresp1_domain)
	);

endmodule
`endif /* PLAB5_MCORE_PROC_NET_V */
