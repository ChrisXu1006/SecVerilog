//=========================================================================
// Processor Test Harness
//=========================================================================
// This harness is meant to be instantiated for a specific implementation
// of the multiplier using the special IMPL macro like this:
//
//  `define PLAB5_MCORE_IMPL     plab5_mcore_Impl
//  `define PLAB5_MCORE_IMPL_STR "plab5-mcore-Impl-%INST%"
//  `define PLAB5_MCORE_TEST_CASES_FILE plab5-mcore-test-cases-%INST%.v
//
//  `include "plab5-mcore-Impl.v"
//  `include "plab5-mcore-test-harness.v"
//
// This test harness provides the logic and includes the test cases
// specified in `PLAB5_MCORE_TEST_CASES_FILE.

`include "plab5-mcore-mem-acc.v"
`include "plab5-mcore-ProcNet-Sep.v"
`include "plab5-mcore-TestMem_1port.v"

//------------------------------------------------------------------------
// Helper Module
//------------------------------------------------------------------------

module TestHarness
#(
  parameter p_mem_nbytes  = 1 << 16, // size of physical memory in bytes
  parameter p_num_msgs    = 1024
)(
  input        {L} clk,
  input        {L} reset,
  input        {L} mem_clear,
  input [31:0] {L} src_max_delay,
  input [31:0] {L} mem_max_delay,
  input [31:0] {L} sink_max_delay
);

  // Local parameters

  localparam c_req_msg_nbits  = `VC_MEM_REQ_MSG_NBITS(8,32,128);
  localparam c_req_msg_cnbits = c_req_msg_nbits - c_data_nbits;
  localparam c_req_msg_dnbits = c_data_nbits;
  localparam c_resp_msg_nbits = `VC_MEM_RESP_MSG_NBITS(8,128);
  localparam c_resp_msg_cnbits= c_resp_msg_nbits - c_data_nbits;
  localparam c_resp_msg_dnbits= c_data_nbits;
  localparam c_opaque_nbits   = 8;
  localparam c_data_nbits     = 128;  // size of mem message data in bits
  localparam c_addr_nbits     = 32;   // size of mem message address in bits

  // wires

  wire [31:0] {D1} src_msg_proc0;
  wire        {L}  src_val_proc0;
  wire        {L}  src_rdy_proc0;

  wire [31:0] {D1} sink_msg_proc0;
  wire        {L}  sink_val_proc0;
  wire        {L}  sink_rdy_proc0;

  wire [31:0] {D2} src_msg_proc1;
  wire        {L}  src_val_proc1;
  wire        {L}  src_rdy_proc1;

  wire [31:0] {D2} sink_msg_proc1;
  wire        {L}  sink_val_proc1;
  wire        {L}  sink_rdy_proc1;
  wire        sink_done_proc1;

  // wires connecting between network and acces control
  // module
  wire                        {L} inst_netreq0_val;
  wire                        {L} inst_netreq0_rdy;
  wire [c_req_msg_cnbits-1:0] {L} inst_netreq0_control;
  wire [c_req_msg_dnbits-1:0] {Domain inst_netreq0_domain} inst_netreq0_data;
  wire						  {L} inst_netreq0_domain;

  wire                        {L} inst_netresp0_val;
  wire                        {L} inst_netresp0_rdy;
  wire [c_resp_msg_cnbits-1:0]{L} inst_netresp0_control;
  wire [c_resp_msg_dnbits-1:0]{Domain inst_netresp0_domain} inst_netresp0_data;
  wire						  {L} inst_netresp0_domain;

  wire                        {L} inst_netreq1_val;
  wire                        {L} inst_netreq1_rdy;
  wire [c_req_msg_cnbits-1:0] {L} inst_netreq1_control;
  wire [c_req_msg_dnbits-1:0] {Domain inst_netreq1_domain} inst_netreq1_data;
  wire						  {L} inst_netreq1_domain;

  wire                        {L} inst_netresp1_val;
  wire                        {L} inst_netresp1_rdy;
  wire [c_resp_msg_cnbits-1:0]{L} inst_netresp1_control;
  wire [c_resp_msg_dnbits-1:0]{Domain inst_netresp1_domain} inst_netresp1_data;
  wire						  {L} inst_netresp1_domain;

  wire                        {L} data_netreq0_val;
  wire                        {L} data_netreq0_rdy;
  wire [c_req_msg_cnbits-1:0] {L} data_netreq0_control;
  wire [c_req_msg_dnbits-1:0] {Domain data_netreq0_domain} data_netreq0_data;
  wire						  {L} data_netreq0_domain;

  wire                        {L} data_netresp0_val;
  wire                        {L} data_netresp0_rdy;
  wire [c_resp_msg_cnbits-1:0]{L} data_netresp0_control;
  wire [c_resp_msg_dnbits-1:0]{Domain data_netresp0_domain} data_netresp0_data;
  wire						  {L} data_netresp0_domain;

  wire                        {L} data_netreq1_val;
  wire                        {L} data_netreq1_rdy;
  wire [c_req_msg_cnbits-1:0] {L} data_netreq1_control;
  wire [c_req_msg_dnbits-1:0] {Domain data_netreq1_domain} data_netreq1_data;
  wire						  {L} data_netreq1_domain;

  wire                        {L} data_netresp1_val;
  wire                        {L} data_netresp1_rdy;
  wire [c_resp_msg_cnbits-1:0]{L} data_netresp1_control;
  wire [c_resp_msg_dnbits-1:0]{Domain data_netresp1_domain} data_netresp1_data;
  wire						  {L} data_netresp1_domain;

  // wires connecting access control module and
  // memory
  wire                        {L} inst_memreq0_val;
  wire                        {L} inst_memreq0_rdy;
  wire [c_req_msg_cnbits-1:0] {L} inst_memreq0_control;
  wire [c_req_msg_dnbits-1:0] {D1} inst_memreq0_data;

  wire                        {L} inst_memresp0_val;
  wire                        {L} inst_memresp0_rdy;
  wire [c_resp_msg_cnbits-1:0]{L} inst_memresp0_control;
  wire [c_resp_msg_dnbits-1:0]{D1} inst_memresp0_data;

  wire                        {L} inst_memreq1_val;
  wire                        {L} inst_memreq1_rdy;
  wire [c_req_msg_cnbits-1:0] {L} inst_memreq1_control;
  wire [c_req_msg_dnbits-1:0] {D2} inst_memreq1_data;

  wire                        {L} inst_memresp1_val;
  wire                        {L} inst_memresp1_rdy;
  wire [c_resp_msg_cnbits-1:0]{L} inst_memresp1_control;
  wire [c_resp_msg_dnbits-1:0]{D2} inst_memresp1_data;

  wire                        {L} data_memreq0_val;
  wire                        {L} data_memreq0_rdy;
  wire [c_req_msg_cnbits-1:0] {L} data_memreq0_control;
  wire [c_req_msg_dnbits-1:0] {D1} data_memreq0_data;

  wire                        {L} data_memresp0_val;
  wire                        {L} data_memresp0_rdy;
  wire [c_resp_msg_cnbits-1:0]{L} data_memresp0_control;
  wire [c_resp_msg_dnbits-1:0]{D1} data_memresp0_data;

  wire                        {L} data_memreq1_val;
  wire                        {L} data_memreq1_rdy;
  wire [c_req_msg_cnbits-1:0] {L} data_memreq1_control;
  wire [c_req_msg_dnbits-1:0] {D2} data_memreq1_data;

  wire                        {L} data_memresp1_val;
  wire                        {L} data_memresp1_rdy;
  wire [c_resp_msg_cnbits-1:0]{L} data_memresp1_control;
  wire [c_resp_msg_dnbits-1:0]{D2} data_memresp1_data;

  plab5_mcore_mem_acc
  #(
		.p_opaque_nbits	(c_opaque_nbits),
		.p_addr_nbits	(c_addr_nbits),
		.p_data_nbits	(c_data_nbits)
  )
  inst_mem0_acc
  (
		.clk			(clk),
			
		.req_sec_level	(inst_netreq0_domain),
		.resp_sec_level	(inst_netresp0_domain),

		.mem_sec_level	(1'b0),

		.net_req_control(inst_netreq0_control),
		.net_req_data	(inst_netreq0_data),
		.net_req_val	(inst_netreq0_val),
		.net_req_rdy	(inst_netreq0_rdy),

		.mem_req_control(inst_memreq0_control),
		.mem_req_data	(inst_memreq0_data),
		.mem_req_val	(inst_memreq0_val),
		.mem_req_rdy	(inst_memreq0_rdy),

		.net_resp_control(inst_netresp0_control),
		.net_resp_data	(inst_netresp0_data),
		.net_resp_val	(inst_netresp0_val),
		.net_resp_rdy	(inst_netresp0_rdy),

		.mem_resp_control(inst_memresp0_control),
		.mem_resp_data	(inst_memresp0_data),
		.mem_resp_val	(inst_memresp0_val),
		.mem_resp_rdy	(inst_memresp0_rdy)
  );
	
  plab5_mcore_TestMem_1port
  #(p_mem_nbytes/4, c_opaque_nbits, c_addr_nbits, c_data_nbits) 
  inst_mem0
  (
    .clk			(clk),
    .reset			(reset),

	.part			(0),

    .sec_level      (1'b0),

    .mem_clear		(mem_clear),

	.memreq_val		(inst_memreq0_val),
	.memreq_rdy		(inst_memreq0_rdy),
	.memreq_control	(inst_memreq0_control),
	.memreq_data	(inst_memreq0_data),

	.memresp_val	(inst_memresp0_val),
	.memresp_rdy	(inst_memresp0_rdy),
	.memresp_control(inst_memresp0_control),
	.memresp_data	(inst_memresp0_data)
  );

  plab5_mcore_mem_acc
  #(
		.p_opaque_nbits	(c_opaque_nbits),
		.p_addr_nbits	(c_addr_nbits),
		.p_data_nbits	(c_data_nbits)
  )
  inst_mem1_acc
  (
		.clk			(clk),
			
		.req_sec_level	(inst_netreq1_domain),
		.resp_sec_level	(inst_netresp1_domain),

		.mem_sec_level	(1'b1),

		.net_req_control(inst_netreq1_control),
		.net_req_data	(inst_netreq1_data),
		.net_req_val	(inst_netreq1_val),
		.net_req_rdy	(inst_netreq1_rdy),

		.mem_req_control(inst_memreq1_control),
		.mem_req_data	(inst_memreq1_data),
		.mem_req_val	(inst_memreq1_val),
		.mem_req_rdy	(inst_memreq1_rdy),

		.net_resp_control(inst_netresp1_control),
		.net_resp_data	(inst_netresp1_data),
		.net_resp_val	(inst_netresp1_val),
		.net_resp_rdy	(inst_netresp1_rdy),

		.mem_resp_control(inst_memresp1_control),
		.mem_resp_data	(inst_memresp1_data),
		.mem_resp_val	(inst_memresp1_val),
		.mem_resp_rdy	(inst_memresp1_rdy)
  );

  plab5_mcore_TestMem_1port
  #(p_mem_nbytes/4, c_opaque_nbits, c_addr_nbits, c_data_nbits) 
  inst_mem1
  (
    .clk			(clk),
    .reset			(reset),

	.part			(1),

    .sec_level      (1'b1),

    .mem_clear		(mem_clear),

	.memreq_val		(inst_memreq1_val),
	.memreq_rdy		(inst_memreq1_rdy),
	.memreq_control	(inst_memreq1_control),
	.memreq_data	(inst_memreq1_data),

	.memresp_val	(inst_memresp1_val),
	.memresp_rdy	(inst_memresp1_rdy),
	.memresp_control(inst_memresp1_control),
	.memresp_data	(inst_memresp1_data)
  );

  plab5_mcore_mem_acc
  #(
		.p_opaque_nbits	(c_opaque_nbits),
		.p_addr_nbits	(c_addr_nbits),
		.p_data_nbits	(c_data_nbits)
  )
  data_mem0_acc
  (
		.clk			(clk),
			
		.req_sec_level	(data_netreq0_domain),
		.resp_sec_level	(data_netresp0_domain),

		.mem_sec_level	(1'b0),

		.net_req_control(data_netreq0_control),
		.net_req_data	(data_netreq0_data),
		.net_req_val	(data_netreq0_val),
		.net_req_rdy	(data_netreq0_rdy),

		.mem_req_control(data_memreq0_control),
		.mem_req_data	(data_memreq0_data),
		.mem_req_val	(data_memreq0_val),
		.mem_req_rdy	(data_memreq0_rdy),

		.net_resp_control(data_netresp0_control),
		.net_resp_data	(data_netresp0_data),
		.net_resp_val	(data_netresp0_val),
		.net_resp_rdy	(data_netresp0_rdy),

		.mem_resp_control(data_memresp0_control),
		.mem_resp_data	(data_memresp0_data),
		.mem_resp_val	(data_memresp0_val),
		.mem_resp_rdy	(data_memresp0_rdy)
  );

  plab5_mcore_TestMem_1port
  #(p_mem_nbytes/4, c_opaque_nbits, c_addr_nbits, c_data_nbits) 
  data_mem0
  (
    .clk			(clk),
    .reset			(reset),

	.part			(2),

    .sec_level      (1'b0),

    .mem_clear		(mem_clear),

	.memreq_val		(data_memreq0_val),
	.memreq_rdy		(data_memreq0_rdy),
	.memreq_control	(data_memreq0_control),
	.memreq_data	(data_memreq0_data),

	.memresp_val	(data_memresp0_val),
	.memresp_rdy	(data_memresp0_rdy),
	.memresp_control(data_memresp0_control),
	.memresp_data	(data_memresp0_data)
  );

  plab5_mcore_mem_acc
  #(
		.p_opaque_nbits	(c_opaque_nbits),
		.p_addr_nbits	(c_addr_nbits),
		.p_data_nbits	(c_data_nbits)
  )
  data_mem1_acc
  (
		.clk			(clk),
			
		.req_sec_level	(data_netreq1_domain),
		.resp_sec_level	(data_netresp1_domain),

		.mem_sec_level	(1'b1),

		.net_req_control(data_netreq1_control),
		.net_req_data	(data_netreq1_data),
		.net_req_val	(data_netreq1_val),
		.net_req_rdy	(data_netreq1_rdy),

		.mem_req_control(data_memreq1_control),
		.mem_req_data	(data_memreq1_data),
		.mem_req_val	(data_memreq1_val),
		.mem_req_rdy	(data_memreq1_rdy),

		.net_resp_control(data_netresp1_control),
		.net_resp_data	(data_netresp1_data),
		.net_resp_val	(data_netresp1_val),
		.net_resp_rdy	(data_netresp1_rdy),

		.mem_resp_control(data_memresp1_control),
		.mem_resp_data	(data_memresp1_data),
		.mem_resp_val	(data_memresp1_val),
		.mem_resp_rdy	(data_memresp1_rdy)
  );

  plab5_mcore_TestMem_1port
  #(p_mem_nbytes/4, c_opaque_nbits, c_addr_nbits, c_data_nbits) 
  data_mem1
  (
    .clk			(clk),
    .reset			(reset),

	.part			(3),

    .sec_level      (1'b1),

    .mem_clear		(mem_clear),
	
	.memreq_val		(data_memreq1_val),
	.memreq_rdy		(data_memreq1_rdy),
	.memreq_control	(data_memreq1_control),
	.memreq_data	(data_memreq1_data),

	.memresp_val	(data_memresp1_val),
	.memresp_rdy	(data_memresp1_rdy),
	.memresp_control(data_memresp1_control),
	.memresp_data	(data_memresp1_data)
  );

  // processor-network

  plab5_mcore_ProcNet_Sep  proc_cache_net
  (
    .clk					(clk),
    .reset					(reset),

    .inst_memreq0_val		(inst_netreq0_val),
    .inst_memreq0_rdy		(inst_netreq0_rdy),
    .inst_memreq0_control   (inst_netreq0_control),
    .inst_memreq0_data		(inst_netreq0_data),
	.inst_memreq0_domain	(inst_netreq0_domain),

    .inst_memresp0_val		(inst_netresp0_val),
    .inst_memresp0_rdy		(inst_netresp0_rdy),
    .inst_memresp0_control	(inst_netresp0_control),
    .inst_memresp0_data		(inst_netresp0_data),
	.inst_memresp0_domain	(inst_netresp0_domain),

    .inst_memreq1_val		(inst_netreq1_val),
    .inst_memreq1_rdy		(inst_netreq1_rdy),
    .inst_memreq1_control   (inst_netreq1_control),
    .inst_memreq1_data		(inst_netreq1_data),
	.inst_memreq1_domain	(inst_netreq1_domain),

    .inst_memresp1_val		(inst_netresp1_val),
    .inst_memresp1_rdy		(inst_netresp1_rdy),
    .inst_memresp1_control	(inst_netresp1_control),
    .inst_memresp1_data		(inst_netresp1_data),
	.inst_memresp1_domain	(inst_netresp1_domain),

    .data_memreq0_val		(data_netreq0_val),
    .data_memreq0_rdy		(data_netreq0_rdy),
    .data_memreq0_control   (data_netreq0_control),
    .data_memreq0_data		(data_netreq0_data),
	.data_memreq0_domain	(data_netreq0_domain),

    .data_memresp0_val		(data_netresp0_val),
    .data_memresp0_rdy		(data_netresp0_rdy),
    .data_memresp0_control	(data_netresp0_control),
    .data_memresp0_data		(data_netresp0_data),
	.data_memresp0_domain	(data_netresp0_domain),

    .data_memreq1_val		(data_netreq1_val),
    .data_memreq1_rdy		(data_netreq1_rdy),
    .data_memreq1_control   (data_netreq1_control),
    .data_memreq1_data		(data_netreq1_data),
	.data_memreq1_domain	(data_netreq1_domain),

    .data_memresp1_val		(data_netresp1_val),
    .data_memresp1_rdy		(data_netresp1_rdy),
    .data_memresp1_control	(data_netresp1_control),
    .data_memresp1_data		(data_netresp1_data),
	.data_memresp1_domain	(data_netresp1_domain),

    .proc0_from_mngr_msg	(src_msg_proc0),
    .proc0_from_mngr_val	(src_val_proc0),
    .proc0_from_mngr_rdy	(src_rdy_proc0),

    .proc0_to_mngr_msg		(sink_msg_proc0),
    .proc0_to_mngr_val		(sink_val_proc0),
    .proc0_to_mngr_rdy		(sink_rdy_proc0),

	.proc1_from_mngr_msg	(src_msg_proc1),
	.proc1_from_mngr_val	(src_val_proc1),
	.proc1_from_mngr_rdy	(src_rdy_proc1),

	.proc1_to_mngr_msg		(sink_msg_proc1),
	.proc1_to_mngr_val		(sink_val_proc1),
	.proc1_to_mngr_rdy		(sink_rdy_proc1)
  );

endmodule

