//========================================================================
// 2-Cores Processor-Network-Memory
//========================================================================

`ifndef PLAB5_MCORE_PROC_NET_SEP1_V
`define PLAB5_MCORE_PROC_NET_SEP1_V
`define PLAB4_NET_NUM_PORTS_2

`include "vc-mem-msgs.v"
`include "plab2-proc-PipelinedProcBypass.v"
`include "plab5-mcore-proc-acc.v"
`include "plab5-mcore-proc2mem-trans.v"
`include "plab5-mcore-MemNet-sep.v"

module plab5_mcore_ProcNet_Sep1
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
	input	{L} clk,
	input	{L}reset,

	// proc0 manager ports
	
	input	[31:0]	{D1} proc0_from_mngr_msg,
    input			{D1}  proc0_from_mngr_val,
	output			{D1}  proc0_from_mngr_rdy,

	output	[31:0]	{D1} proc0_to_mngr_msg,
	output			{D1}  proc0_to_mngr_val,
	input			{D1}  proc0_to_mngr_rdy,

	output			{D1} stats_en_proc0,

	// proc1 manager ports
	
	input	[31:0]	{D2} proc1_from_mngr_msg,
	input			{D2}  proc1_from_mngr_val,
	output			{D2}  proc1_from_mngr_rdy,

	output	[31:0]	{D2} proc1_to_mngr_msg,
	output			{D2}  proc1_to_mngr_val,
	input			{D2}  proc1_to_mngr_rdy,

	output			{D2} stats_en_proc1,

	// ports connected to memory
	// req0 and resp0 are connected to low-paritioned memory
	// req1 and resp1 are connected to high-paritioned memory 
	
	output	[c_memreq_cnbits-1:0]	{Control inst_memreq0_domain} inst_memreq0_control,
	output	[c_memreq_dnbits-1:0]	{Domain  inst_memreq0_domain} inst_memreq0_data,
	output							{Control inst_memreq0_domain} inst_memreq0_val,
	input							{Control  inst_memreq0_domain} inst_memreq0_rdy,
	output							{L} inst_memreq0_domain,

	input	[c_memresp_cnbits-1:0]	{Control inst_memresp0_domain} inst_memresp0_control,
	input	[c_memresp_dnbits-1:0]	{Domain  inst_memresp0_domain} inst_memresp0_data,
	input							{Control inst_memresp0_domain} inst_memresp0_val,
	output							{Control inst_memresp0_domain} inst_memresp0_rdy,
	input							{L} inst_memresp0_domain,

	output	[c_memreq_cnbits-1:0]	{Control inst_memreq1_domain} inst_memreq1_control,
	output	[c_memreq_dnbits-1:0]	{Domain  inst_memreq1_domain} inst_memreq1_data,
	output							{Control inst_memreq1_domain} inst_memreq1_val,
	input							{Control inst_memreq1_domain} inst_memreq1_rdy,
	output							{L} inst_memreq1_domain,

	input	[c_memresp_cnbits-1:0]	{Control inst_memresp1_domain} inst_memresp1_control,
	input	[c_memresp_dnbits-1:0]	{Domain  inst_memresp1_domain} inst_memresp1_data,
	input							{Control inst_memresp1_domain} inst_memresp1_val,
	output							{Control inst_memresp1_domain} inst_memresp1_rdy,
	input							{L} inst_memresp1_domain,

	output	[c_memreq_cnbits-1:0]	{Control data_memreq0_domain} data_memreq0_control,
	output	[c_memreq_dnbits-1:0]	{Domain  data_memreq0_domain} data_memreq0_data,
	output							{Control data_memreq0_domain} data_memreq0_val,
	input							{Control data_memreq0_domain} data_memreq0_rdy,
	output							{L} data_memreq0_domain,

	input	[c_memresp_cnbits-1:0]	{Control data_memresp0_domain} data_memresp0_control,
	input	[c_memresp_dnbits-1:0]	{Domain  data_memresp0_domain} data_memresp0_data,
	input							{Control data_memresp0_domain} data_memresp0_val,
	output							{Control data_memresp0_domain} data_memresp0_rdy,
	input							{L} data_memresp0_domain,

	output	[c_memreq_cnbits-1:0]	{Control data_memreq1_domain} data_memreq1_control,
	output	[c_memreq_dnbits-1:0]	{Domain  data_memreq1_domain} data_memreq1_data,
	output							{Control data_memreq1_domain} data_memreq1_val,
	input							{Control data_memreq1_domain} data_memreq1_rdy,
	output							{L} data_memreq1_domain,

	input	[c_memresp_cnbits-1:0]	{Control data_memresp1_domain} data_memresp1_control,
	input	[c_memresp_dnbits-1:0]	{Domain  data_memresp1_domain} data_memresp1_data,
	input							{Control data_memresp1_domain} data_memresp1_val,
	output							{Control data_memresp1_domain} data_memresp1_rdy,
	input							{L} data_memresp1_domain

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
	
	wire	[prq-1:0]	{D1} inst_net_req_in_msg_proc_d0;
	wire				{D1} inst_net_req_in_val_d0;
	wire				{D1} inst_net_req_in_rdy_d0;

	wire	[prs-1:0]	{D1} inst_net_resp_out_msg_proc_d0;
	wire				{D1} inst_proc_resp_out_val_d0;
	wire				{D1} inst_proc_resp_out_rdy_d0;

	wire	[prq-1:0]	{D1} data_net_req_in_msg_proc_d0;
	wire				{D1} data_net_req_in_val_d0;
	wire				{D1} data_net_req_in_rdy_d0;

	wire	[prs-1:0]	{D1} data_net_resp_out_msg_proc_d0;
	wire				{D1} data_proc_resp_out_val_d0;
	wire				{D1} data_proc_resp_out_rdy_d0;

	wire				{L}  req_in_domain_d0;

	// wires connected to processor1
	
	wire	[prq-1:0]	{D2} inst_net_req_in_msg_proc_d1;
	wire				{D2} inst_net_req_in_val_d1;
	wire				{D2} inst_net_req_in_rdy_d1;

	wire	[prs-1:0]	{D2} inst_net_resp_out_msg_proc_d1;
	wire				{D2} inst_proc_resp_out_val_d1;
    wire				{D2} inst_proc_resp_out_rdy_d1;

	wire	[prq-1:0]	{D2} data_net_req_in_msg_proc_d1;
	wire				{D2} data_net_req_in_val_d1;
	wire				{D2} data_net_req_in_rdy_d1;

	wire	[prs-1:0]	{D2} data_net_resp_out_msg_proc_d1;
	wire				{D2} data_proc_resp_out_val_d1;
	wire				{D2} data_proc_resp_out_rdy_d1;

	wire				{L}  req_in_domain_d1;

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
		
		.imemreq_msg	(inst_net_req_in_msg_proc_d0),
		.imemreq_val	(inst_net_req_in_val_d0),
		.imemreq_rdy	(inst_net_req_in_rdy_d0),

		.imemresp_msg	(inst_net_resp_out_msg_proc_d0),
		.imemresp_val	(inst_proc_resp_out_val_d0),
		.imemresp_rdy	(inst_proc_resp_out_rdy_d0),

		.dmemreq_msg	(data_net_req_in_msg_proc_d0),
		.dmemreq_val	(data_net_req_in_val_d0),
		.dmemreq_rdy	(data_net_req_in_rdy_d0),

		.dmemresp_msg	(data_net_resp_out_msg_proc_d0),
		.dmemresp_val	(data_proc_resp_out_val_d0),
		.dmemresp_rdy	(data_proc_resp_out_rdy_d0),

		.from_mngr_msg	(proc0_from_mngr_msg),
		.from_mngr_val	(proc0_from_mngr_val),
		.from_mngr_rdy	(proc0_from_mngr_rdy),

		.to_mngr_msg	(proc0_to_mngr_msg),
		.to_mngr_val	(proc0_to_mngr_val),
		.to_mngr_rdy	(proc0_to_mngr_rdy),

		.req_domain		(req_in_domain_d0),

		.stats_en		(stats_en_proc0)
	);

	plab2_proc_PipelinedProcBypass
	#(
		.p_num_cores	(p_num_cores),
		.p_core_id		(1),
		.c_reset_vector	(32'h1000)
	)
	proc1
	(
		.clk			(clk),
		.reset			(reset),

		.sec_domain		(1'b1),
		
		.imemreq_msg	(inst_net_req_in_msg_proc_d1),
		.imemreq_val	(inst_net_req_in_val_d1),
		.imemreq_rdy	(inst_net_req_in_rdy_d1),

		.imemresp_msg	(inst_net_resp_out_msg_proc_d1),
		.imemresp_val	(inst_proc_resp_out_val_d1),
		.imemresp_rdy	(inst_proc_resp_out_rdy_d1),

		.dmemreq_msg	(data_net_req_in_msg_proc_d1),
		.dmemreq_val	(data_net_req_in_val_d1),
		.dmemreq_rdy	(data_net_req_in_rdy_d1),

		.dmemresp_msg	(data_net_resp_out_msg_proc_d1),
		.dmemresp_val	(data_proc_resp_out_val_d1),
		.dmemresp_rdy	(data_proc_resp_out_rdy_d1),

		.from_mngr_msg	(proc1_from_mngr_msg),
		.from_mngr_val	(proc1_from_mngr_val),
		.from_mngr_rdy	(proc1_from_mngr_rdy),

		.to_mngr_msg	(proc1_to_mngr_msg),
		.to_mngr_val	(proc1_to_mngr_val),
		.to_mngr_rdy	(proc1_to_mngr_rdy),

		.req_domain		(req_in_domain_d1),

		.stats_en		(stats_en_proc1)
	);

	// translate processor request to memory request 
	
	wire [mrq-1:0]	{D1} inst_net_req_in_msg_mem_d0;
	wire [mrq-1:0]	{D2} inst_net_req_in_msg_mem_d1;

	wire [mrs-1:0]	{D1} inst_proc_resp_out_msg_mem_d0;
	wire [mrs-1:0]	{D2} inst_proc_resp_out_msg_mem_d1;

	wire [mrq-1:0]	{D1} data_net_req_in_msg_mem_d0;
	wire [mrq-1:0]	{D2} data_net_req_in_msg_mem_d1;

	wire [mrs-1:0]	{D1} data_proc_resp_out_msg_mem_d0;
	wire [mrs-1:0]	{D2} data_proc_resp_out_msg_mem_d1;

	plab5_mcore_proc2mem_trans
	#(
		.opaque_nbits	(o),
		.addr_nbits		(a),
		.proc_data_nbits(d),
		.mem_data_nbits	(l)
	)
	trans_inst_proc0
	(
        .domain         (0),
		.proc_req_msg	(inst_net_req_in_msg_proc_d0),
		.mem_resp_msg	(inst_proc_resp_out_msg_mem_d0),
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
        .domain         (1),
		.proc_req_msg	(inst_net_req_in_msg_proc_d1),
		.mem_resp_msg	(inst_proc_resp_out_msg_mem_d1),
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
        .domain         (0),
		.proc_req_msg	(data_net_req_in_msg_proc_d0),
		.mem_resp_msg	(data_proc_resp_out_msg_mem_d0),
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
        .domain         (1),
		.proc_req_msg	(data_net_req_in_msg_proc_d1),
		.mem_resp_msg	(data_proc_resp_out_msg_mem_d1),
		.mem_req_msg	(data_net_req_in_msg_mem_d1),
		.proc_resp_msg	(data_net_resp_out_msg_proc_d1)
	);
	
	// network wires
	wire   {L} inst_net_resp_out_domain_d0;
	wire   {L} inst_net_resp_out_domain_d1;
	wire   {L} data_net_resp_out_domain_d0;
	wire   {L} data_net_resp_out_domain_d1;

	wire [mrs-1:0]	{Domain  inst_net_resp_out_domain_d0} inst_net_resp_out_msg_mem_d0;
	wire			{Control inst_net_resp_out_domain_d0} inst_net_resp_out_val_d0;
	wire			{Control inst_net_resp_out_domain_d0} inst_net_resp_out_rdy_d0;

	wire [mrs-1:0]	{Domain  inst_net_resp_out_domain_d1} inst_net_resp_out_msg_mem_d1;
	wire			{Control inst_net_resp_out_domain_d1} inst_net_resp_out_val_d1;
	wire			{Control inst_net_resp_out_domain_d1} inst_net_resp_out_rdy_d1;

	wire [mrs-1:0]	{Domain  data_net_resp_out_domain_d0} data_net_resp_out_msg_mem_d0;
	wire			{Control data_net_resp_out_domain_d0} data_net_resp_out_val_d0;
	wire			{Control data_net_resp_out_domain_d0} data_net_resp_out_rdy_d0;

	wire [mrs-1:0]	{Domain  data_net_resp_out_domain_d1} data_net_resp_out_msg_mem_d1;
	wire			{Control data_net_resp_out_domain_d1} data_net_resp_out_val_d1;
	wire			{Control data_net_resp_out_domain_d1} data_net_resp_out_rdy_d1;

	// processor0 instruction response access control
	plab5_mcore_proc_resp_acc
	#(
		.p_opaque_nbits		(o),
		.p_addr_nbits		(a),
		.p_data_nbits		(l)
	)
	inst_resp_acc_p0
	(
		.clk				(clk),
		.resp_sec_level		(inst_net_resp_out_domain_d0),
		.proc_sec_level		(0),

		.net_resp_val		(inst_net_resp_out_val_d0),
		.net_resp_rdy		(inst_net_resp_out_rdy_d0),
		.net_resp_msg		(inst_net_resp_out_msg_mem_d0),

		.proc_resp_val		(inst_proc_resp_out_val_d0),
		.proc_resp_rdy		(inst_proc_resp_out_rdy_d0),
		.proc_resp_msg		(inst_proc_resp_out_msg_mem_d0)
	);

	// processor1 instruction response access control
	plab5_mcore_proc_resp_acc
	#(
		.p_opaque_nbits		(o),
		.p_addr_nbits		(a),
		.p_data_nbits		(l)
	)
	inst_resp_acc_p1
	(
		.clk				(clk),
		.resp_sec_level		(inst_net_resp_out_domain_d1),
		.proc_sec_level		(1),

		.net_resp_val		(inst_net_resp_out_val_d1),
		.net_resp_rdy		(inst_net_resp_out_rdy_d1),
		.net_resp_msg		(inst_net_resp_out_msg_mem_d1),

		.proc_resp_val		(inst_proc_resp_out_val_d1),
		.proc_resp_rdy		(inst_proc_resp_out_rdy_d1),
		.proc_resp_msg		(inst_proc_resp_out_msg_mem_d1)
	);

	// processor0 data response access control
	plab5_mcore_proc_resp_acc
	#(
		.p_opaque_nbits		(o),
		.p_addr_nbits		(a),
		.p_data_nbits		(l)
	)
	data_resp_acc_p0
	(
		.clk				(clk),
		.resp_sec_level		(data_net_resp_out_domain_d0),
		.proc_sec_level		(0),

		.net_resp_val		(data_net_resp_out_val_d0),
		.net_resp_rdy		(data_net_resp_out_rdy_d0),
		.net_resp_msg		(data_net_resp_out_msg_mem_d0),

		.proc_resp_val		(data_proc_resp_out_val_d0),
		.proc_resp_rdy		(data_proc_resp_out_rdy_d0),
		.proc_resp_msg		(data_proc_resp_out_msg_mem_d0)
	);

	// processor1 data response access control
	plab5_mcore_proc_resp_acc
	#(
		.p_opaque_nbits		(o),
		.p_addr_nbits		(a),
		.p_data_nbits		(l)
	)
	data_resp_acc_p1
	(
		.clk				(clk),
		.resp_sec_level		(data_net_resp_out_domain_d1),
		.proc_sec_level		(1),

		.net_resp_val		(data_net_resp_out_val_d1),
		.net_resp_rdy		(data_net_resp_out_rdy_d1),
		.net_resp_msg		(data_net_resp_out_msg_mem_d1),

		.proc_resp_val		(data_proc_resp_out_val_d1),
		.proc_resp_rdy		(data_proc_resp_out_rdy_d1),
		.proc_resp_msg		(data_proc_resp_out_msg_mem_d1)
	);

	// inst refill net

	plab5_mcore_MemNet_Sep
	#(
		.p_mem_opaque_nbits			(o),
		.p_mem_addr_nbits			(a),
		.p_mem_data_nbits			(l),

		.p_num_ports				(p_num_cores),

		.p_single_bank				(0)
	)
	inst_net
	(
		.clk						(clk),
		.reset						(reset),

		.mode						(1'b0),

		.req_in_msg_p0				(inst_net_req_in_msg_mem_d0),
		.req_in_domain_p0			(req_in_domain_d0),
		.req_in_val_p0				(inst_net_req_in_val_d0),
		.req_in_rdy_p0				(inst_net_req_in_rdy_d0),

		.req_out_msg_control_p0		(inst_memreq0_control),
		.req_out_msg_data_p0		(inst_memreq0_data),
		.req_out_domain_p0			(inst_memreq0_domain),
		.req_out_val_p0				(inst_memreq0_val),
		.req_out_rdy_p0				(inst_memreq0_rdy),

		.resp_in_msg_control_p0		(inst_memresp0_control),
		.resp_in_msg_data_p0		(inst_memresp0_data),
		.resp_in_domain_p0			(inst_memresp0_domain),
		.resp_in_val_p0				(inst_memresp0_val),
		.resp_in_rdy_p0				(inst_memresp0_rdy),

		.resp_out_msg_p0			(inst_net_resp_out_msg_mem_d0),
		.resp_out_domain_p0			(inst_net_resp_out_domain_d0),
		.resp_out_val_p0			(inst_net_resp_out_val_d0),
		.resp_out_rdy_p0			(inst_net_resp_out_rdy_d0),

		.req_in_msg_p1				(inst_net_req_in_msg_mem_d1),
		.req_in_domain_p1			(req_in_domain_d1),
		.req_in_val_p1				(inst_net_req_in_val_d1),
		.req_in_rdy_p1				(inst_net_req_in_rdy_d1),

		.req_out_msg_control_p1		(inst_memreq1_control),
		.req_out_msg_data_p1		(inst_memreq1_data),
		.req_out_domain_p1			(inst_memreq1_domain),
		.req_out_val_p1				(inst_memreq1_val),
		.req_out_rdy_p1				(inst_memreq1_rdy),

		.resp_in_msg_control_p1		(inst_memresp1_control),
		.resp_in_msg_data_p1		(inst_memresp1_data),
		.resp_in_domain_p1			(inst_memresp1_domain),
		.resp_in_val_p1				(inst_memresp1_val),
		.resp_in_rdy_p1				(inst_memresp1_rdy),

		.resp_out_msg_p1			(inst_net_resp_out_msg_mem_d1),
		.resp_out_domain_p1			(inst_net_resp_out_domain_d1),
		.resp_out_val_p1			(inst_net_resp_out_val_d1),
		.resp_out_rdy_p1			(inst_net_resp_out_rdy_d1)

	);

	plab5_mcore_MemNet_Sep
	#(
		.p_mem_opaque_nbits			(o),
		.p_mem_addr_nbits			(a),
		.p_mem_data_nbits			(l),

		.p_num_ports				(p_num_cores),

		.p_single_bank				(0)
	)
	data_net
	(
		.clk						(clk),
		.reset						(reset),

		.mode						(1'b1),

		.req_in_msg_p0				(data_net_req_in_msg_mem_d0),
		.req_in_domain_p0			(req_in_domain_d0),
		.req_in_val_p0				(data_net_req_in_val_d0),
		.req_in_rdy_p0				(data_net_req_in_rdy_d0),

		.req_out_msg_control_p0		(data_memreq0_control),
		.req_out_msg_data_p0		(data_memreq0_data),
		.req_out_domain_p0			(data_memreq0_domain),
		.req_out_val_p0				(data_memreq0_val),
		.req_out_rdy_p0				(data_memreq0_rdy),

		.resp_in_msg_control_p0		(data_memresp0_control),
		.resp_in_msg_data_p0		(data_memresp0_data),
		.resp_in_domain_p0			(data_memresp0_domain),
		.resp_in_val_p0				(data_memresp0_val),
		.resp_in_rdy_p0				(data_memresp0_rdy),

		.resp_out_msg_p0			(data_net_resp_out_msg_mem_d0),
		.resp_out_domain_p0			(data_net_resp_out_domain_d0),
		.resp_out_val_p0			(data_net_resp_out_val_d0),
		.resp_out_rdy_p0			(data_net_resp_out_rdy_d0),

		.req_in_msg_p1				(data_net_req_in_msg_mem_d1),
		.req_in_domain_p1			(req_in_domain_d1),
		.req_in_val_p1				(data_net_req_in_val_d1),
		.req_in_rdy_p1				(data_net_req_in_rdy_d1),

		.req_out_msg_control_p1		(data_memreq1_control),
		.req_out_msg_data_p1		(data_memreq1_data),
		.req_out_domain_p1			(data_memreq1_domain),
		.req_out_val_p1				(data_memreq1_val),
		.req_out_rdy_p1				(data_memreq1_rdy),

		.resp_in_msg_control_p1		(data_memresp1_control),
		.resp_in_msg_data_p1		(data_memresp1_data),
		.resp_in_domain_p1			(data_memresp1_domain),
		.resp_in_val_p1				(data_memresp1_val),
		.resp_in_rdy_p1				(data_memresp1_rdy),

		.resp_out_msg_p1			(data_net_resp_out_msg_mem_d1),
		.resp_out_domain_p1			(data_net_resp_out_domain_d1),
		.resp_out_val_p1			(data_net_resp_out_val_d1),
		.resp_out_rdy_p1			(data_net_resp_out_rdy_d1)

	);

endmodule
`endif /* PLAB5_MCORE_PROC_NET_SEP1_V */
