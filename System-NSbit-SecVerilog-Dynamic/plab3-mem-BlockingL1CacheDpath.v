//=========================================================================
// Alternative Blocking Cache Datapath
//=========================================================================

`ifndef PLAB3_MEM_BLOCKING_L1_CACHE_DPATH_V
`define PLAB3_MEM_BLOCKING_L1_CACHE_DPATH_V

`include "vc-mem-msgs.v"
`include "vc-arithmetic.v"
`include "vc-muxes.v"
`include "vc-srams.v"

module plab3_mem_BlockingL1CacheDpath
#(
  parameter size    = 256,            // Cache size in bytes

  parameter p_idx_shamt = 0,

  parameter p_opaque_nbits   = 8,

  // local parameters not meant to be set from outside
  parameter dbw     = 32,             // Short name for data bitwidth
  parameter abw     = 32,             // Short name for addr bitwidth
  parameter clw     = 128,            // Short name for cacheline bitwidth
  parameter nblocks = size*8/clw,     // Number of blocks in the cache
  parameter idw     = $clog2(nblocks),// Short name for index width

  parameter o = p_opaque_nbits
)
(
  input                                              {L} clk,
  input                                              {L} reset,

  // Cache Request

  input [`VC_MEM_REQ_MSG_NBITS(o,abw,dbw)-1:0]       {Domain cachereq_domain} cachereq_msg,
  input												 {L} cachereq_domain,

  // Cache Response

  output [`VC_MEM_RESP_MSG_NBITS(o,dbw)-1:0]         {Domain cacheresp_domain} cacheresp_msg,
  output											 {L} cacheresp_domain,

  // Memory Request

  output [`VC_MEM_REQ_MSG_NBITS(o,abw,clw)-1:0]      {Domain memreq_domain} memreq_msg,
  output											 {L} memreq_domain,

  // Memory Response

  input [`VC_MEM_RESP_MSG_NBITS(o,clw)-1:0]          {Domain memresp_domain} memresp_msg,
  input												 {L} memresp_domain,

  // control signals (ctrl->dpath)
  input [1:0]                                        {Domain cachereq_nsbit} amo_sel,
  input                                              {Domain cachereq_nsbit} cachereq_en,
  input                                              {Domain cachereq_nsbit} memresp_en,
  input                                              {Domain cachereq_nsbit} is_refill,
  input                                              {Domain cachereq_nsbit} tag_array_0_wen,
  input                                              {Domain cachereq_nsbit} tag_array_0_ren,
  input                                              {Domain cachereq_nsbit} tag_array_1_wen,
  input                                              {Domain cachereq_nsbit} tag_array_1_ren,
  input                                              {Domain cachereq_nsbit} nsb_array_0_wen,
  input                                              {Domain cachereq_nsbit} nsb_array_0_ren,
  input                                              {Domain cachereq_nsbit} nsb_array_1_wen,
  input                                              {Domain cachereq_nsbit} nsb_array_1_ren,
  input                                              {Domain cachereq_nsbit} way_sel,
  input                                              {Domain cachereq_nsbit} data_array_wen,
  input                                              {Domain cachereq_nsbit} data_array_ren,
  // width of cacheline divided by number of bits per byte
  input [clw/8-1:0]                                  {Domain cachereq_nsbit} data_array_wben,
  input                                              {Domain cachereq_nsbit} read_data_reg_en,
  input                                              {Domain cachereq_nsbit} read_tag_reg_en,
  input [$clog2(clw/dbw)-1:0]                        {Domain cachereq_nsbit} read_byte_sel,
  input [`VC_MEM_RESP_MSG_TYPE_NBITS(o,clw)-1:0]     {Domain memreq_domain}  memreq_type,
  input [`VC_MEM_RESP_MSG_TYPE_NBITS(o,dbw)-1:0]     {Domain cacheresp_domain} cacheresp_type,
  input												 {Domain cachereq_nsbit} secure_mask,

  // status signals (dpath->ctrl)
  output [`VC_MEM_REQ_MSG_TYPE_NBITS(o,abw,dbw)-1:0] {Domain cachereq_nsbit} cachereq_type,
  output [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-1:0] {Domain cachereq_nsbit} cachereq_addr,
  output											 {L} cachereq_nsbit,
  output                                             {Domain cachereq_nsbit} tag_match_0,
  output                                             {Domain cachereq_nsbit} tag_match_1,
  output											 {L} nsb_match_0,
  output											 {L} nsb_match_1
);

  // Unpack cache request

  wire [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-1:0]   {Domain cachereq_domain} cachereq_addr_out;
  wire [`VC_MEM_REQ_MSG_DATA_NBITS(o,abw,dbw)-1:0]   {Domain cachereq_domain} cachereq_data_out;
  wire [`VC_MEM_REQ_MSG_OPAQUE_NBITS(o,abw,dbw)-1:0] {Domain cachereq_domain} cachereq_opaque_out;
  wire [`VC_MEM_REQ_MSG_TYPE_NBITS(o,abw,dbw)-1:0]   {Domain cachereq_domain} cachereq_type_out;
  wire [`VC_MEM_REQ_MSG_LEN_NBITS(o,abw,dbw)-1:0]    {Domain cachereq_domain} cachereq_len_out;

  vc_MemReqMsgUnpack#(o,abw,dbw) cachereq_msg_unpack
  (
    .domain (cachereq_domain),
    .msg    (cachereq_msg),

    .type   (cachereq_type_out),
    .opaque (cachereq_opaque_out),
    .addr   (cachereq_addr_out),
    .len    (cachereq_len_out),
    .data   (cachereq_data_out)
  );

  // Unpack memory response

  wire [`VC_MEM_RESP_MSG_DATA_NBITS(o,clw)-1:0]      {Domain memresp_domain} memresp_data_out;
  wire [`VC_MEM_RESP_MSG_OPAQUE_NBITS(o,clw)-1:0]    {Domain memresp_domain} memresp_opaque_out;
  wire [`VC_MEM_RESP_MSG_TYPE_NBITS(o,clw)-1:0]      {Domain memresp_domain} memresp_type_out;
  wire [`VC_MEM_RESP_MSG_LEN_NBITS(o,clw)-1:0]       {Domain memresp_domain} memresp_len_out;

  vc_MemRespMsgUnpack#(o,clw) memresp_msg_unpack
  (
    .domain (memresp_domain),
    .msg    (memresp_msg),

    .opaque (memresp_opaque_out),
    .type   (memresp_type_out),
    .len    (memresp_len_out),
    .data   (memresp_data_out)
  );

  // Register the unpacked cachereq_msg

  wire [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-1:0]   {Domain cachereq_nsbit} cachereq_addr_reg_out;
  wire [`VC_MEM_REQ_MSG_DATA_NBITS(o,abw,dbw)-1:0]   {Domain cachereq_nsbit} cachereq_data_reg_out;
  wire [`VC_MEM_REQ_MSG_TYPE_NBITS(o,abw,dbw)-1:0]   {Domain cachereq_nsbit} cachereq_type_reg_out;
  wire [`VC_MEM_REQ_MSG_OPAQUE_NBITS(o,abw,dbw)-1:0] {Domain cachereq_nsbit} cachereq_opaque_reg_out;
  wire												 {L} cachereq_domain_reg_out;

  vc_EnResetReg #(`VC_MEM_REQ_MSG_TYPE_NBITS(o,abw,dbw), 0) cachereq_type_reg
  (
    .clk    (clk),
    .reset  (reset),
    .en     (cachereq_en),
    .d      (cachereq_type_out),
    .q      (cachereq_type_reg_out)
  );

  vc_EnResetReg #(`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw), 0) cachereq_addr_reg
  (
    .clk    (clk),
    .reset  (reset),
    .en     (cachereq_en),
    .d      (cachereq_addr_out),
    .q      (cachereq_addr_reg_out)
  );

  vc_EnResetReg #(`VC_MEM_REQ_MSG_OPAQUE_NBITS(o,abw,dbw), 0) cachereq_opaque_reg
  (
    .clk    (clk),
    .reset  (reset),
    .en     (cachereq_en),
    .d      (cachereq_opaque_out),
    .q      (cachereq_opaque_reg_out)
  );

  vc_EnResetReg #(`VC_MEM_REQ_MSG_DATA_NBITS(o,abw,dbw), 0) cachereq_data_reg
  (
    .clk    (clk),
    .reset  (reset),
    .en     (cachereq_en),
    .d      (cachereq_data_out),
    .q      (cachereq_data_reg_out)
  );

  vc_EnResetReg #(1, 0) cachereq_domain_reg
  (
    .clk    (clk),
    .reset  (reset),
    .en     (cachereq_en),
    .d      (cachereq_domain),
    .q      (cachereq_domain_reg_out)
  );

  assign cachereq_type = cachereq_type_reg_out;
  assign cachereq_addr = cachereq_addr_reg_out;
  assign cachereq_nsbit= cachereq_domain_reg_out;

  assign cacheresp_domain= cachereq_domain_reg_out;

  // Register the unpacked data from memresp_msg

  wire [clw-1:0]                                   {Domain cachereq_nsbit} memresp_data_reg_out;
  wire											   {L} memresp_domain_reg_out;

  vc_EnResetReg #(clw, 0) memresp_data_reg
  (
    .clk    (clk),
    .reset  (reset),
    .en     (memresp_en),
    .d      (memresp_data_out),
    .q      (memresp_data_reg_out)
  );

  vc_EnResetReg #(1, 0) memresp_domain_reg
  (
	.clk	(clk),
	.reset	(reset),
	.en		(memresp_en),
	.d		(memresp_domain),
	.q		(memresp_domain_reg_out)
  );

  // Generate cachereq write data which will be the data field or some
  // calculation with the read data for amos

  wire [`VC_MEM_REQ_MSG_DATA_NBITS(o,abw,dbw)-1:0] {Domain cachereq_nsbit} cachereq_write_data;
  wire [`VC_MEM_REQ_MSG_DATA_NBITS(o,abw,dbw)-1:0] {Domain cachereq_nsbit} read_byte_sel_mux_out;

  vc_Mux4 #(dbw) amo_sel_mux
  (
    .domain (cachereq_nsbit),
    .in0  (cachereq_data_reg_out),
    .in1  (cachereq_data_reg_out + read_byte_sel_mux_out),
    .in2  (cachereq_data_reg_out & read_byte_sel_mux_out),
    .in3  (cachereq_data_reg_out | read_byte_sel_mux_out),
    .sel  (amo_sel),
    .out  (cachereq_write_data)
  );


  // Replicate cachereq_write_data

  wire [`VC_MEM_REQ_MSG_DATA_NBITS(o,abw,dbw)*clw/dbw-1:0] {Domain cachereq_nsbit} cachereq_write_data_replicated;

  genvar i;
  generate
    for ( i = 0; i < clw/dbw; i = i + 1 ) begin
      assign cachereq_write_data_replicated[`VC_MEM_REQ_MSG_DATA_NBITS(o,abw,dbw)*(i+1)-1:`VC_MEM_REQ_MSG_DATA_NBITS(o,abw,dbw)*i] = cachereq_write_data;
    end
  endgenerate

  // Refill mux

  wire [`VC_MEM_RESP_MSG_DATA_NBITS(o,clw)-1:0] {Domain cachereq_nsbit} refill_mux_out;

  vc_Mux2 #(clw) refill_mux
  (
    .domain (cachereq_nsbit),
    .in0  (cachereq_write_data_replicated),
    .in1  (memresp_data_reg_out),
    .sel  (is_refill),
    .out  (refill_mux_out)
  );

  // Taking slices of the cache request address
  //     byte offset: 2 bits wide
  //     word offset: 2 bits wide
  //     index: $clog2(nblocks) - 1 bits wide
  //     nbits: width of tag = width of addr - $clog2(nblocks) - 4
  //     entries: 256*8/128 = 16
  wire [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-4-1:0] {Domain cachereq_nsbit} cachereq_tag;
  // Index is 3 bits to account for the way number
  wire [2:0]                                         {Domain cachereq_nsbit} cachereq_idx;

  assign cachereq_tag = cachereq_addr_reg_out[`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-1:4];
  // -1 for way
  assign cachereq_idx = cachereq_addr_reg_out[4+p_idx_shamt +: 3];

  // Tag array
  wire                                             {L} tag_array_0_domain;
  wire [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-1:0] {Domain tag_array_0_domain}tag_array_0_read_out;

  vc_CombinationalSRAM_1rw #(`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw),nblocks/2) tag_array_0
  (
    .clk           (clk),
    .reset         (reset),
    .in_domain     (cachereq_nsbit),
    .read_addr     (cachereq_idx),
    .read_data     (tag_array_0_read_out),
    .out_domain    (tag_array_0_domain),
    .write_en      (tag_array_0_wen),
    .read_en       (tag_array_0_ren),
    .write_byte_en (4'b1111),
    .write_addr    (cachereq_idx),
    .write_data    ( { 4'h0, cachereq_tag } )
  );

  // Tag array 1
  wire                                             {L} tag_array_1_domain;
  wire [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-1:0] {Domain tag_array_1_domain}tag_array_1_read_out;

  vc_CombinationalSRAM_1rw #(`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw),nblocks/2) tag_array_1
  (
    .clk           (clk),
    .reset         (reset),
    .in_domain     (cachereq_nsbit),
    .read_addr     (cachereq_idx),
    .read_data     (tag_array_1_read_out),
    .out_domain    (tag_array_1_domain),
    .write_en      (tag_array_1_wen),
    .read_en       (tag_array_1_ren),
    .write_byte_en (4'b1111),
    .write_addr    (cachereq_idx),
    .write_data    ( { 4'h0, cachereq_tag } )
  );

  // security tag array 0
  wire	{L} nsb_array_0_read_out;

  vc_Regfile_1r1w #(1, nblocks/2) nsb_array_0
  (
	.clk			(clk),
	.reset			(reset),
	.read_addr		(cachereq_idx),
	.read_data		(nsb_array_0_read_out),
	.write_en		(nsb_array_0_wen),
	.write_addr		(cachereq_idx),
	.write_data		(memresp_domain_reg_out)
  );

  // security tag array 1
  wire	{L} nsb_array_1_read_out;

  vc_Regfile_1r1w #(1, nblocks/2) nsb_array_1
  (
	.clk			(clk),
	.reset			(reset),
	.read_addr		(cachereq_idx),
	.read_data		(nsb_array_1_read_out),
	.write_en		(nsb_array_1_wen),
	.write_addr		(cachereq_idx),
	.write_data		(memresp_domain_reg_out)
  );	

  wire           {L} data_array_domain;
  wire [clw-1:0] {Domain data_array_domain} data_array_read_out;

  // Data array
  vc_CombinationalSRAM_1rw #(clw, nblocks) data_array
  (
    .clk           (clk),
    .reset         (reset),
    // Whether way_sel is appended or prepended does not matter since
    // it's just a matter of how the cachelines are actually organized in
    // the data_array
    .in_domain     (cachereq_nsbit),
    .read_addr     ( { cachereq_idx, way_sel } ),
    .read_data     (data_array_read_out),
    .out_domain    (data_array_domain),
    .write_en      (data_array_wen),
    .read_en       (data_array_ren),
    .write_byte_en (data_array_wben),
    .write_addr    ( { cachereq_idx, way_sel } ),
    .write_data    (refill_mux_out)
  );

  // Eq comparator to check for tag matching (tag_compare_0)
  wire  [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-1:0] {Domain cachereq_nsbit} tag_array_0_out;
  assign tag_array_0_out = (cachereq_nsbit == tag_array_0_domain) ? tag_array_0_read_out : 0;

  vc_EqComparator #(`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-4) tag_compare_0
  (
    .domain (cachereq_nsbit),
    .in0 (cachereq_tag),
    .in1 (tag_array_0_out[27:0]),
    .out (tag_match_0)
  );

  wire  [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-1:0] {Domain cachereq_nsbit} tag_array_1_out;
  assign tag_array_1_out = (cachereq_nsbit == tag_array_1_domain) ? tag_array_1_read_out : 0;
  // Eq comparator to check for tag matching (tag_compare_1)
  vc_EqComparator #(`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-4) tag_compare_1
  (
    .domain (cachereq_nsbit),
    .in0 (cachereq_tag),
    .in1 (tag_array_1_out[27:0]),
    .out (tag_match_1)
  );

  // Gt comparator to check for NS-bit matching (nsbit_compare_0)
  vc_GEtComparator #(1)	nsbit_compare_0
  (
    .domain (2),
	.in0 (cachereq_domain_reg_out),
	.in1 (nsb_array_0_read_out),
	.out (nsb_match_0)
  );

  // Gt comparator to check for NS-bit matching (nsbit_compare_1)
  vc_GEtComparator #(1) nsbit_compare_1
  (
    .domain (2),
	.in0 (cachereq_domain_reg_out),
	.in1 (nsb_array_1_read_out),
	.out (nsb_match_1)
  );

  // Mux that selects between the ways for requesting from memory
  wire [27:0]    {Domain cachereq_nsbit} way_sel_mux_out;

  vc_Mux2 #(`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-4) way_sel_mux
  (
    .domain (cachereq_nsbit),
    .in0 (tag_array_0_read_out[27:0]),
    .in1 (tag_array_1_read_out[27:0]),
    .sel (way_sel),
    .out (way_sel_mux_out)
  );

  // Read data register

  wire [clw-1:0]   {Domain cachereq_nsbit} read_data_reg_out;

  vc_EnResetReg #(clw, 0) read_data_reg
  (
    .clk    (clk),
    .reset  (reset),
    .domain (cachereq_nsbit),
    .en     (read_data_reg_en),
    .d      (data_array_read_out),
    .q      (read_data_reg_out)
  );

  // Read data register

  wire [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-4-1:0]    {Domain cachereq_nsbit} read_tag_reg_out;

  vc_EnResetReg #(`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-4, 0) read_tag_reg
  (
    .clk    (clk),
    .reset  (reset),
    .domain (cachereq_nsbit),
    .en     (read_tag_reg_en),
    .d      (way_sel_mux_out),
    .q      (read_tag_reg_out)
  );

  // Memreq Type Mux

  wire [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-4-1:0] {Domain cachereq_nsbit} memreq_type_mux_out;

  vc_Mux2 #(`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-4) memreq_type_mux
  (
    .domain (cachereq_nsbit),
    .in0  (cachereq_tag),
    .in1  (read_tag_reg_out),
    // TODO: change the following
    .sel  (memreq_type[0]),
    .out  (memreq_type_mux_out)
  );

  // Pack address for memory request

  wire [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,clw)-1:0] {Domain memreq_domain} memreq_addr;
  assign memreq_addr = (memreq_domain == cachereq_nsbit) ? { memreq_type_mux_out, 4'b0000 } : 0;

  // Select byte for cache response

  vc_Mux4 #(dbw) read_byte_sel_mux
  (
    .domain (cachereq_nsbit),
    .in0  (read_data_reg_out[dbw-1:0]),
    .in1  (read_data_reg_out[2*dbw-1:1*dbw]),
    .in2  (read_data_reg_out[3*dbw-1:2*dbw]),
    .in3  (read_data_reg_out[4*dbw-1:3*dbw]),
    .sel  (read_byte_sel),
    .out  (read_byte_sel_mux_out)
  );

  // mask data for cache response if insecure
  wire	[dbw-1:0]	{Domain cacheresp_domain} cacheresp_data;

  vc_Mux2 #(dbw) mask_data_mux
  (
    .domain (cachereq_nsbit),
	.in0  (read_byte_sel_mux_out),
    .in1  ({dbw{1'bx}}),
    .sel  (secure_mask),
	.out  (cacheresp_data)
  );	

  // Pack cache response
    
  wire [`VC_MEM_RESP_MSG_OPAQUE_NBITS(o,dbw)-1:0] {Domain cacheresp_domain} cacheresp_opaque;
  assign cacheresp_opaque = (cacheresp_domain == cachereq_nsbit) ? cachereq_opaque_reg_out : 0;

  vc_MemRespMsgPack#(o,dbw) cacheresp_msg_pack
  (
    .domain (cacheresp_domain),
    .type   (cacheresp_type),
    .opaque (cacheresp_opaque),
    .len    (0),
    .data   (cacheresp_data),
    .msg    (cacheresp_msg)
  );

  wire [`VC_MEM_REQ_MSG_DATA_NBITS(o,abw,clw)-1:0] {Domain memreq_domain} memreq_data;
  assign memreq_data = (memreq_domain == cachereq_nsbit) ? cachereq_write_data_replicated : 0;
  // Pack cache response
  vc_MemReqMsgPack#(o,abw,clw) memreq_msg_pack
  (
    .domain (memreq_domain),
    .type   (memreq_type),
    .opaque (0),
    .addr   (memreq_addr),
    .len    (0),
    .data   (memreq_data),
    .msg    (memreq_msg)
  );

  assign memreq_domain = cachereq_domain_reg_out;

endmodule

`endif
