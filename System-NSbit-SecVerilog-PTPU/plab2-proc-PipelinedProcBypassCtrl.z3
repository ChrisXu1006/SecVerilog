; this part encodes a partial order on labels
(declare-sort Label)
(declare-fun leq (Label Label) Bool)
(declare-fun join (Label Label) Label)
(declare-fun meet (Label Label) Label)
(assert (forall ((x Label)) (leq x x)))
(assert (forall ((x Label) (y Label) (z Label)) (implies (and (leq x y) (leq y z)) (leq x z))))
(assert (forall ((x Label) (y Label)) (implies (and (leq x y) (leq y x)) (= x y))))

; axioms for join
(assert (forall ((x Label) (y Label) (z Label)) (implies (leq (join x y) z) (and (leq x z) (leq y z)))))
(assert (forall ((x Label) (y Label) (z Label)) (implies (and (leq x z) (leq y z)) (leq (join x y) z))))
(assert (forall ((x Label) (y Label)) (and (leq x (join x y)) (leq y (join x y)))))
(assert (forall ((x Label) (y Label)) (= (join x y) (join y x))))

; axioms for meet
(assert (forall ((x Label) (y Label) (z Label)) (implies (leq x (meet y z)) (and (leq x y) (leq x z)))))
(assert (forall ((x Label) (y Label) (z Label)) (implies (and (leq x y) (leq x z)) (leq x (meet y z)))))
(assert (forall ((x Label) (y Label)) (and (leq (meet x y) x) (leq (meet x y) y))))
(assert (forall ((x Label) (y Label)) (= (meet x y) (meet y x))))
; convert int to bool
(declare-fun IBOOL (Int) Bool)
(assert (forall ((x Int))
    (and
        (implies (= x 0) (= (IBOOL x) false))
        (implies (not (= x 0)) (= (IBOOL x) true))
    )
))

; lattice elements
(declare-fun LOW () Label)
(declare-fun HIGH () Label)
(declare-fun D1 () Label)
(declare-fun D2 () Label)

; lattice structure
(assert (forall ((x Label)) (leq LOW x)))
(assert (forall ((x Label)) (leq x HIGH)))
(assert (not (= HIGH LOW))) ; the lattice cannot clapse

; variables to be solved
(declare-fun def_domain () Int)
(assert (<= 0  def_domain))
(assert (<= def_domain 1))

; function that maps 0 to LOW; 1 to HIGH
(declare-fun LH (Int) Label)
(assert (= (LH 0) LOW))
(assert (= (LH 1) HIGH))

; function that maps 0 to D1; 1 to D2; 2 to LOW; 3 to HIGH
(declare-fun Domain (Int) Label)
(assert (= (Domain 0) D1))
(assert (= (Domain 1) D2))
(assert (= (Domain 2) LOW))
(assert (= (Domain 3) HIGH))

; functio that maps 0 to D1; 1 to LOW
(declare-fun Control (Int) Label)
(assert (= (Control 0) D1))
(assert (= (Control 1) D2))

; function that maps 0 to Domain L0; 1 to Domain L1; .....
(declare-fun SEL (Int) Label)
(assert (= (SEL 0) (Domain L0)))
(assert (= (SEL 1) (Domain L1)))
(assert (= (SEL 2) (Domain L2)))

; assertions to be verified
PTask ignored

