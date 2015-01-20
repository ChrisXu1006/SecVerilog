//========================================================================
// Verilog Components: Test Memory
//========================================================================
// This is single-ported test memory that handles a limited subset of
// memory request messages and returns memory response messages.

`ifndef PLAB5_MCORE_TEST_MEM_1PORT_SEP_V
`define PLAB5_MCORE_TEST_MEM_1PORT_SEP_V

`include "vc-mem-msgs.v"
`include "plab5-mcore-memreqcmsgunpack.v"
`include "plab5-mcore-memreqcmsgpack.v"
`include "plab5-mcore-memrespcmsgpack.v"
`include "vc-queues.v"
`include "vc-assert.v"

//------------------------------------------------------------------------
// Test memory with two req/resp ports
//------------------------------------------------------------------------

module plab5_mcore_TestMem_1port_sep
#(
  parameter p_mem_nbytes   = 1024, // size of physical memory in bytes
  parameter p_opaque_nbits = 8,    // mem message opaque field num bits
  parameter p_addr_nbits   = 32,   // mem message address num bits
  parameter p_data_nbits   = 32,   // mem message data num bits

  // Shorter names for message type, not to be set from outside the module
  parameter o = p_opaque_nbits,
  parameter a = p_addr_nbits,
  parameter d = p_data_nbits,

  // Local constants not meant to be set from outside the module
  parameter c_req_nbits  = `VC_MEM_REQ_MSG_NBITS(o,a,d),
  parameter c_req_cnbits = `VC_MEM_REQ_MSG_NBITS(o,a,d) - d,
  parameter c_req_dnbits = `VC_MEM_REQ_MSG_DATA_NBITS(o,a,d),
  parameter c_resp_nbits = `VC_MEM_RESP_MSG_NBITS(o,d),
  parameter c_resp_cnbits= `VC_MEM_RESP_MSG_NBITS(o,d) - d,
  parameter c_resp_dnbits= `VC_MEM_RESP_MSG_DATA_NBITS(o,d)
)(
  input {L}	clk,
  input {L}	reset,

  // identify the memory belongs to which part
  input [1:0]	{L}	part,

  // clears the content of memory
  input {L}	mem_clear,

  // define security level for the content in the memory
  input {L}	mem_sec_level,

  // Memory request port interface

  input                     {L}						memreq_val,
  output                    {L}						memreq_rdy,
  input	 [c_req_cnbits-1:0]	{L}						memreq_control,
  input  [c_req_dnbits-1:0] {Domain req_sec_level}	memreq_data,
  input						{L}						req_sec_level,

  // Memory response port interface

  output                    {L}						memresp_val,
  input                     {L}						memresp_rdy,
  output [c_resp_cnbits-1:0]{L}						memresp_control,
  output [c_resp_dnbits-1:0]{Domain req_sec_level_M}memresp_data,
  output					{L}						resp_sec_level
);

  //----------------------------------------------------------------------
  // Local parameters
  //----------------------------------------------------------------------

  // Size of a physical address for the memory in bits

  localparam c_physical_addr_nbits = $clog2(p_mem_nbytes)+2;

  // Size of data entry in bytes

  localparam c_data_byte_nbits = (p_data_nbits/8);

  // Number of data entries in memory

  localparam c_num_blocks = p_mem_nbytes/c_data_byte_nbits;

  // Size of block address in bits

  localparam c_physical_block_addr_nbits = $clog2(c_num_blocks);

  // Size of block offset in bits

  localparam c_block_offset_nbits = $clog2(c_data_byte_nbits);

  // Shorthand for the message types

  wire [2:0] c_read       = 0;
  wire [2:0] c_write      = 1;
  wire [2:0] c_write_init = 2;
  wire [2:0] c_amo_add    = 3;
  wire [2:0] c_amo_and    = 4;
  wire [2:0] c_amo_or     = 5;

  // Shorthand for the message field sizes

  localparam c_req_type_nbits    = `VC_MEM_REQ_MSG_TYPE_NBITS(o,a,d);
  localparam c_req_opaque_nbits  = `VC_MEM_REQ_MSG_OPAQUE_NBITS(o,a,d);
  localparam c_req_addr_nbits    = `VC_MEM_REQ_MSG_ADDR_NBITS(o,a,d);
  localparam c_req_len_nbits     = `VC_MEM_REQ_MSG_LEN_NBITS(o,a,d);
  localparam c_req_data_nbits    = `VC_MEM_REQ_MSG_DATA_NBITS(o,a,d);

  localparam c_resp_type_nbits   = `VC_MEM_RESP_MSG_TYPE_NBITS(o,d);
  localparam c_resp_opaque_nbits = `VC_MEM_RESP_MSG_OPAQUE_NBITS(o,d);
  localparam c_resp_len_nbits    = `VC_MEM_RESP_MSG_LEN_NBITS(o,d);
  localparam c_resp_data_nbits   = `VC_MEM_RESP_MSG_DATA_NBITS(o,d);

  //----------------------------------------------------------------------
  // Memory request buffers
  //----------------------------------------------------------------------
  // We use pipe queues here since in general we want our larger modules
  // to use registered inputs, but we want to reduce the overhead of
  // having two elements which would be required for full throughput with
  // normal queues. By using a pipe queues at the inputs and a bypass
  // queue at the output we cut and combinational paths through the test
  // memory (helping to avoid combinational loops) and also preserve our
  // registered input policy.

  wire						{L}						memreq_val_M;
  wire						{L}						memreq_rdy_M;
  wire [c_req_cnbits-1:0]	{L}						memreq_control_M;
  wire [c_req_dnbits-1:0]	{Domain req_sec_level_M}memreq_msg_data_M;
  wire						{L}						req_sec_level_M;

  vc_Queue
  #(
    .p_type      (`VC_QUEUE_PIPE),
    .p_msg_nbits (c_req_cnbits),
    .p_num_msgs  (1)
  )
  memreq_control_queue
  (
    .clk     (clk),
    .reset   (reset),
	.domain  (3),
    .enq_val (memreq_val),
    .enq_rdy (memreq_rdy),
    .enq_msg (memreq_control),
    .deq_val (memreq_val_M),
    .deq_rdy (memreq_rdy_M),
    .deq_msg (memreq_control_M)
  );

  vc_Queue
  #(
    .p_type      (`VC_QUEUE_PIPE),
    .p_msg_nbits (c_req_dnbits),
    .p_num_msgs  (1)
  )
  memreq_data_queue
  (
    .clk     (clk),
    .reset   (reset),
	.domain  (req_sec_level_M),
    .enq_val (memreq_val),
    .enq_rdy (memreq_rdy),
    .enq_msg (memreq_data),
    .deq_val (memreq_val_M),
    .deq_rdy (memreq_rdy_M),
    .deq_msg (memreq_msg_data_M)
  );

  vc_Queue
  #(
    .p_type      (`VC_QUEUE_PIPE),
    .p_msg_nbits (1),
    .p_num_msgs  (1)
  )
  req_sec_level_queue
  (
    .clk     (clk),
    .reset   (reset),
	.domain  (3),
    .enq_val (memreq_val),
    .enq_rdy (memreq_rdy),
    .enq_msg (req_sec_level),
    .deq_val (memreq_val_M),
    .deq_rdy (memreq_rdy_M),
    .deq_msg (req_sec_level_M)
  );

  //----------------------------------------------------------------------
  // Unpack the request control messages
  //----------------------------------------------------------------------

  wire [c_req_type_nbits-1:0]   {L}	memreq_msg_type_M;
  wire [c_req_opaque_nbits-1:0] {L}	memreq_msg_opaque_M;
  wire [c_req_addr_nbits-1:0]   {L}	memreq_msg_addr_M;
  wire [c_req_len_nbits-1:0]    {L}	memreq_msg_len_M;

  plab5_mcore_MemReqCMsgUnpack#(o,a,d) memreq_cmsg_unpack
  (
    .msg    (memreq_control_M),
    .type   (memreq_msg_type_M),
    .opaque (memreq_msg_opaque_M),
    .addr   (memreq_msg_addr_M),
    .len    (memreq_msg_len_M)
  );

  //----------------------------------------------------------------------
  // Actual memory array
  //----------------------------------------------------------------------

  // Memory array for low security level
  reg [p_data_nbits-1:0] {Domain mem_sec_level}	m[c_num_blocks-1:0];
  /*// Memory array for high security level
  reg [p_data_nbits-1:0] m1[(c_num_blocks/2-1):0];*/

  //----------------------------------------------------------------------
  // Handle request and create response
  //----------------------------------------------------------------------

  // Handle case where length is zero which actually represents a full
  // width access.

  wire [c_req_len_nbits:0] {L}	memreq_msg_len_modified_M
    = ( memreq_msg_len_M == 0 ) ? (128/8)
    :                              memreq_msg_len_M;

  // Caculate the physical byte address for the request. Notice that we
  // truncate the higher order bits that are beyond the size of the
  // physical memory.

  wire [c_physical_addr_nbits-1:0] {L}	physical_byte_addr_M
    = memreq_msg_addr_M[c_physical_addr_nbits-1:0] ;

  // Cacluate the block address and block offset

  wire [c_physical_block_addr_nbits-1:0] {L} physical_block_addr_M
    = physical_byte_addr_M/16 - (1<<16)/64*part;

  wire [c_block_offset_nbits-1:0] {L} block_offset_M
    = physical_byte_addr_M[c_block_offset_nbits-1:0];

  // Read the data
  // for data access, the memory will firstly check the memory request
  // security level, if it is from higher security domain, just let it access
  // data as normal. Otherwise, if it will check whether the request is
  // accessing the higher part of memory, if so blocking assignment, and set
  // error flag as high

  wire [p_data_nbits-1:0] {Domain req_sec_level_M} read_block_M 
	= ( req_sec_level_M == 1'b0 && mem_sec_level == 1'b0 ) ? m[physical_block_addr_M]
	: ( ( req_sec_level_M == 1'b1 && mem_sec_level == 1'b1 ) ? m[physical_block_addr_M]
	: 'hx ); 

  wire {L} error 
	= ( req_sec_level_M == 1'b0 && mem_sec_level == 1'b1 ) ? 1'b1 : 1'b0; 

  // Memory security checking mechanism to see whether error flag is set high
  // or not, if error flag is set, print out error information and terminate
  // the process
  /*always @( posedge clk ) begin
	if ( error == 1'b1 ) begin
		$display("%m: Error: Unauthorized memory access level %d to address %x which exceeds the limit %x!!!", 
		req_sec_level_M, physical_byte_addr_M, c_num_blocks/2);
		#10;
		$finish;
	end
  end*/

  wire [c_resp_data_nbits-1:0] {Domain req_sec_level_M}	read_data_M
    = read_block_M >> (block_offset_M*8);

  // Write the data if required. This is a sequential always block so
  // that the write happens on the next edge.

  wire {L} write_en_M = memreq_val_M &&
         ( memreq_msg_type_M == c_write || memreq_msg_type_M == c_write_init );

  // Note: amos need to happen once, so we only enable the amo transaction
  // when both val and rdy is high

  wire {L} amo_en_M = memreq_val_M && memreq_rdy_M &&
                                  ( memreq_msg_type_M == c_amo_and
                                 || memreq_msg_type_M == c_amo_add
                                 || memreq_msg_type_M == c_amo_or  );

  reg[4:0] {L} wr_i;

  // We use this variable to keep track of whether or not we have already
  // cleared the memory. Otherwise if the clear signal is high for
  // multiple cycles we will do the expensive reset multiple times. We
  // initialize this to one since by default when the simulation starts
  // the memory is already reset to X's.

  reg {L} memory_cleared = 1;

  always @( posedge clk ) begin

    // We clear all of the test memory to X's on mem_clear. As mentioned
    // above, this only happens if we clear a test memory more than once.
    // This is useful when we are reusing a memory for many tests to
    // avoid writes from one test "leaking" into a later test -- this
    // might possible cause a test to pass when it should not because the
    // test is using data from an older test.

    /*if ( mem_clear ) begin
      if ( !memory_cleared ) begin
        memory_cleared = 1;
        for ( wr_i = 0; wr_i < c_num_blocks; wr_i = wr_i + 1 ) begin
          m[wr_i] <= {p_data_nbits{1'bx}};
        end
      end
    end*/

    if ( !reset ) begin
      memory_cleared = 0;

      if ( write_en_M ) begin
        /*for ( wr_i = 0; wr_i < memreq_msg_len_modified_M; wr_i = wr_i + 1 ) begin
          m[physical_block_addr_M][ (block_offset_M*8) + (wr_i*8) +: 8 ] <= memreq_msg_data_M[ (wr_i*8) +: 8 ];*/
		if ( req_sec_level_M == 1'b1 ) begin
			if ( memreq_msg_len_modified_M == 5'd4)
				m[physical_block_add_M][ (block_offset_M*8) +: 32 ] <= memreq_msg_data_M[ 0 +: 32 ];
		end

		else if ( req_sec_level_M == 1'b0 ) begin
			if ( mem_sec_level == 1'b0 ) begin	
				if ( memreq_msg_len_modified_M == 5'd4)
					m[physical_block_add_M][ (block_offset_M*8) +: 32 ] <= memreq_msg_data_M[ 0 +: 32 ];
			end
		end

      end

      /*if ( amo_en_M ) begin
        case ( memreq_msg_type_M )
          c_amo_add: m[physical_block_addr_M] <= memreq_msg_data_M + read_data_M;
          c_amo_and: m[physical_block_addr_M] <= memreq_msg_data_M & read_data_M;
          c_amo_or : m[physical_block_addr_M] <= memreq_msg_data_M | read_data_M;
        endcase
      end*/

    end

  end

  //----------------------------------------------------------------------
  // Pack the response message
  //----------------------------------------------------------------------

  wire [c_resp_cnbits-1:0] {L} memresp_control_M;

  plab5_mcore_MemRespCMsgPack#(o,d) memresp_msg_pack
  (
    .type   (memreq_msg_type_M),
    .opaque (memreq_msg_opaque_M),
    .len    (memreq_msg_len_M),
    .msg    (memresp_control_M)
  );

  //wire [c_resp_dnbits:0]  memresp_data_M = {req_sec_level_M, read_data_M};
  wire [c_resp_dnbits-1:0]  {Domain req_sec_level_M} memresp_data_M = read_data_M;
  //----------------------------------------------------------------------
  // Memory response buffers
  //----------------------------------------------------------------------
  // We use bypass queues here since in general we want our larger
  // modules to use registered inputs. By using a pipe queues at the
  // inputs and a bypass queue at the output we cut and combinational
  // paths through the test memory (helping to avoid combinational loops)
  // and also preserve our registered input policy.

  vc_Queue
  #(
    .p_type      (`VC_QUEUE_BYPASS),
    .p_msg_nbits (c_resp_cnbits),
    .p_num_msgs  (1)
  )
  memresp_control_queue
  (
    .clk     (clk),
    .reset   (reset),
	.domain  (3),
    .enq_val (memreq_val_M),
    .enq_rdy (memreq_rdy_M),
    .enq_msg (memresp_control_M),
    .deq_val (memresp_val),
    .deq_rdy (memresp_rdy),
    .deq_msg (memresp_control)
  );

  vc_Queue
  #(
    .p_type      (`VC_QUEUE_BYPASS),
    .p_msg_nbits (c_resp_dnbits),
    .p_num_msgs  (1)
  )
  memresp_data_queue
  (
    .clk     (clk),
    .reset   (reset),
	.domain  (req_sec_level_M),
    .enq_val (memreq_val_M),
    .enq_rdy (memreq_rdy_M),
    .enq_msg (memresp_data_M),
    .deq_val (memresp_val),
    .deq_rdy (memresp_rdy),
    .deq_msg (memresp_data)
  );

  vc_Queue
  #(
    .p_type      (`VC_QUEUE_BYPASS),
    .p_msg_nbits (1),
    .p_num_msgs  (1)
  )
  resp1_sec_queue
  (
    .clk     (clk),
    .reset   (reset),
	.domain  (3),
    .enq_val (memreq_val_M),
    .enq_rdy (memreq_rdy_M),
    .enq_msg (req_sec_level_M),
    .deq_val (memresp_val),
    .deq_rdy (memresp_rdy),
    .deq_msg (resp_sec_level)
  );

  //----------------------------------------------------------------------
  // General assertions
  //----------------------------------------------------------------------

  // val/rdy signals should never be x's

  always @( posedge clk ) begin
    if ( !reset ) begin
      `VC_ASSERT_NOT_X( memreq_val  );
      `VC_ASSERT_NOT_X( memresp_rdy );
    end
  end

endmodule

`endif /* PLAB5_MCORE_TEST_MEM_1PORT_SEP_V */
