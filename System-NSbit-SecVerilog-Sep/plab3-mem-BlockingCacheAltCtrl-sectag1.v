//=========================================================================
// Alternative Blocking Cache Control
//=========================================================================

`ifndef PLAB3_MEM_BLOCKING_CACHE_ALT_CTRL_V
`define PLAB3_MEM_BLOCKING_CACHE_ALT_CTRL_V

`include "plab5-mcore-define.v"
`include "plab3-mem-DecodeWben.v"
`include "vc-mem-msgs.v"
`include "vc-assert.v"

module plab3_mem_BlockingCacheAltCtrl
#(
  parameter size    = 256,            // Cache size in bytes

  parameter p_idx_shamt = 0,

  parameter p_opaque_nbits  = 8,

  // local parameters not meant to be set from outside
  parameter dbw     = 32,             // Short name for data bitwidth
  parameter abw     = 32,             // Short name for addr bitwidth
  parameter clw     = 128,            // Short name for cacheline bitwidth
  parameter nblocks = size*8/clw,     // Number of blocks in the cache

  parameter o = p_opaque_nbits
)
(
  input                                               {L}       clk,
  input                                               {L}       reset,

  // Cache Request

  inout												  {L}                       cachereq_domain,
  input                                               {Domain cachereq_domain}  cachereq_val,
  output reg                                          {Domain cachereq_domain}  cachereq_rdy,

  // Cache Response

  output reg                                          {Domain cacheresp_domain} cacheresp_val,
  input                                               {Domain cacheresp_domain} cacheresp_rdy,
  input                                               {L}                       cacheresp_domain,

  // Memory Request

  output											  {L}                       memreq_domain,
  output reg                                          {Domain memreq_domain}    memreq_val,
  input                                               {Domain memreq_domain}    memreq_rdy,

  // Memory Response

  input												  {L}                       memresp_domain,
  input                                               {Domain memresp_domain}   memresp_val,
  output reg                                          {Domain memresp_domain}   memresp_rdy,

  // control signals (ctrl->dpath)
  output reg [1:0]                                    {Domain cachereq_domain}  amo_sel,
  output reg                                          {Domain cachereq_domain}  cachereq_en,
  output reg                                          {Domain cachereq_domain}  memresp_en,
  output reg                                          {Domain cachereq_domain}  is_refill,
  output reg                                          {Domain cachereq_domain}  tag_array_0_wen,
  output reg                                          {Domain cachereq_domain}  tag_array_0_ren,
  output reg                                          {Domain cachereq_domain}  tag_array_1_wen,
  output reg                                          {Domain cachereq_domain}  tag_array_1_ren,
  output                                              {Domain cachereq_domain}  way_sel,
  output reg                                          {Domain cachereq_domain}  data_array_wen,
  output reg                                          {Domain cachereq_domain}  data_array_ren,
  // width of cacheline divided by number of bits per byte
  output reg [clw/8-1:0]                              {Domain cachereq_domain}  data_array_wben,
  output reg                                          {Domain cachereq_domain}  read_data_reg_en,
  output reg                                          {Domain cachereq_domain}  read_tag_reg_en,
  output [$clog2(clw/dbw)-1:0]                        {Domain cachereq_domain}  read_byte_sel,
  output reg [`VC_MEM_RESP_MSG_TYPE_NBITS(o,clw)-1:0] {Domain memreq_domain}    memreq_type,
  output reg [`VC_MEM_RESP_MSG_TYPE_NBITS(o,dbw)-1:0] {Domain cacheresp_domain} cacheresp_type,

   // status signals (dpath->ctrl)
  input [`VC_MEM_REQ_MSG_TYPE_NBITS(o,abw,dbw)-1:0]   {Domain cachereq_domain}  cachereq_type,
  input [`VC_MEM_REQ_MSG_ADDR_NBITS(o,abw,dbw)-1:0]   {Domain cachereq_domain}  cachereq_addr,
  input                                               {Domain cachereq_domain}  tag_match_0,
  input                                               {Domain cachereq_domain}  tag_match_1,
  input												  {L}                       nsbit_match_0,
  input												  {L}                       nsbit_match_1
 );

  //----------------------------------------------------------------------
  // State Definitions
  //----------------------------------------------------------------------

  localparam STATE_IDLE						= 5'd0;
  localparam STATE_TAG_CHECK				= 5'd1;
  localparam STATE_READ_DATA_ACCESS			= 5'd2;
  localparam STATE_WRITE_DATA_ACCESS		= 5'd3;
  localparam STATE_WAIT						= 5'd4;
  localparam STATE_REFILL_REQUEST			= 5'd5;
  localparam STATE_REFILL_WAIT				= 5'd6;
  localparam STATE_REFILL_UPDATE			= 5'd7;
  localparam STATE_EVICT_PREPARE			= 5'd8;
  localparam STATE_EVICT_REQUEST			= 5'd9;
  localparam STATE_EVICT_WAIT				= 5'd10;
  localparam STATE_AMO_READ_DATA_ACCESS		= 5'd11;
  localparam STATE_AMO_WRITE_DATA_ACCESS	= 5'd12;
  localparam STATE_FAKE_READ_DATA_ACCESS	= 5'd13;
  localparam STATE_FAKE_WRITE_DATA_ACCESS	= 5'd14;
  localparam STATE_INIT_DATA_ACCESS			= 5'd15;

  //----------------------------------------------------------------------
  // State
  //----------------------------------------------------------------------

  always @( posedge clk ) begin
    if ( reset ) begin
      state_reg <= 5'd0;
    end
    else begin
      state_reg <= state_next;
    end

  end

   //----------------------------------------------------------------------
  // State Transitions
  //----------------------------------------------------------------------

  wire {Domain cachereq_domain} in_go        = cachereq_val  && cachereq_rdy;
  wire {Domain cacheresp_domain}out_go       = cacheresp_val && cacheresp_rdy;
  wire {L}                      sec_0		 = nsbit_match_0;
  wire {L}                      sec_1		 = nsbit_match_1;
  wire {Domain cachereq_domain} hit_0        = is_valid_0 && tag_match_0 && sec_0;
  wire {Domain cachereq_domain} hit_1        = is_valid_1 && tag_match_1 && sec_1;
  wire {Domain cachereq_domain} hit          = hit_0 || hit_1;
  wire {Domain cachereq_domain} fake_hit_0	 = is_valid_0 && tag_match_0 && !sec_0;
  wire {Domain cachereq_domain} fake_hit_1	 = is_valid_1 && tag_match_1 && !sec_1;
  wire {Domain cachereq_domain} fake_hit	 = fake_hit_0 || fake_hit_1;
  wire {Domain cachereq_domain} is_read      = cachereq_type == `VC_MEM_REQ_MSG_TYPE_READ;
  wire {Domain cachereq_domain} is_write     = cachereq_type == `VC_MEM_REQ_MSG_TYPE_WRITE;
  wire {Domain cachereq_domain} is_init      = cachereq_type == `VC_MEM_REQ_MSG_TYPE_WRITE_INIT;
  wire {Domain cachereq_domain} is_amo       = amo_sel != 0;
  wire {Domain cachereq_domain} read_hit     = is_read && hit;
  wire {Domain cachereq_domain} fread_hit	 = is_read && fake_hit;
  wire {Domain cachereq_domain} write_hit    = is_write && hit;
  wire {Domain cachereq_domain} fwrite_hit	 = is_write && fake_hit;
  wire {Domain cachereq_domain} amo_hit      = is_amo && hit;
  wire {Domain cachereq_domain} miss_0       = !hit_0;
  wire {Domain cachereq_domain} miss_1       = !hit_1;
  wire {Domain cachereq_domain} refill       = (miss_0 && !is_dirty_0 && !lru_way) || (miss_1 && !is_dirty_1 && lru_way);
  wire {Domain cachereq_domain} evict        = (miss_0 && is_dirty_0 && !lru_way) || (miss_1 && is_dirty_1 && lru_way);

  reg [4:0] {Domain cachereq_domain} state_reg;
  reg [4:0] {Domain cachereq_domain} state_next;

  always @(*) begin

    state_next = state_reg;
    case ( state_reg )

      5'd0:
             if ( in_go        ) state_next = 5'd1;

      5'd1:
             if ( is_init      ) state_next = 5'd15;
        else if ( read_hit     ) state_next = 5'd2;
		else if ( fread_hit	   ) state_next = 5'd13;
        else if ( write_hit    ) state_next = 5'd3;
		else if ( fwrite_hit   ) state_next = 5'd14;
        else if ( amo_hit      ) state_next = 5'd11;
        else if ( refill       ) state_next = 5'd5;
        else if ( evict        ) state_next = 5'd8;

      5'd2:
        state_next = 5'd4;

	  5'd13:
		state_next = 5'd4;

      5'd3:
        state_next = 5'd4;

	  5'd14:
		state_next = 5'd4;

      5'd15:
        state_next = 5'd4;

      5'd11:
        state_next = 5'd12;

      5'd12:
        state_next = 5'd4;

      5'd5:
             if ( memreq_rdy && cachereq_domain == memreq_domain) 
                                 state_next = 5'd6;
        else if ( !memreq_rdy && cachereq_domain == memreq_domain  ) 
                                 state_next = 5'd5;

      5'd6:
             if ( memresp_val && cachereq_domain == memresp_domain ) 
                                 state_next = 5'd7;
        else if ( !memresp_val && cachereq_domain == memresp_domain ) 
                                 state_next = 5'd6;

      5'd7:
             if ( is_read && cachereq_domain >= memresp_domain ) 
								 state_next = 5'd2;
		else if ( is_read  && memresp_domain >  cachereq_domain   )
								 state_next = 5'd13;
        else if ( is_write && cachereq_domain >= memresp_domain   ) 
								 state_next = 5'd3;
		else if ( is_write && memresp_domain > cachereq_domain )
								 state_next = 5'd14;	
        else if ( is_amo       ) state_next = 5'd11;

      5'd8:
        state_next = 5'd9;

      5'd9:
             if ( memreq_rdy && cachereq_domain == memreq_domain ) 
                                state_next = 5'd10;
        else if ( !memreq_rdy && cachereq_domain == memreq_domain ) 
                                state_next = 5'd9;

      5'd10:
             if ( memresp_val && cachereq_domain == memresp_domain ) 
                                 state_next = 5'd5;
        else if ( !memresp_val && cachereq_domain == memresp_domain ) 
                                 state_next = 5'd10;

      5'd4:
             if ( out_go && cacheresp_domain == cachereq_domain ) 
                                 state_next = 5'd0;

    endcase

  end

  //----------------------------------------------------------------------
  // Valid/Dirty bits record
  //----------------------------------------------------------------------

  wire [2:0] {Domain cachereq_domain}   cachereq_idx = cachereq_addr[4+p_idx_shamt +: 3];
  reg        {Domain cachereq_domain}   valid_bit_in;
  reg        {Domain cachereq_domain}   valid_bits_write_en;
  wire       {Domain cachereq_domain}   valid_bits_write_en_0 = valid_bits_write_en && !way_sel;
  wire       {Domain cachereq_domain}   valid_bits_write_en_1 = valid_bits_write_en && way_sel;
  wire       {Domain cachereq_domain}   is_valid_0;
  wire       {Domain cachereq_domain}   is_valid_1;

  vc_ResetRegfile_1r1w#(1,8) valid_bits_0
  (
    .clk        (clk),
    .reset      (reset),
    .read_addr  (cachereq_idx),
    .read_data  (is_valid_0),
    .write_en   (valid_bits_write_en_0),
    .write_addr (cachereq_idx),
    .write_data (valid_bit_in)
  );

  vc_ResetRegfile_1r1w#(1,8) valid_bits_1
  (
    .clk        (clk),
    .reset      (reset),
    .read_addr  (cachereq_idx),
    .read_data  (is_valid_1),
    .write_en   (valid_bits_write_en_1),
    .write_addr (cachereq_idx),
    .write_data (valid_bit_in)
  );

  reg        {Domain cachereq_domain}   dirty_bit_in;
  reg        {Domain cachereq_domain}   dirty_bits_write_en;
  wire       {Domain cachereq_domain}   dirty_bits_write_en_0 = dirty_bits_write_en && !way_sel;
  wire       {Domain cachereq_domain}   dirty_bits_write_en_1 = dirty_bits_write_en && way_sel;
  wire       {Domain cachereq_domain}   is_dirty_0;
  wire       {Domain cachereq_domain}   is_dirty_1;

  vc_ResetRegfile_1r1w#(1,8) dirty_bits_0
  (
    .clk        (clk),
    .reset      (reset),
    .in_domain  (cachereq_domain),
    .read_addr  (cachereq_idx),
    .read_data  (is_dirty_0),
    .write_en   (dirty_bits_write_en_0),
    .write_addr (cachereq_idx),
    .write_data (dirty_bit_in)
  );

  vc_ResetRegfile_1r1w#(1,8) dirty_bits_1
  (
    .clk        (clk),
    .reset      (reset),
    .in_domain  (cachereq_domain),
    .read_addr  (cachereq_idx),
    .read_data  (is_dirty_1),
    .write_en   (dirty_bits_write_en_1),
    .write_addr (cachereq_idx),
    .write_data (dirty_bit_in)
  );

  reg        {Domain cachereq_domain}    lru_bit_in;
  reg        {Domain cachereq_domain}    lru_bits_write_en;
  wire       {Domain cachereq_domain}    lru_way;

  vc_ResetRegfile_1r1w#(1,8) lru_bits
  (
    .clk        (clk),
    .reset      (reset),
    .in_domain  (cachereq_domain),
    .read_addr  (cachereq_idx),
    .read_data  (lru_way),
    .write_en   (lru_bits_write_en),
    .write_addr (cachereq_idx),
    .write_data (lru_bit_in)
  );

  //----------------------------------------------------------------------
  // Way selection.
  //   The way is determined in the tag check state, and is
  //   then recorded for the entire transaction
  //----------------------------------------------------------------------

  reg        {Domain cachereq_domain}   way_record_en;
  reg        {Domain cachereq_domain}   way_record_in;

  always @(*) begin
    if (hit) begin
      way_record_in = hit_0 ? 1'b0 :
                      ( hit_1 ? 1'b1 : 1'bx );
    end
    else
      way_record_in = lru_way; // If miss, write to the LRU way
  end

  vc_EnResetReg #(1, 0) way_record
  (
    .clk    (clk),
    .reset  (reset),
    .domain (cachereq_domain),
    .en     (way_record_en),
    .d      (way_record_in),
    .q      (way_sel)
  );

  //----------------------------------------------------------------------
  // State Outputs
  //----------------------------------------------------------------------

  reg {Domain cachereq_domain}  tag_array_wen;
  reg {Domain cachereq_domain}  tag_array_ren;

  always@(*) begin
	
    if ( cachereq_domain == cacheresp_domain && cachereq_domain == memreq_domain 
            && cachereq_domain == memresp_domain) begin
	cachereq_rdy        = 1'b0;
	cacheresp_val       = 1'b0;
	memreq_val          = 1'b0;
    memresp_rdy         = 1'b0;
    cachereq_en         = 1'bx;
    memresp_en          = 1'bx;
    is_refill           = 1'bx;
    tag_array_wen       = 1'b0;
    tag_array_ren       = 1'b0;
	data_array_wen      = 1'b0;
    data_array_ren      = 1'b0;
    read_data_reg_en    = 1'b0;
    read_tag_reg_en     = 1'b0;
    memreq_type         = 1'bx;
    valid_bit_in        = 1'bx;
    valid_bits_write_en = 1'b0;
    dirty_bit_in        = 1'bx;
    dirty_bits_write_en = 1'b0;
    lru_bits_write_en   = 1'b0;
    way_record_en       = 1'b0;

	
	case ( state_reg )
		
		5'd0:	begin
			cachereq_rdy        = 1'b1;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b1;
    		memresp_en          = 1'b0;
    		is_refill           = 1'bx;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b0;
    		way_record_en       = 1'b0;
		end

		5'd1: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'bx;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b1;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b0;
    		way_record_en       = 1'b1;
		end

		5'd2: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'bx;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b1;
    		read_data_reg_en    = 1'b1;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b1;
    		way_record_en       = 1'b0;
		end

		5'd13: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'bx;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b1;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b0;
    		way_record_en       = 1'b0;
		end
		
		5'd3: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'b0;
    		tag_array_wen       = 1'b1;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b1;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'b1;
    		valid_bits_write_en = 1'b1;
    		dirty_bit_in        = 1'b1;
    		dirty_bits_write_en = 1'b1;
    		lru_bits_write_en   = 1'b1;
    		way_record_en       = 1'b0;
		end

		5'd14: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'b0;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b0;
    		way_record_en       = 1'b0;
		end

		5'd15: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'b0;
    		tag_array_wen       = 1'b1;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b1;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'b1;
    		valid_bits_write_en = 1'b1;
    		dirty_bit_in        = 1'b0;
    		dirty_bits_write_en = 1'b1;
    		lru_bits_write_en   = 1'b1;
    		way_record_en       = 1'b0;
		end

		5'd11: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'bx;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b1;
    		read_data_reg_en    = 1'b1;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b1;
    		way_record_en       = 1'b0;
		end

		5'd12: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'b0;
    		tag_array_wen       = 1'b1;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b1;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'b1;
    		valid_bits_write_en = 1'b1;
    		dirty_bit_in        = 1'b1;
    		dirty_bits_write_en = 1'b1;
    		lru_bits_write_en   = 1'b1;
    		way_record_en       = 1'b0;
		end

		5'd5: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b1;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'bx;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'b0;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b0;
    		way_record_en       = 1'b0;
		end

		5'd6: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b1;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b1;
    		is_refill           = 1'bx;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b0;
    		way_record_en       = 1'b0;
		end

		5'd7: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'b1;
    		tag_array_wen       = 1'b1;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b1;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'b1;
    		valid_bits_write_en = 1'b1;
    		dirty_bit_in        = 1'b0;
    		dirty_bits_write_en = 1'b1;
    		lru_bits_write_en   = 1'b0;
    		way_record_en       = 1'b0;
		end

		5'd8: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'bx;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b1;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b1;
    		read_data_reg_en    = 1'b1;
    		read_tag_reg_en     = 1'b1;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b0;
    		way_record_en       = 1'b0;
		end

		5'd9: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b1;
    		memresp_rdy         = 1'b0;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'bx;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'b1;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b0;
    		way_record_en       = 1'b0;
		end

		5'd10: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b0;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b1;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'bx;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b0;
    		way_record_en       = 1'b0;
		end

		5'd4: begin
			cachereq_rdy        = 1'b0;
			cacheresp_val       = 1'b1;
			memreq_val          = 1'b0;
    		memresp_rdy         = 1'b1;
    		cachereq_en         = 1'b0;
    		memresp_en          = 1'b0;
    		is_refill           = 1'bx;
    		tag_array_wen       = 1'b0;
    		tag_array_ren       = 1'b0;
    		data_array_wen      = 1'b0;
    		data_array_ren      = 1'b0;
    		read_data_reg_en    = 1'b0;
    		read_tag_reg_en     = 1'b0;
    		memreq_type         = 1'bx;
    		valid_bit_in        = 1'bx;
    		valid_bits_write_en = 1'b0;
    		dirty_bit_in        = 1'bx;
    		dirty_bits_write_en = 1'b0;
    		lru_bits_write_en   = 1'b0;
    		way_record_en       = 1'b0;
		end
	endcase
  end
  end

  // lru bit determination
  always @(*) begin
    lru_bit_in = !way_sel;
  end

  // tag array enables

  always @(*) begin
    tag_array_0_wen = tag_array_wen && !way_sel;
    tag_array_0_ren = tag_array_ren;
    tag_array_1_wen = tag_array_wen && way_sel;
    tag_array_1_ren = tag_array_ren;
  end

  // Building data_array_wben
  // This is in control because we want to facilitate more complex patterns
  //   when we want to start supporting subword accesses

  wire [1:0]  {Domain cachereq_domain}  cachereq_offset = cachereq_addr[3:2];
  wire [15:0] {Domain cachereq_domain}  wben_decoder_out;

  plab3_mem_DecoderWben#(2) wben_decoder
  (
    .domain(cachereq_domain),
    .in  (cachereq_offset),
    .out (wben_decoder_out)
  );

  // Choose byte to read from cacheline based on what the offset was

  assign read_byte_sel = cachereq_offset;

  // Pass cache request domain to memory request domain
  assign memreq_domain = cachereq_domain;

  // determine amo type

  always @(*) begin
    case ( cachereq_type )
      `VC_MEM_REQ_MSG_TYPE_AMO_ADD: amo_sel = 2'h1;
      `VC_MEM_REQ_MSG_TYPE_AMO_AND: amo_sel = 2'h2;
      `VC_MEM_REQ_MSG_TYPE_AMO_OR : amo_sel = 2'h3;
      default                     : amo_sel = 2'h0;
    endcase
  end

  // managing the wben

  always @(*) begin
    // Logic to enable writing of the entire cacheline in case of refill and just one word for writes and init

    if ( is_refill )
      data_array_wben = 16'hffff;
    else
      data_array_wben = wben_decoder_out;

    // Managing the cache response type based on cache request type

    cacheresp_type = cachereq_type;
  end

  //----------------------------------------------------------------------
  // Assertions
  //----------------------------------------------------------------------

  always @( posedge clk ) begin
    if ( !reset ) begin
      `VC_ASSERT_NOT_X( cachereq_val  );
      `VC_ASSERT_NOT_X( cacheresp_rdy );
      `VC_ASSERT_NOT_X( memreq_rdy    );
      `VC_ASSERT_NOT_X( memresp_val   );
    end
  end

endmodule

`endif
