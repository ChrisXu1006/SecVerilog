//=========================================================================
// 5-Stage Bypass Pipelined Processor Control
//=========================================================================

`ifndef PLAB2_PROC_PIPELINED_PROC_BYPASS_CTRL_V
`define PLAB2_PROC_PIPELINED_PROC_BYPASS_CTRL_V

`include "vc-PipeCtrl.v"
`include "vc-mem-msgs.v"
`include "vc-assert.v"
`include "pisa-inst.v"

module plab2_proc_PipelinedProcBypassCtrl
(
  input {L} clk,
  input {L} reset,

  input {L} domain,
  // Instruction Memory Port

  output        {L} imemreq_val,
  input         {L} imemreq_rdy,

  input         {L} imemresp_val,
  output        {L} imemresp_rdy,

  output        {L} imemresp_drop,

  // Data Memory Port

  output                                           {L} dmemreq_val,
  input                                            {L} dmemreq_rdy,
  output [`VC_MEM_REQ_MSG_TYPE_NBITS(8,32,32)-1:0] {L} dmemreq_msg_type,

  input                                            {L} dmemresp_val,
  output                                           {L} dmemresp_rdy,

  // mngr communication port

  input         {L} from_mngr_val,
  output        {L} from_mngr_rdy,

  output        {L} to_mngr_val,
  input         {L} to_mngr_rdy,

  // mul unit ports (control and status)

  output        {L} mul_req_val_D,
  input         {L} mul_req_rdy_D,

  input         {L} mul_resp_val_X,
  output        {L} mul_resp_rdy_X,

  // control signals (ctrl->dpath)

  output [1:0]  {L} pc_sel_F,
  output        {L} reg_en_F,
  output        {L} reg_en_D,
  output        {L} reg_en_X,
  output        {L} reg_en_M,
  output        {L} reg_en_W,
  output [1:0]  {L} op0_sel_D,
  output [2:0]  {L} op1_sel_D,
  output [1:0]  {L} op0_byp_sel_D,
  output [1:0]  {L} op1_byp_sel_D,
  output [1:0]  {L} mfc_sel_D,
  output [3:0]  {L} alu_fn_X,
  output        {L} ex_result_sel_X,
  output        {L} wb_result_sel_M,
  output [4:0]  {L} rf_waddr_W,
  output        {L} rf_wen_W,
  output        {L} stats_en_wen_W,

  // status signals (dpath->ctrl)

  input [31:0]  {Domain domain} inst_D,
  input         {L} br_cond_zero_X,
  input         {L} br_cond_neg_X,
  input         {L} br_cond_eq_X

);

  //----------------------------------------------------------------------
  // F stage
  //----------------------------------------------------------------------

  wire {L} reg_en_F;
  wire {L} val_F;
  wire {L} stall_F;
  wire {L} squash_F;

  wire {L} val_FD;
  wire {L} stall_FD;
  wire {L} squash_FD;

  wire {L} stall_PF;
  wire {L} squash_PF;

  vc_PipeCtrl pipe_ctrl_F
  (
    .clk         ( clk       ),
    .reset       ( reset     ),

    .prev_val    ( 1'b1      ),
    .prev_stall  ( stall_PF  ),
    .prev_squash ( squash_PF ),

    .curr_reg_en ( reg_en_F  ),
    .curr_val    ( val_F     ),
    .curr_stall  ( stall_F   ),
    .curr_squash ( squash_F  ),

    .next_val    ( val_FD    ),
    .next_stall  ( stall_FD  ),
    .next_squash ( squash_FD )
  );

  // PC Mux select

  wire [1:0] pm_x     = 2'dx; // Don't care
  wire [1:0] pm_p     = 2'd0; // Use pc+4
  wire [1:0] pm_b     = 2'd1; // Use branch address
  wire [1:0] pm_j     = 2'd2; // Use jump address (imm)
  wire [1:0] pm_r     = 2'd3; // Use jump address (reg)

  reg  [1:0] {L} j_pc_sel_D;
  wire [1:0] {L} br_pc_sel_X;

  assign pc_sel_F = ( br_pc_sel_X ? br_pc_sel_X :
                    (  j_pc_sel_D ? j_pc_sel_D  :
                                    pm_p          ) );

  wire {L} stall_imem_F;

  assign imemreq_val = !stall_PF;

  assign imemresp_rdy = !stall_FD;
  assign stall_imem_F = !imemresp_val && !imemresp_drop;

  // we drop the mem response when we are getting squashed

  assign imemresp_drop = squash_FD && !stall_FD;

  assign stall_F = stall_imem_F;
  assign squash_F = 1'b0;


  //----------------------------------------------------------------------
  // D stage
  //----------------------------------------------------------------------

  wire {L} reg_en_D;
  wire {L} val_D;
  wire {L} stall_D;
  wire {L} squash_D;

  wire {L} val_DX;
  wire {L} stall_DX;
  wire {L} squash_DX;

  vc_PipeCtrl pipe_ctrl_D
  (
    .clk         ( clk       ),
    .reset       ( reset     ),

    .prev_val    ( val_FD    ),
    .prev_stall  ( stall_FD  ),
    .prev_squash ( squash_FD ),

    .curr_reg_en ( reg_en_D  ),
    .curr_val    ( val_D     ),
    .curr_stall  ( stall_D   ),
    .curr_squash ( squash_D  ),

    .next_val    ( val_DX    ),
    .next_stall  ( stall_DX  ),
    .next_squash ( squash_DX )
  );

  // decode logic

  // Parse instruction fields

  wire   [4:0] {L} inst_rs_D;
  wire   [4:0] {L} inst_rt_D;
  wire   [4:0] {L} inst_rd_D;

  //pisa_InstUnpack inst_unpack
  //(
  //  .inst     (inst_D),
  //  .opcode   (),
  //  .rs       (inst_rs_D),
  //  .rt       (inst_rt_D),
  //  .rd       (inst_rd_D),
  //  .shamt    (),
  //  .func     (),
  //  .imm      (),
  //  .target   ()
  //);

  // Shorten register specifier name for table

  wire [4:0] {L} rs = inst_rs_D;
  wire [4:0] {L} rt = inst_rt_D;
  wire [4:0] {L} rd = inst_rd_D;

  // Generic Parameters

  wire n = 1'd0;
  wire y = 1'd1;

  // Register specifiers

  wire [4:0] rx = 5'bx;
  wire [4:0] r0 = 5'd0;
  wire [4:0] rL = 5'd31;

  // Branch type

  wire [2:0] br_x     = 3'dx; // Don't care
  wire [2:0] br_none  = 3'd0; // No branch
  wire [2:0] br_bne   = 3'd1; // bne
  wire [2:0] br_beq   = 3'd2; // beq
  wire [2:0] br_bgez  = 3'd3; // bgez
  wire [2:0] br_bgtz  = 3'd4; // bgtz
  wire [2:0] br_blez  = 3'd5; // blez
  wire [2:0] br_bltz  = 3'd6; // bltz

  // Jump type

  wire [1:0] j_x = 2'dx; // Don't care
  wire [1:0] j_n = 2'd0; // No jump
  wire [1:0] j_j = 2'd1; // jump (imm)
  wire [1:0] j_r = 2'd2; // jump (reg)

  // Operand 0 Mux Select

  wire [1:0] am_x     = 2'bx; // Don't care
  wire [1:0] am_rdat  = 2'd0; // Use data from register file
  wire [1:0] am_samt  = 2'd1; // Use shift amount from immediate
  wire [1:0] am_16    = 2'd2; // Use constant 16 (for lui)

  // Operand 1 Mux Select

  wire [2:0] bm_x     = 3'bx; // Don't care
  wire [2:0] bm_rdat  = 3'd0; // Use data from register file
  wire [2:0] bm_si    = 3'd1; // Use sign-extended immediate
  wire [2:0] bm_zi    = 3'd2; // Use zero-extended immediate
  wire [2:0] bm_pc    = 3'd3; // Use PC+4
  wire [2:0] bm_fhst  = 3'd4; // Use from mngr data

  // Bypass path Mux select

  wire [1:0] byp_r    = 2'd0; // Use regfile
  wire [1:0] byp_x    = 2'd1; // Bypass from X stage
  wire [1:0] byp_m    = 2'd2; // Bypass from X stage
  wire [1:0] byp_w    = 2'd3; // Bypass from X stage

  // ALU Function

  wire [3:0] alu_x    = 4'bx;
  wire [3:0] alu_add  = 4'd0;
  wire [3:0] alu_sub  = 4'd1;
  wire [3:0] alu_sll  = 4'd2;
  wire [3:0] alu_or   = 4'd3;
  wire [3:0] alu_lt   = 4'd4;
  wire [3:0] alu_ltu  = 4'd5;
  wire [3:0] alu_and  = 4'd6;
  wire [3:0] alu_xor  = 4'd7;
  wire [3:0] alu_nor  = 4'd8;
  wire [3:0] alu_srl  = 4'd9;
  wire [3:0] alu_sra  = 4'd10;
  wire [3:0] alu_cp0  = 4'd11;
  wire [3:0] alu_cp1  = 4'd12;

  // Memory Request Type

  wire [2:0] nr       = 3'd0; // No request
  wire [2:0] ld       = 3'd1; // Load
  wire [2:0] st       = 3'd2; // Store
  wire [2:0] ad       = 3'd3; // amo.add
  wire [2:0] an       = 3'd4; // amo.add
  wire [2:0] ao       = 3'd5; // amo.add

  // Multiply Request Type

  wire mul_n    = 1'd0; // No multiply
  wire mul_m    = 1'd1; // Multiply

  // Execute Mux Select

  wire xm_x     = 1'bx; // Don't care
  wire xm_a     = 1'b0; // Use ALU output
  wire xm_m     = 1'b1; // Use mul unit reponse

  // Writeback Mux Select

  wire wm_x     = 1'bx; // Don't care
  wire wm_a     = 1'b0; // Use ALU output
  wire wm_m     = 1'b1; // Use data memory response

  // Instruction Decode

  reg       {L} inst_val_D;
  reg [1:0] {L} j_type_D;
  reg [2:0] {L} br_type_D;
  reg       {L} rs_en_D;
  reg [1:0] {L} op0_sel_D;
  reg       {L} rt_en_D;
  reg [2:0] {L} op1_sel_D;
  reg [3:0] {L} alu_fn_D;
  reg       {L} mul_req_type_D;
  reg       {L} ex_result_sel_D;
  reg [2:0] {L} dmemreq_type_D;
  reg       {L} wb_result_sel_D;
  reg       {L} rf_wen_D;
  reg [4:0] {L} rf_waddr_D;
  reg       {L} mtc_D;
  reg       {L} mfc_D;

  task cs
  (
    input        cs_val,
    input [1:0]  cs_j_type,
    input [2:0]  cs_br_type,
    input [1:0]  cs_op0_sel,
    input        cs_rs_en,
    input [2:0]  cs_op1_sel,
    input        cs_rt_en,
    input [3:0]  cs_alu_fn,
    input        cs_mul_req_type,
    input        cs_ex_result_sel,
    input [2:0]  cs_dmemreq_type,
    input        cs_wb_result_sel,
    input        cs_rf_wen,
    input [4:0]  cs_rf_waddr,
    input        cs_mtc,
    input        cs_mfc
  );
  begin
    inst_val_D       = cs_val;
    j_type_D         = cs_j_type;
    br_type_D        = cs_br_type;
    op0_sel_D        = cs_op0_sel;
    rs_en_D          = cs_rs_en;
    op1_sel_D        = cs_op1_sel;
    rt_en_D          = cs_rt_en;
    alu_fn_D         = cs_alu_fn;
    mul_req_type_D   = cs_mul_req_type;
    ex_result_sel_D  = cs_ex_result_sel;
    dmemreq_type_D   = cs_dmemreq_type;
    wb_result_sel_D  = cs_wb_result_sel;
    rf_wen_D         = cs_rf_wen;
    rf_waddr_D       = cs_rf_waddr;
    mtc_D            = cs_mtc;
    mfc_D            = cs_mfc;
  end
  endtask


  always @ (*) begin

    casez ( inst_D )

      //                          j    br       op0      rs op1      rt alu      mul    xmux  dmm wbmux rf
      //                      val type type     muxsel   en muxsel   en fn       type   sel   typ sel   wen wa  mtc  mfc
      `PISA_INST_NOP     :cs( y,  j_n, br_none, am_x,    n, bm_x,    n, alu_x,   mul_n, xm_x, nr, wm_x, n,  rx, n,   n   );

      `PISA_INST_ADDIU   :cs( y,  j_n, br_none, am_rdat, y, bm_si,   n, alu_add, mul_n, xm_a, nr, wm_a, y,  rt, n,   n   );
      `PISA_INST_SLTI    :cs( y,  j_n, br_none, am_rdat, y, bm_si,   n, alu_lt,  mul_n, xm_a, nr, wm_a, y,  rt, n,   n   );
      `PISA_INST_SLTIU   :cs( y,  j_n, br_none, am_rdat, y, bm_si,   n, alu_ltu, mul_n, xm_a, nr, wm_a, y,  rt, n,   n   );
      `PISA_INST_ORI     :cs( y,  j_n, br_none, am_rdat, y, bm_zi,   n, alu_or,  mul_n, xm_a, nr, wm_a, y,  rt, n,   n   );
      `PISA_INST_ANDI    :cs( y,  j_n, br_none, am_rdat, y, bm_zi,   n, alu_and, mul_n, xm_a, nr, wm_a, y,  rt, n,   n   );
      `PISA_INST_XORI    :cs( y,  j_n, br_none, am_rdat, y, bm_zi,   n, alu_xor, mul_n, xm_a, nr, wm_a, y,  rt, n,   n   );
      `PISA_INST_SRA     :cs( y,  j_n, br_none, am_samt, n, bm_rdat, y, alu_sra, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_SRL     :cs( y,  j_n, br_none, am_samt, n, bm_rdat, y, alu_srl, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_SLL     :cs( y,  j_n, br_none, am_samt, n, bm_rdat, y, alu_sll, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_LUI     :cs( y,  j_n, br_none, am_16,   y, bm_si,   y, alu_sll, mul_n, xm_a, nr, wm_a, y,  rt, n,   n   );

      `PISA_INST_ADDU    :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_add, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_SUBU    :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_sub, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_SLT     :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_lt,  mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_SLTU    :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_ltu, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_AND     :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_and, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_OR      :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_or,  mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_NOR     :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_nor, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_XOR     :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_xor, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_SRAV    :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_sra, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_SRLV    :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_srl, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_SLLV    :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_sll, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );

      `PISA_INST_MUL     :cs( y,  j_n, br_none, am_rdat, y, bm_rdat, y, alu_x,   mul_m, xm_m, nr, wm_a, y,  rd, n,   n   );

      `PISA_INST_BNE     :cs( y,  j_n, br_bne,  am_rdat, y, bm_rdat, y, alu_x,   mul_n, xm_x, nr, wm_x, n,  rx, n,   n   );
      `PISA_INST_BEQ     :cs( y,  j_n, br_beq,  am_rdat, y, bm_rdat, y, alu_x,   mul_n, xm_x, nr, wm_x, n,  rx, n,   n   );
      `PISA_INST_BGEZ    :cs( y,  j_n, br_bgez, am_rdat, y, bm_x,    n, alu_x,   mul_n, xm_x, nr, wm_x, n,  rx, n,   n   );
      `PISA_INST_BGTZ    :cs( y,  j_n, br_bgtz, am_rdat, y, bm_x,    n, alu_x,   mul_n, xm_x, nr, wm_x, n,  rx, n,   n   );
      `PISA_INST_BLEZ    :cs( y,  j_n, br_blez, am_rdat, y, bm_x,    n, alu_x,   mul_n, xm_x, nr, wm_x, n,  rx, n,   n   );
      `PISA_INST_BLTZ    :cs( y,  j_n, br_bltz, am_rdat, y, bm_x,    n, alu_x,   mul_n, xm_x, nr, wm_x, n,  rx, n,   n   );

      `PISA_INST_J       :cs( y,  j_j, br_none, am_x,    n, bm_x,    n, alu_x,   mul_n, xm_x, nr, wm_x, n,  rx, n,   n   );
      `PISA_INST_JR      :cs( y,  j_r, br_none, am_x,    y, bm_x,    n, alu_x,   mul_n, xm_x, nr, wm_x, n,  rx, n,   n   );
      `PISA_INST_JALR    :cs( y,  j_r, br_none, am_x,    y, bm_pc,   n, alu_cp1, mul_n, xm_a, nr, wm_a, y,  rd, n,   n   );
      `PISA_INST_JAL     :cs( y,  j_j, br_none, am_x,    n, bm_pc,   n, alu_cp1, mul_n, xm_a, nr, wm_a, y,  rL, n,   n   );

      `PISA_INST_LW      :cs( y,  j_n, br_none, am_rdat, y, bm_si,   n, alu_add, mul_n, xm_a, ld, wm_m, y,  rt, n,   n   );
      `PISA_INST_SW      :cs( y,  j_n, br_none, am_rdat, y, bm_si,   y, alu_add, mul_n, xm_a, st, wm_x, n,  rx, n,   n   );

      `PISA_INST_MFC0    :cs( y,  j_n, br_none, am_x,    n, bm_fhst, n, alu_cp1, mul_n, xm_a, nr, wm_a, y,  rt, n,   y   );
      `PISA_INST_MTC0    :cs( y,  j_n, br_none, am_x,    n, bm_rdat, y, alu_cp1, mul_n, xm_a, nr, wm_a, n,  rx, y,   n   );

      `PISA_INST_AMO_ADD :cs( y,  j_n, br_none, am_rdat, y, bm_x,    y, alu_cp0, mul_n, xm_a, ad, wm_m, y,  rd, n,   n   );
      `PISA_INST_AMO_AND :cs( y,  j_n, br_none, am_rdat, y, bm_x,    y, alu_cp0, mul_n, xm_a, an, wm_m, y,  rd, n,   n   );
      `PISA_INST_AMO_OR  :cs( y,  j_n, br_none, am_rdat, y, bm_x,    y, alu_cp0, mul_n, xm_a, ao, wm_m, y,  rd, n,   n   );

      default            :cs( n,  j_x, br_x,    am_x,    n, bm_x,    n, alu_x,   mul_n, xm_x, nr, wm_x, n,  rx, n,   n   );

    endcase
  end

  wire {L} stall_from_mngr_D;
  wire {L} stall_mul_req_D;
  wire {L} stall_hazard_D;

  // jump logic

  wire      {L} j_taken_D;
  wire      {L} squash_j_D;
  wire      {L} stall_j_D;

  always @(*) begin
    if ( val_D ) begin

      case ( j_type_D )
        j_j:     j_pc_sel_D = pm_j;
        j_r:     j_pc_sel_D = pm_r;
        default: j_pc_sel_D = pm_p;
      endcase

    end else
      j_pc_sel_D = pm_p;
  end

  assign j_taken_D = ( j_pc_sel_D != pm_p );

  assign squash_j_D = j_taken_D;

  // mtc and mfc instructions

  reg {L} to_mngr_val_D;
  reg {L} from_mngr_rdy_D;
  reg {L} stats_en_wen_D;
  reg [1:0] {L} mfc_sel_D;

  always @(*) begin
    to_mngr_val_D    = 1'b0;
    from_mngr_rdy_D  = 1'b0;
    stats_en_wen_D   = 1'b0;
    mfc_sel_D        = 2'h0;
    if ( mtc_D && rd == `PISA_CPR_PROC2MNGR )
      to_mngr_val_D    = 1'b1;
    if ( mtc_D && rd == `PISA_CPR_STATS_EN )
      stats_en_wen_D    = 1'b1;
    if ( mfc_D && rd == `PISA_CPR_MNGR2PROC )
      from_mngr_rdy_D  = 1'b1;
    if ( mfc_D && rd == `PISA_CPR_NUMCORES )
      mfc_sel_D        = 2'h1;
    if ( mfc_D && rd == `PISA_CPR_COREID )
      mfc_sel_D        = 2'h2;

  end

  // from mngr rdy signal for mfc0 instruction

  assign from_mngr_rdy =     ( val_D
                            && from_mngr_rdy_D
                            && !stall_FD );

  assign stall_from_mngr_D = ( val_D
                            && from_mngr_rdy_D
                            && !from_mngr_val );

  assign mul_req_val_D =     ( val_D
                            && ( mul_req_type_D != mul_n )
                            && !stall_FD
                            && !squash_DX );

  assign stall_mul_req_D  =  ( val_D
                            && ( mul_req_type_D != mul_n )
                            && !mul_req_rdy_D );

  // Bypassing logic

  reg [1:0] {L} op0_byp_sel_D;
  reg [1:0] {L} op1_byp_sel_D;

  always @(*) begin

    if      ( rs_en_D && val_X && rf_wen_X
         && ( inst_rs_D == rf_waddr_X )
         && ( rf_waddr_X != 5'd0 ) )
      op0_byp_sel_D = byp_x;
    else if ( rs_en_D && val_M && rf_wen_M
         && ( inst_rs_D == rf_waddr_M )
         && ( rf_waddr_M != 5'd0 ) )
      op0_byp_sel_D = byp_m;
    else if ( rs_en_D && val_W && rf_wen_W
         && ( inst_rs_D == rf_waddr_W )
         && ( rf_waddr_W != 5'd0 ) )
      op0_byp_sel_D = byp_w;
    else
      op0_byp_sel_D = byp_r;

    if      ( rt_en_D && val_X && rf_wen_X
         && ( inst_rt_D == rf_waddr_X )
         && ( rf_waddr_X != 5'd0 ) )
      op1_byp_sel_D = byp_x;
    else if ( rt_en_D && val_M && rf_wen_M
         && ( inst_rt_D == rf_waddr_M )
         && ( rf_waddr_M != 5'd0 ) )
      op1_byp_sel_D = byp_m;
    else if ( rt_en_D && val_W && rf_wen_W
         && ( inst_rt_D == rf_waddr_W )
         && ( rf_waddr_W != 5'd0 ) )
      op1_byp_sel_D = byp_w;
    else
      op1_byp_sel_D = byp_r;

  end

  // Stall for data hazards if either of the operand read addresses are
  // the same as the write addresses of instruction later in the pipeline

  assign stall_hazard_D     = val_D && (
                              //1'b0
                            ( rs_en_D && val_X && rf_wen_X
                              && ( inst_rs_D == rf_waddr_X )
                              && ( rf_waddr_X != 5'd0 )
                              && ( dmemreq_type_X != nr )
                              && ( dmemreq_type_X != st ) )
                              // we only need to stall due to load-use due
                              // to M if M is stalling due to load
                         || ( rs_en_D && val_M && rf_wen_M
                              && ( inst_rs_D == rf_waddr_M )
                              && ( rf_waddr_M != 5'd0 )
                              && ( dmemreq_type_M != nr )
                              && ( dmemreq_type_M != st )
                              && stall_dmem_M )
                         || ( rt_en_D && val_X && rf_wen_X
                              && ( inst_rt_D == rf_waddr_X )
                              && ( rf_waddr_X != 5'd0 )
                              && ( dmemreq_type_X != nr )
                              && ( dmemreq_type_X != st ) )
                              // we only need to stall due to load-use due
                              // to M if M is stalling due to load
                         || ( rt_en_D && val_M && rf_wen_M
                              && ( inst_rt_D == rf_waddr_M )
                              && ( rf_waddr_M != 5'd0 )
                              && ( dmemreq_type_M != nr )
                              && ( dmemreq_type_M != st )
                              && stall_dmem_M )
                                );


  //// we assert that the instruction is decoded properly (if it doesn't it
  //// might be due to it not being implemented)
  //always @( posedge clk ) begin
  //  if ( !reset ) begin
  //    `VC_ASSERT( inst_val_D );
  //  end
  //end

  assign stall_D = stall_from_mngr_D || stall_hazard_D || stall_mul_req_D;
  assign squash_D = squash_j_D;

  //----------------------------------------------------------------------
  // X stage
  //----------------------------------------------------------------------

  wire {L} reg_en_X;
  wire {L} val_X;
  wire {L} stall_X;
  wire {L} squash_X;

  wire {L} val_XM;
  wire {L} stall_XM;
  wire {L} squash_XM;

  vc_PipeCtrl pipe_ctrl_X
  (
    .clk         ( clk       ),
    .reset       ( reset     ),

    .prev_val    ( val_DX    ),
    .prev_stall  ( stall_DX  ),
    .prev_squash ( squash_DX ),

    .curr_reg_en ( reg_en_X  ),
    .curr_val    ( val_X     ),
    .curr_stall  ( stall_X   ),
    .curr_squash ( squash_X  ),

    .next_val    ( val_XM    ),
    .next_stall  ( stall_XM  ),
    .next_squash ( squash_XM )
  );

  reg [31:0] {Domain domain} inst_X;
  reg [3:0]  {L} alu_fn_X;
  reg        {L} mul_req_type_X;
  reg        {L} ex_result_sel_X;
  reg [2:0]  {L} dmemreq_type_X;
  reg        {L} wb_result_sel_X;
  reg        {L} rf_wen_X;
  reg [4:0]  {L} rf_waddr_X;
  reg        {L} to_mngr_val_X;
  reg        {L} stats_en_wen_X;
  reg [2:0]  {L} br_type_X;

  always @(posedge clk) begin
    if (reset) begin
      rf_wen_X        <= 1'b0;
      stats_en_wen_X  <= 1'b0;
    end else if (reg_en_X) begin
      inst_X          <= inst_D;
      alu_fn_X        <= alu_fn_D;
      dmemreq_type_X  <= dmemreq_type_D;
      mul_req_type_X  <= mul_req_type_D;
      ex_result_sel_X <= ex_result_sel_D;
      wb_result_sel_X <= wb_result_sel_D;
      rf_wen_X        <= rf_wen_D;
      rf_waddr_X      <= rf_waddr_D;
      to_mngr_val_X   <= to_mngr_val_D;
      stats_en_wen_X  <= stats_en_wen_D;
      br_type_X       <= br_type_D;
    end
  end

  // branch logic

  reg        {L} br_taken_X;
  wire       {L} squash_br_X;
  wire       {L} stall_br_X;

  always @(*) begin
    if ( val_X ) begin

      case ( br_type_X )
        br_bne :  br_taken_X = !br_cond_eq_X;
        br_beq :  br_taken_X =  br_cond_eq_X;
        br_bgez:  br_taken_X = !br_cond_neg_X ||  br_cond_zero_X;
        br_bgtz:  br_taken_X = !br_cond_neg_X && !br_cond_zero_X;
        br_blez:  br_taken_X =  br_cond_neg_X ||  br_cond_zero_X;
        br_bltz:  br_taken_X =  br_cond_neg_X && !br_cond_zero_X;
        default:  br_taken_X = 1'b0;
      endcase

    end else
      br_taken_X = 1'b0;
  end

  assign br_pc_sel_X = br_taken_X ? pm_b : pm_p;

  // squash the previous instructions on branch

  assign squash_br_X = br_taken_X;

  wire {L} dmemreq_val_X;
  wire {L} stall_dmem_X;

  // dmem logic

  reg [`VC_MEM_REQ_MSG_TYPE_NBITS(8,32,32)-1:0] {L} dmemreq_msg_type;

  assign dmemreq_val_X = val_X && ( dmemreq_type_X != nr );

  assign dmemreq_val  = dmemreq_val_X && !stall_XM;
  assign stall_dmem_X = dmemreq_val_X && !dmemreq_rdy;

  always @(*) begin
    case ( dmemreq_type_X )
      ld: dmemreq_msg_type = `VC_MEM_REQ_MSG_TYPE_READ;
      st: dmemreq_msg_type = `VC_MEM_REQ_MSG_TYPE_WRITE;
      ad: dmemreq_msg_type = `VC_MEM_REQ_MSG_TYPE_AMO_ADD;
      an: dmemreq_msg_type = `VC_MEM_REQ_MSG_TYPE_AMO_AND;
      ao: dmemreq_msg_type = `VC_MEM_REQ_MSG_TYPE_AMO_OR;
      default: dmemreq_msg_type = 'hx;
    endcase
  end

  // mul logic

  wire {L} stall_mul_resp_X;

  assign mul_resp_rdy_X =    ( val_X
                            && ( mul_req_type_X != mul_n )
                            && !stall_DX );

  assign stall_mul_resp_X  = ( val_X
                            && ( mul_req_type_X != mul_n )
                            && !mul_resp_val_X );

  // stall in X if dmem is not rdy

  assign stall_X = stall_dmem_X || stall_mul_resp_X;
  assign squash_X = squash_br_X;

  //----------------------------------------------------------------------
  // M stage
  //----------------------------------------------------------------------

  wire {L} reg_en_M;
  wire {L} val_M;
  wire {L} stall_M;
  wire {L} squash_M;

  wire {L} val_MW;
  wire {L} stall_MW;
  wire {L} squash_MW;

  vc_PipeCtrl pipe_ctrl_M
  (
    .clk         ( clk       ),
    .reset       ( reset     ),

    .prev_val    ( val_XM    ),
    .prev_stall  ( stall_XM  ),
    .prev_squash ( squash_XM ),

    .curr_reg_en ( reg_en_M  ),
    .curr_val    ( val_M     ),
    .curr_stall  ( stall_M   ),
    .curr_squash ( squash_M  ),

    .next_val    ( val_MW    ),
    .next_stall  ( stall_MW  ),
    .next_squash ( squash_MW )
  );

  reg [31:0] {Domain domain} inst_M;
  reg [2:0]  {L} dmemreq_type_M;
  reg        {L} wb_result_sel_M;
  reg        {L} rf_wen_M;
  reg [4:0]  {L} rf_waddr_M;
  reg        {L} stats_en_wen_M;
  reg        {L} to_mngr_val_M;

  always @(posedge clk) begin
    if (reset) begin
      rf_wen_M        <= 1'b0;
      stats_en_wen_M  <= 1'b0;
    end else if (reg_en_M) begin
      inst_M          <= inst_X;
      dmemreq_type_M  <= dmemreq_type_X;
      wb_result_sel_M <= wb_result_sel_X;
      rf_wen_M        <= rf_wen_X;
      rf_waddr_M      <= rf_waddr_X;
      stats_en_wen_M  <= stats_en_wen_X;
      to_mngr_val_M   <= to_mngr_val_X;
    end
  end

  wire {L} dmemreq_val_M;
  wire {L} stall_dmem_M;

  assign dmemresp_rdy = dmemreq_val_M && !stall_MW;

  assign dmemreq_val_M = val_M && ( dmemreq_type_M != nr );
  assign stall_dmem_M = ( dmemreq_val_M && !dmemresp_val );

  assign stall_M = stall_dmem_M;
  assign squash_M = 1'b0;

  //----------------------------------------------------------------------
  // W stage
  //----------------------------------------------------------------------

  wire {L} reg_en_W;
  wire {L} val_W;
  wire {L} stall_W;
  wire {L} squash_W;

  wire {L} next_stall_W;
  wire {L} next_squash_W;

  assign next_stall_W = 1'b0;
  assign next_squash_W = 1'b0;

  vc_PipeCtrl pipe_ctrl_W
  (
    .clk         ( clk       ),
    .reset       ( reset     ),

    .prev_val    ( val_MW    ),
    .prev_stall  ( stall_MW  ),
    .prev_squash ( squash_MW ),

    .curr_reg_en ( reg_en_W  ),
    .curr_val    ( val_W     ),
    .curr_stall  ( stall_W   ),
    .curr_squash ( squash_W  ),

    .next_stall  ( next_stall_W  ),
    .next_squash ( next_squash_W )
  );

  reg [31:0] {Domain domain} inst_W;
  reg        {L} rf_wen_W;
  reg [4:0]  {L} rf_waddr_W;
  reg        {L} stats_en_wen_W;
  reg        {L} to_mngr_val_W;
  wire       {L} stall_to_mngr_W;

  always @(posedge clk) begin
    if (reset) begin
      rf_wen_W      <= 1'b0;
      stats_en_wen_W<= 1'b0;
    end else if (reg_en_W) begin
      inst_W        <= inst_M;
      rf_wen_W      <= rf_wen_M;
      rf_waddr_W    <= rf_waddr_M;
      stats_en_wen_W<= stats_en_wen_M;
      to_mngr_val_W <= to_mngr_val_M;
    end
  end

  assign to_mngr_val = ( val_W
                      && to_mngr_val_W
                      && !stall_MW );

  assign stall_to_mngr_W = ( val_W
                          && to_mngr_val_W
                          && !to_mngr_rdy );

  assign stall_W = stall_to_mngr_W;
  assign squash_W = 1'b0;

endmodule

`endif

