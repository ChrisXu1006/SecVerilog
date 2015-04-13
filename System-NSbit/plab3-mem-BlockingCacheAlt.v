//=========================================================================
// Alternative Blocking Cache
//=========================================================================

`ifndef PLAB3_MEM_BLOCKING_CACHE_ALT_V
`define PLAB3_MEM_BLOCKING_CACHE_ALT_V

`include "vc-mem-msgs.v"
`include "plab3-mem-BlockingCacheAltCtrl.v"
`include "plab3-mem-BlockingCacheAltDpath.v"

module plab3_mem_BlockingCacheAlt
#(
  parameter mode = 0,	// 0 for instruction, 1 for data
  
  parameter p_mem_nbytes = 256,            // Cache size in bytes
  parameter p_num_banks  = 0,              // Total number of cache banks

  // opaque field from the cache and memory side
  parameter p_opaque_nbits = 8,

  // local parameters not meant to be set from outside
  parameter dbw          = 32,             // Short name for data bitwidth
  parameter abw          = 32,             // Short name for addr bitwidth
  parameter clw          = 128,            // Short name for cacheline bitwidth

  parameter o = p_opaque_nbits
)
(
  input                                         clk,
  input                                         reset,

  // Cache Request

  input [`VC_MEM_REQ_MSG_NBITS(o,abw,dbw)-1:0]  cachereq_msg,
  input                                         cachereq_val,
  input											cachereq_domain,
  output                                        cachereq_rdy,

  // Cache Response

  output [`VC_MEM_RESP_MSG_NBITS(o,dbw)-1:0]    cacheresp_msg,
  output                                        cacheresp_val,
  output										cacheresp_domain,
  input                                         cacheresp_rdy,

  // Memory Request

  output [`VC_MEM_REQ_MSG_NBITS(o,abw,clw)-1:0] memreq_msg,
  output										memreq_domain,
  output                                        memreq_val,
  input                                         memreq_rdy,

  // Memory Response

  input [`VC_MEM_RESP_MSG_NBITS(o,clw)-1:0]     memresp_msg,
  input											memresp_domain,
  input                                         memresp_val,
  output                                        memresp_rdy
);

  // calculate the index shift amount based on number of banks

  localparam c_idx_shamt = $clog2( p_num_banks );

  //----------------------------------------------------------------------
  // Wires
  //----------------------------------------------------------------------

  // control signals (ctrl->dpath)
  wire [1:0]                                   amo_sel;
  wire                                         cachereq_en;
  wire                                         memresp_en;
  wire                                         is_refill;
  wire                                         tag_array_0_wen;
  wire                                         tag_array_0_ren;
  wire                                         tag_array_1_wen;
  wire                                         tag_array_1_ren;
  wire                                         way_sel;
  wire                                         data_array_wen;
  wire                                         data_array_ren;
  wire [clw/8-1:0]                             data_array_wben;
  wire                                         read_data_reg_en;
  wire                                         read_tag_reg_en;
  wire [$clog2(clw/dbw)-1:0]                   read_byte_sel;
  wire [`VC_MEM_RESP_MSG_TYPE_NBITS(o,clw)-1:0] memreq_type;
  wire [`VC_MEM_RESP_MSG_TYPE_NBITS(o,dbw)-1:0] cacheresp_type;


  // status signals (dpath->ctrl)
  wire [`VC_MEM_REQ_MSG_TYPE_NBITS(o,abw,dbw)-1:0] cachereq_type;
  wire [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-1:0] cachereq_addr;
  wire                                             tag_match_0;
  wire                                             tag_match_1;
  wire											   nsbit_match_0;
  wire											   nsbit_match_1;

  //----------------------------------------------------------------------
  // Control
  //----------------------------------------------------------------------

  plab3_mem_BlockingCacheAltCtrl
  #(
    .size                   (p_mem_nbytes),
    .p_idx_shamt            (c_idx_shamt),
    .p_opaque_nbits         (p_opaque_nbits)
  )
  ctrl
  (
   .clk               (clk),
   .reset             (reset),

   // Cache Request

   .cachereq_domain	  (cachereq_domain),
   .cachereq_val      (cachereq_val),
   .cachereq_rdy      (cachereq_rdy),

   // Cache Response

   .cacheresp_val     (cacheresp_val),
   .cacheresp_rdy     (cacheresp_rdy),

   // Memory Request
	
   .memreq_domain	  (memreq_domain),
   .memreq_val        (memreq_val),
   .memreq_rdy        (memreq_rdy),

   // Memory Response

   .memresp_domain	  (memresp_domain),
   .memresp_val       (memresp_val),
   .memresp_rdy       (memresp_rdy),

   // control signals (ctrl->dpath)
   .amo_sel           (amo_sel),
   .cachereq_en       (cachereq_en),
   .memresp_en        (memresp_en),
   .is_refill         (is_refill),
   .tag_array_0_wen   (tag_array_0_wen),
   .tag_array_0_ren   (tag_array_0_ren),
   .tag_array_1_wen   (tag_array_1_wen),
   .tag_array_1_ren   (tag_array_1_ren),
   .way_sel           (way_sel),
   .data_array_wen    (data_array_wen),
   .data_array_ren    (data_array_ren),
   .data_array_wben   (data_array_wben),
   .read_data_reg_en  (read_data_reg_en),
   .read_tag_reg_en   (read_tag_reg_en),
   .read_byte_sel     (read_byte_sel),
   .memreq_type       (memreq_type),
   .cacheresp_type    (cacheresp_type),

   // status signals  (dpath->ctrl)
   .cachereq_type     (cachereq_type),
   .cachereq_addr     (cachereq_addr),
   .tag_match_0       (tag_match_0),
   .tag_match_1       (tag_match_1),
   .nsbit_match_0	  (nsbit_match_0),
   .nsbit_match_1	  (nsbit_match_1)
  );

  //----------------------------------------------------------------------
  // Datapath
  //----------------------------------------------------------------------

  plab3_mem_BlockingCacheAltDpath
  #(
    .size                   (p_mem_nbytes),
    .p_idx_shamt            (c_idx_shamt),
    .p_opaque_nbits         (p_opaque_nbits)
  )
  dpath
  (
   .clk               (clk),
   .reset             (reset),

   // Cache Request

   .cachereq_msg      (cachereq_msg),
   .cachereq_domain	  (cachereq_domain),

   // Cache Response

   .cacheresp_msg     (cacheresp_msg),
   .cacheresp_domain  (cacheresp_domain),

   // Memory Request

   .memreq_msg        (memreq_msg),

   // Memory Response

   .memresp_msg       (memresp_msg),

   // control signals (ctrl->dpath)
   .amo_sel           (amo_sel),
   .cachereq_en       (cachereq_en),
   .memresp_en        (memresp_en),
   .is_refill         (is_refill),
   .tag_array_0_wen   (tag_array_0_wen),
   .tag_array_0_ren   (tag_array_0_ren),
   .tag_array_1_wen   (tag_array_1_wen),
   .tag_array_1_ren   (tag_array_1_ren),
   .way_sel           (way_sel),
   .data_array_wen    (data_array_wen),
   .data_array_ren    (data_array_ren),
   .data_array_wben   (data_array_wben),
   .read_data_reg_en  (read_data_reg_en),
   .read_tag_reg_en   (read_tag_reg_en),
   .read_byte_sel     (read_byte_sel),
   .memreq_type       (memreq_type),
   .cacheresp_type    (cacheresp_type),

   // status signals  (dpath->ctrl)
   .cachereq_type     (cachereq_type),
   .cachereq_addr     (cachereq_addr),
   .tag_match_0       (tag_match_0),
   .tag_match_1       (tag_match_1),
   .nsbit_match_0	  (nsbit_match_0),
   .nsbit_match_1	  (nsbit_match_1)
  );


  //----------------------------------------------------------------------
  // Debug part
  //----------------------------------------------------------------------
  
  always @(posedge clk) begin
	
	if(mode == 1'b1 && cachereq_val == 1'b1) begin
		$display("Cache Req Info, Address: %x, Req Domain: %d",
				cachereq_addr, cachereq_domain);
	end
  
  end 

endmodule

`endif