(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; Instantiate parameter prev_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_reg_en in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; pc_sel_F = br_pc_sel_X @plab2-proc-PipelinedProcBypassCtrl.v:148
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; pc_sel_F = j_pc_sel_D @plab2-proc-PipelinedProcBypassCtrl.v:149
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; pc_sel_F = pm_p @plab2-proc-PipelinedProcBypassCtrl.v:149
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign imemreq_val = !(stall_PF) @plab2-proc-PipelinedProcBypassCtrl.v:154
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign imemresp_rdy = !(stall_FD) @plab2-proc-PipelinedProcBypassCtrl.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign stall_imem_F = and (!(imemresp_val)) (!(imemresp_drop)) @plab2-proc-PipelinedProcBypassCtrl.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign imemresp_drop = and (squash_FD) (!(stall_FD)) @plab2-proc-PipelinedProcBypassCtrl.v:161
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign stall_F = stall_imem_F @plab2-proc-PipelinedProcBypassCtrl.v:163
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; assign squash_F = 0 @plab2-proc-PipelinedProcBypassCtrl.v:164
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_reg_en in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter inst in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter opcode in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter rs in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter rt in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter rd in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter shamt in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter func in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter imm in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter target in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign rs = inst_rs_D @plab2-proc-PipelinedProcBypassCtrl.v:230
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign rt = inst_rt_D @plab2-proc-PipelinedProcBypassCtrl.v:231
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign rd = inst_rd_D @plab2-proc-PipelinedProcBypassCtrl.v:232
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign j_taken_D = not( = j_pc_sel_D pm_p) @plab2-proc-PipelinedProcBypassCtrl.v:488
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign squash_j_D = j_taken_D @plab2-proc-PipelinedProcBypassCtrl.v:490
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain))  (Domain def_domain))))    ; assign from_mngr_rdy = and (and (val_D) (from_mngr_rdy_D)) (!(stall_FD)) @plab2-proc-PipelinedProcBypassCtrl.v:519
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain))  (Domain def_domain))))    ; assign stall_from_mngr_D = and (and (val_D) (from_mngr_rdy_D)) (!(from_mngr_val)) @plab2-proc-PipelinedProcBypassCtrl.v:523
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign mul_req_val_D = and (and (and (val_D) (not( = mul_req_type_D mul_n))) (!(stall_FD))) (!(squash_DX)) @plab2-proc-PipelinedProcBypassCtrl.v:527
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign stall_mul_req_D = and (and (val_D) (not( = mul_req_type_D mul_n))) (!(mul_req_rdy_D)) @plab2-proc-PipelinedProcBypassCtrl.v:532
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Domain def_domain) (join (join (join (join (join (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain)) (Domain def_domain)) (Domain def_domain)) (join (join (join (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain)) (Domain def_domain)) (Domain def_domain)) (Domain def_domain))) (join (join (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain)) (Domain def_domain)) (Domain def_domain))) (join (join (join (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain)) (Domain def_domain)) (Domain def_domain)) (Domain def_domain))))  (Domain def_domain))))    ; assign stall_hazard_D = and (val_D) (or (or (or (and (and (and (and (and (and (rs_en_D) (val_X)) (rf_wen_X)) (= inst_rs_D rf_waddr_X)) (not( = rf_waddr_X 0))) (not( = dmemreq_type_X nr))) (not( = dmemreq_type_X st))) (and (and (and (and (and (and (and (rs_en_D) (val_M)) (rf_wen_M)) (= inst_rs_D rf_waddr_M)) (not( = rf_waddr_M 0))) (not( = dmemreq_type_M nr))) (not( = dmemreq_type_M st))) (stall_dmem_M))) (and (and (and (and (and (and (rt_en_D) (val_X)) (rf_wen_X)) (= inst_rt_D rf_waddr_X)) (not( = rf_waddr_X 0))) (not( = dmemreq_type_X nr))) (not( = dmemreq_type_X st)))) (and (and (and (and (and (and (and (rt_en_D) (val_M)) (rf_wen_M)) (= inst_rt_D rf_waddr_M)) (not( = rf_waddr_M 0))) (not( = dmemreq_type_M nr))) (not( = dmemreq_type_M st))) (stall_dmem_M))) @plab2-proc-PipelinedProcBypassCtrl.v:578
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain))  (Domain def_domain))))    ; assign stall_D = or (or (stall_from_mngr_D) (stall_hazard_D)) (stall_mul_req_D) @plab2-proc-PipelinedProcBypassCtrl.v:617
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign squash_D = squash_j_D @plab2-proc-PipelinedProcBypassCtrl.v:618
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign intr_set = (mod_D)===(setintr) @plab2-proc-PipelinedProcBypassCtrl.v:620
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_reg_en in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:653
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; br_pc_sel_X = pm_b @plab2-proc-PipelinedProcBypassCtrl.v:730
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; br_pc_sel_X = pm_p @plab2-proc-PipelinedProcBypassCtrl.v:730
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign squash_br_X = br_taken_X @plab2-proc-PipelinedProcBypassCtrl.v:734
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign intr_rq_X = (mod_X)===(intr) @plab2-proc-PipelinedProcBypassCtrl.v:753
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign stall_intr_X = and (intr_rq_X) (!(intr_ack)) @plab2-proc-PipelinedProcBypassCtrl.v:754
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign dmemreq_val_X = and (val_X) (not( = dmemreq_type_X nr)) @plab2-proc-PipelinedProcBypassCtrl.v:760
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign dmemreq_val = and (dmemreq_val_X) (!(stall_XM)) @plab2-proc-PipelinedProcBypassCtrl.v:761
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign debug_val_X = and (val_X) ((mod_X)===(debug)) @plab2-proc-PipelinedProcBypassCtrl.v:763
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign debug_val = and (debug_val_X) (!(stall_XM)) @plab2-proc-PipelinedProcBypassCtrl.v:764
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign stall_dmem_X = and (dmemreq_val_X) (!(dmemreq_rdy)) @plab2-proc-PipelinedProcBypassCtrl.v:766
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign mul_resp_rdy_X = and (and (val_X) (not( = mul_req_type_X mul_n))) (!(stall_DX)) @plab2-proc-PipelinedProcBypassCtrl.v:785
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign stall_mul_resp_X = and (and (val_X) (not( = mul_req_type_X mul_n))) (!(mul_resp_val_X)) @plab2-proc-PipelinedProcBypassCtrl.v:789
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain))  (Domain def_domain))))    ; assign stall_X = or (or (stall_dmem_X) (stall_mul_resp_X)) (stall_intr_X) @plab2-proc-PipelinedProcBypassCtrl.v:795
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign squash_X = squash_br_X @plab2-proc-PipelinedProcBypassCtrl.v:796
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_reg_en in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; assign dmemresp_rdy = 1 @plab2-proc-PipelinedProcBypassCtrl.v:861
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign dmemreq_val_M = and (val_M) (not( = dmemreq_type_M nr)) @plab2-proc-PipelinedProcBypassCtrl.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign stall_dmem_M = and (dmemreq_val_M) (!(dmemresp_val)) @plab2-proc-PipelinedProcBypassCtrl.v:864
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign intr_rq_M = and (val_M) (= mod_M intr) @plab2-proc-PipelinedProcBypassCtrl.v:869
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign stall_intr_M = and (intr_rq_M) (!(intr_val)) @plab2-proc-PipelinedProcBypassCtrl.v:870
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign stall_M = or (stall_dmem_M) (stall_intr_M) @plab2-proc-PipelinedProcBypassCtrl.v:872
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; assign squash_M = 0 @plab2-proc-PipelinedProcBypassCtrl.v:873
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; assign next_stall_W = 0 @plab2-proc-PipelinedProcBypassCtrl.v:887
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; assign next_squash_W = 0 @plab2-proc-PipelinedProcBypassCtrl.v:888
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter prev_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_reg_en in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_val in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter curr_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_stall in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; Instantiate parameter next_squash in module vc_PipeCtrl @plab2-proc-PipelinedProcBypassCtrl.v:890
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain))  (Domain def_domain))))    ; assign to_mngr_val = and (and (val_W) (to_mngr_val_W)) (!(stall_MW)) @plab2-proc-PipelinedProcBypassCtrl.v:930
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain))  (Domain def_domain))))    ; assign stall_to_mngr_W = and (and (val_W) (to_mngr_val_W)) (!(to_mngr_rdy)) @plab2-proc-PipelinedProcBypassCtrl.v:934
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; assign stall_W = stall_to_mngr_W @plab2-proc-PipelinedProcBypassCtrl.v:938
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; assign squash_W = 0 @plab2-proc-PipelinedProcBypassCtrl.v:939
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; j_pc_sel_D = pm_j @plab2-proc-PipelinedProcBypassCtrl.v:479
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; j_pc_sel_D = pm_r @plab2-proc-PipelinedProcBypassCtrl.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; j_pc_sel_D = pm_p @plab2-proc-PipelinedProcBypassCtrl.v:481
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; j_pc_sel_D = pm_p @plab2-proc-PipelinedProcBypassCtrl.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; to_mngr_val_D = 0 @plab2-proc-PipelinedProcBypassCtrl.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; from_mngr_rdy_D = 0 @plab2-proc-PipelinedProcBypassCtrl.v:501
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; stats_en_wen_D = 0 @plab2-proc-PipelinedProcBypassCtrl.v:502
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; mfc_sel_D = 0 @plab2-proc-PipelinedProcBypassCtrl.v:503
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; to_mngr_val_D = 1 @plab2-proc-PipelinedProcBypassCtrl.v:505
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; stats_en_wen_D = 1 @plab2-proc-PipelinedProcBypassCtrl.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; from_mngr_rdy_D = 1 @plab2-proc-PipelinedProcBypassCtrl.v:509
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; mfc_sel_D = 1 @plab2-proc-PipelinedProcBypassCtrl.v:511
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; mfc_sel_D = 2 @plab2-proc-PipelinedProcBypassCtrl.v:513
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain))  (Domain def_domain))))    ; op0_byp_sel_D = byp_x @plab2-proc-PipelinedProcBypassCtrl.v:546
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain))  (Domain def_domain))))    ; op0_byp_sel_D = byp_m @plab2-proc-PipelinedProcBypassCtrl.v:550
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain))  (Domain def_domain))))    ; op0_byp_sel_D = byp_w @plab2-proc-PipelinedProcBypassCtrl.v:554
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain))  (Domain def_domain))))    ; op0_byp_sel_D = byp_r @plab2-proc-PipelinedProcBypassCtrl.v:556
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain))  (Domain def_domain))))    ; op1_byp_sel_D = byp_x @plab2-proc-PipelinedProcBypassCtrl.v:561
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain))  (Domain def_domain))))    ; op1_byp_sel_D = byp_m @plab2-proc-PipelinedProcBypassCtrl.v:565
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain))  (Domain def_domain))))    ; op1_byp_sel_D = byp_w @plab2-proc-PipelinedProcBypassCtrl.v:569
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain)) (join (Domain def_domain) (Domain def_domain))) (Domain def_domain))  (Domain def_domain))))    ; op1_byp_sel_D = byp_r @plab2-proc-PipelinedProcBypassCtrl.v:571
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; out_domain = def_domain @plab2-proc-PipelinedProcBypassCtrl.v:626
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; cacheable = 1 @plab2-proc-PipelinedProcBypassCtrl.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; cacheable = 1 @plab2-proc-PipelinedProcBypassCtrl.v:635
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; cacheable = 0 @plab2-proc-PipelinedProcBypassCtrl.v:637
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; rf_wen_X <= 0 @plab2-proc-PipelinedProcBypassCtrl.v:689
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; stats_en_wen_X <= 0 @plab2-proc-PipelinedProcBypassCtrl.v:690
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; inst_X <= inst_D @plab2-proc-PipelinedProcBypassCtrl.v:692
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; alu_fn_X <= alu_fn_D @plab2-proc-PipelinedProcBypassCtrl.v:693
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; dmemreq_type_X <= dmemreq_type_D @plab2-proc-PipelinedProcBypassCtrl.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; mul_req_type_X <= mul_req_type_D @plab2-proc-PipelinedProcBypassCtrl.v:695
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; ex_result_sel_X <= ex_result_sel_D @plab2-proc-PipelinedProcBypassCtrl.v:696
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; wb_result_sel_X <= wb_result_sel_D @plab2-proc-PipelinedProcBypassCtrl.v:697
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; rf_wen_X <= rf_wen_D @plab2-proc-PipelinedProcBypassCtrl.v:698
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; rf_waddr_X <= rf_waddr_D @plab2-proc-PipelinedProcBypassCtrl.v:699
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; to_mngr_val_X <= to_mngr_val_D @plab2-proc-PipelinedProcBypassCtrl.v:700
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; stats_en_wen_X <= stats_en_wen_D @plab2-proc-PipelinedProcBypassCtrl.v:701
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; br_type_X <= br_type_D @plab2-proc-PipelinedProcBypassCtrl.v:702
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; mod_X <= mod_D @plab2-proc-PipelinedProcBypassCtrl.v:703
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; br_taken_X = !(br_cond_eq_X) @plab2-proc-PipelinedProcBypassCtrl.v:717
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; br_taken_X = br_cond_eq_X @plab2-proc-PipelinedProcBypassCtrl.v:718
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain))  (Domain def_domain))))    ; br_taken_X = or (!(br_cond_neg_X)) (br_cond_zero_X) @plab2-proc-PipelinedProcBypassCtrl.v:719
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain))  (Domain def_domain))))    ; br_taken_X = and (!(br_cond_neg_X)) (!(br_cond_zero_X)) @plab2-proc-PipelinedProcBypassCtrl.v:720
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain))  (Domain def_domain))))    ; br_taken_X = or (br_cond_neg_X) (br_cond_zero_X) @plab2-proc-PipelinedProcBypassCtrl.v:721
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain def_domain) (Domain def_domain)) (Domain def_domain))  (Domain def_domain))))    ; br_taken_X = and (br_cond_neg_X) (!(br_cond_zero_X)) @plab2-proc-PipelinedProcBypassCtrl.v:722
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; br_taken_X = 0 @plab2-proc-PipelinedProcBypassCtrl.v:723
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; br_taken_X = 0 @plab2-proc-PipelinedProcBypassCtrl.v:727
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; intr_rq <= 0 @plab2-proc-PipelinedProcBypassCtrl.v:746
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; intr_rq <= and (1) (!(intr_ack)) @plab2-proc-PipelinedProcBypassCtrl.v:748
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; intr_rq <= intr_rq @plab2-proc-PipelinedProcBypassCtrl.v:750
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; dmemreq_msg_type = 0 @plab2-proc-PipelinedProcBypassCtrl.v:770
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; dmemreq_msg_type = 1 @plab2-proc-PipelinedProcBypassCtrl.v:771
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; dmemreq_msg_type = 3 @plab2-proc-PipelinedProcBypassCtrl.v:772
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; dmemreq_msg_type = 4 @plab2-proc-PipelinedProcBypassCtrl.v:773
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; dmemreq_msg_type = 5 @plab2-proc-PipelinedProcBypassCtrl.v:774
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; dmemreq_msg_type = 6 @plab2-proc-PipelinedProcBypassCtrl.v:775
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; dmemreq_msg_type = 2 @plab2-proc-PipelinedProcBypassCtrl.v:776
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; dmemreq_msg_type = 'bxxxx @plab2-proc-PipelinedProcBypassCtrl.v:777
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; rf_wen_M <= 0 @plab2-proc-PipelinedProcBypassCtrl.v:843
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; stats_en_wen_M <= 0 @plab2-proc-PipelinedProcBypassCtrl.v:844
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; inst_M <= inst_X @plab2-proc-PipelinedProcBypassCtrl.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; dmemreq_type_M <= dmemreq_type_X @plab2-proc-PipelinedProcBypassCtrl.v:847
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; wb_result_sel_M <= wb_result_sel_X @plab2-proc-PipelinedProcBypassCtrl.v:848
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; rf_wen_M <= rf_wen_X @plab2-proc-PipelinedProcBypassCtrl.v:849
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; rf_waddr_M <= rf_waddr_X @plab2-proc-PipelinedProcBypassCtrl.v:850
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; stats_en_wen_M <= stats_en_wen_X @plab2-proc-PipelinedProcBypassCtrl.v:851
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; to_mngr_val_M <= to_mngr_val_X @plab2-proc-PipelinedProcBypassCtrl.v:852
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; mod_M <= mod_X @plab2-proc-PipelinedProcBypassCtrl.v:853
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; rf_wen_W <= 0 @plab2-proc-PipelinedProcBypassCtrl.v:919
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain def_domain))))    ; stats_en_wen_W <= 0 @plab2-proc-PipelinedProcBypassCtrl.v:920
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; inst_W <= inst_M @plab2-proc-PipelinedProcBypassCtrl.v:922
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; rf_wen_W <= rf_wen_M @plab2-proc-PipelinedProcBypassCtrl.v:923
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; rf_waddr_W <= rf_waddr_M @plab2-proc-PipelinedProcBypassCtrl.v:924
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; stats_en_wen_W <= stats_en_wen_M @plab2-proc-PipelinedProcBypassCtrl.v:925
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain def_domain)  (Domain def_domain))))    ; to_mngr_val_W <= to_mngr_val_M @plab2-proc-PipelinedProcBypassCtrl.v:926
(check-sat)
(pop)

