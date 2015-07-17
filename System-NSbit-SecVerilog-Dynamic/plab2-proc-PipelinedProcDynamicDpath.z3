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
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))

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

(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Incrementer @plab2-proc-PipelinedProcDynamicDpath.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_Incrementer @plab2-proc-PipelinedProcDynamicDpath.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Incrementer @plab2-proc-PipelinedProcDynamicDpath.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign imemreq_msg_addr = pc_next_F @plab2-proc-PipelinedProcDynamicDpath.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module pisa_InstUnpack @plab2-proc-PipelinedProcDynamicDpath.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter inst in module pisa_InstUnpack @plab2-proc-PipelinedProcDynamicDpath.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter opcode in module pisa_InstUnpack @plab2-proc-PipelinedProcDynamicDpath.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter rs in module pisa_InstUnpack @plab2-proc-PipelinedProcDynamicDpath.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter rt in module pisa_InstUnpack @plab2-proc-PipelinedProcDynamicDpath.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter rd in module pisa_InstUnpack @plab2-proc-PipelinedProcDynamicDpath.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter shamt in module pisa_InstUnpack @plab2-proc-PipelinedProcDynamicDpath.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter func in module pisa_InstUnpack @plab2-proc-PipelinedProcDynamicDpath.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter imm in module pisa_InstUnpack @plab2-proc-PipelinedProcDynamicDpath.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter target in module pisa_InstUnpack @plab2-proc-PipelinedProcDynamicDpath.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign rf_raddr0_D = inst_rs_D @plab2-proc-PipelinedProcDynamicDpath.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign rf_raddr1_D = inst_rt_D @plab2-proc-PipelinedProcDynamicDpath.v:193
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab2_proc_Regfile @plab2-proc-PipelinedProcDynamicDpath.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab2_proc_Regfile @plab2-proc-PipelinedProcDynamicDpath.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab2_proc_Regfile @plab2-proc-PipelinedProcDynamicDpath.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_addr0 in module plab2_proc_Regfile @plab2-proc-PipelinedProcDynamicDpath.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_data0 in module plab2_proc_Regfile @plab2-proc-PipelinedProcDynamicDpath.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_addr1 in module plab2_proc_Regfile @plab2-proc-PipelinedProcDynamicDpath.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_data1 in module plab2_proc_Regfile @plab2-proc-PipelinedProcDynamicDpath.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_en in module plab2_proc_Regfile @plab2-proc-PipelinedProcDynamicDpath.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_addr in module plab2_proc_Regfile @plab2-proc-PipelinedProcDynamicDpath.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_data in module plab2_proc_Regfile @plab2-proc-PipelinedProcDynamicDpath.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_ZeroExtender @plab2-proc-PipelinedProcDynamicDpath.v:213
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_ZeroExtender @plab2-proc-PipelinedProcDynamicDpath.v:213
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_ZeroExtender @plab2-proc-PipelinedProcDynamicDpath.v:213
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:225
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:225
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:225
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:225
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:225
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:225
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:225
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign jr_target_D = op0_byp_out_D @plab2-proc-PipelinedProcDynamicDpath.v:246
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_SignExtender @plab2-proc-PipelinedProcDynamicDpath.v:248
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_SignExtender @plab2-proc-PipelinedProcDynamicDpath.v:248
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_SignExtender @plab2-proc-PipelinedProcDynamicDpath.v:248
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_ZeroExtender @plab2-proc-PipelinedProcDynamicDpath.v:255
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_ZeroExtender @plab2-proc-PipelinedProcDynamicDpath.v:255
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_ZeroExtender @plab2-proc-PipelinedProcDynamicDpath.v:255
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux4 @plab2-proc-PipelinedProcDynamicDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux5 @plab2-proc-PipelinedProcDynamicDpath.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux5 @plab2-proc-PipelinedProcDynamicDpath.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux5 @plab2-proc-PipelinedProcDynamicDpath.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux5 @plab2-proc-PipelinedProcDynamicDpath.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux5 @plab2-proc-PipelinedProcDynamicDpath.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in4 in module vc_Mux5 @plab2-proc-PipelinedProcDynamicDpath.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux5 @plab2-proc-PipelinedProcDynamicDpath.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux5 @plab2-proc-PipelinedProcDynamicDpath.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:292
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:292
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:292
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:292
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:292
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux3 @plab2-proc-PipelinedProcDynamicDpath.v:292
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab2_proc_BrTarget @plab2-proc-PipelinedProcDynamicDpath.v:304
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter pc_plus4 in module plab2_proc_BrTarget @plab2-proc-PipelinedProcDynamicDpath.v:304
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter imm_sext in module plab2_proc_BrTarget @plab2-proc-PipelinedProcDynamicDpath.v:304
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter br_target in module plab2_proc_BrTarget @plab2-proc-PipelinedProcDynamicDpath.v:304
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab2_proc_JTarget @plab2-proc-PipelinedProcDynamicDpath.v:312
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter pc_plus4 in module plab2_proc_JTarget @plab2-proc-PipelinedProcDynamicDpath.v:312
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter imm_target in module plab2_proc_JTarget @plab2-proc-PipelinedProcDynamicDpath.v:312
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter j_target in module plab2_proc_JTarget @plab2-proc-PipelinedProcDynamicDpath.v:312
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dmem_write_data_D = op1_byp_out_D @plab2-proc-PipelinedProcDynamicDpath.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcDynamicDpath.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcDynamicDpath.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcDynamicDpath.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in_val in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcDynamicDpath.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in_rdy in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcDynamicDpath.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in_msg in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcDynamicDpath.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out_val in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcDynamicDpath.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out_rdy in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcDynamicDpath.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out_msg in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcDynamicDpath.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab1_imul_MulDivReqMsgPack @plab2-proc-PipelinedProcDynamicDpath.v:345
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter func in module plab1_imul_MulDivReqMsgPack @plab2-proc-PipelinedProcDynamicDpath.v:345
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter a in module plab1_imul_MulDivReqMsgPack @plab2-proc-PipelinedProcDynamicDpath.v:345
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter b in module plab1_imul_MulDivReqMsgPack @plab2-proc-PipelinedProcDynamicDpath.v:345
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter msg in module plab1_imul_MulDivReqMsgPack @plab2-proc-PipelinedProcDynamicDpath.v:345
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:362
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:362
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:362
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:362
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:362
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:362
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:372
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:372
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:372
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:372
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:372
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:372
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:383
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:383
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:383
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:383
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:383
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:383
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EqComparator @plab2-proc-PipelinedProcDynamicDpath.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_EqComparator @plab2-proc-PipelinedProcDynamicDpath.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_EqComparator @plab2-proc-PipelinedProcDynamicDpath.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_EqComparator @plab2-proc-PipelinedProcDynamicDpath.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_ZeroComparator @plab2-proc-PipelinedProcDynamicDpath.v:402
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_ZeroComparator @plab2-proc-PipelinedProcDynamicDpath.v:402
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter out in module vc_ZeroComparator @plab2-proc-PipelinedProcDynamicDpath.v:402
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EqComparator @plab2-proc-PipelinedProcDynamicDpath.v:409
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_EqComparator @plab2-proc-PipelinedProcDynamicDpath.v:409
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter in1 in module vc_EqComparator @plab2-proc-PipelinedProcDynamicDpath.v:409
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_EqComparator @plab2-proc-PipelinedProcDynamicDpath.v:409
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab2_proc_Alu @plab2-proc-PipelinedProcDynamicDpath.v:420
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module plab2_proc_Alu @plab2-proc-PipelinedProcDynamicDpath.v:420
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module plab2_proc_Alu @plab2-proc-PipelinedProcDynamicDpath.v:420
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter fn in module plab2_proc_Alu @plab2-proc-PipelinedProcDynamicDpath.v:420
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module plab2_proc_Alu @plab2-proc-PipelinedProcDynamicDpath.v:420
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign byp_data_X = ex_result_X @plab2-proc-PipelinedProcDynamicDpath.v:441
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:443
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:443
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:443
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:443
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:443
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:443
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dmemreq_msg_addr = alu_result_X @plab2-proc-PipelinedProcDynamicDpath.v:453
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dmemreq_msg_data = dmem_write_data_X @plab2-proc-PipelinedProcDynamicDpath.v:454
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:462
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:462
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:462
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:462
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:462
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:462
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dmem_result_M = dmemresp_msg_data @plab2-proc-PipelinedProcDynamicDpath.v:475
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign byp_data_M = wb_result_M @plab2-proc-PipelinedProcDynamicDpath.v:487
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:495
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:495
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:495
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:495
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:495
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:495
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign to_mngr_data = wb_result_W @plab2-proc-PipelinedProcDynamicDpath.v:505
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign byp_data_W = wb_result_W @plab2-proc-PipelinedProcDynamicDpath.v:508
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign rf_wdata_W = wb_result_W @plab2-proc-PipelinedProcDynamicDpath.v:510
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign stats_en = |(stats_en_W) @plab2-proc-PipelinedProcDynamicDpath.v:518
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:520
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:520
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:520
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:520
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:520
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcDynamicDpath.v:520
(check-sat)
(pop)

