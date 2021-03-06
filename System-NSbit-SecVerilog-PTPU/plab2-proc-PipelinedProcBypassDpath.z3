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

; function that maps 0 to D1; 1 to D2; 2 to LOW; 3 to HIGH
(declare-fun Control (Int) Label)
(assert (= (Control 0) D1))
(assert (= (Control 1) D2))
(assert (= (Control 2) LOW))
(assert (= (Control 3) HIGH))

; function for data signals
(declare-fun Data (Int) Label)
(assert (= (Data 0) D1))
(assert (= (Data 1) D2))
(assert (= (Data 2) LOW))
(assert (= (Data 3) HIGH))

; function for control signals
(declare-fun Ctrl (Int) Label)
(assert (= (Ctrl 0) D1))
(assert (= (Ctrl 1) D2))
(assert (= (Ctrl 2) LOW))
(assert (= (Ctrl 3) HIGH))

; function for NS signals
(declare-fun Ns (Int) Label)
(assert (= (Ns 0) LOW))
(assert (= (Ns 1) LOW))
(assert (= (Ns 2) LOW))
(assert (= (Ns 3) HIGH))

; function for address signals
(declare-fun Addr (Int) Label)
(assert (= (Addr 0) LOW))
(assert (= (Addr 1) LOW))
(assert (= (Addr 2) LOW))
(assert (= (Addr 3) HIGH))

; assertions to be verified

(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:98
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:98
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:98
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:98
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:98
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:98
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Incrementer @plab2-proc-PipelinedProcBypassDpath.v:108
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_Incrementer @plab2-proc-PipelinedProcBypassDpath.v:108
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Incrementer @plab2-proc-PipelinedProcBypassDpath.v:108
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign imemreq_msg_addr = pc_next_F @plab2-proc-PipelinedProcBypassDpath.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassDpath.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter inst in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassDpath.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter opcode in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassDpath.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter rs in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassDpath.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter rt in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassDpath.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter rd in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassDpath.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter shamt in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassDpath.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter func in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassDpath.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter imm in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassDpath.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter target in module pisa_InstUnpack @plab2-proc-PipelinedProcBypassDpath.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign rf_raddr0_D = inst_rs_D @plab2-proc-PipelinedProcBypassDpath.v:192
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign rf_raddr1_D = inst_rt_D @plab2-proc-PipelinedProcBypassDpath.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab2_proc_Regfile @plab2-proc-PipelinedProcBypassDpath.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab2_proc_Regfile @plab2-proc-PipelinedProcBypassDpath.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_addr0 in module plab2_proc_Regfile @plab2-proc-PipelinedProcBypassDpath.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_data0 in module plab2_proc_Regfile @plab2-proc-PipelinedProcBypassDpath.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_addr1 in module plab2_proc_Regfile @plab2-proc-PipelinedProcBypassDpath.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_data1 in module plab2_proc_Regfile @plab2-proc-PipelinedProcBypassDpath.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_en in module plab2_proc_Regfile @plab2-proc-PipelinedProcBypassDpath.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_addr in module plab2_proc_Regfile @plab2-proc-PipelinedProcBypassDpath.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_data in module plab2_proc_Regfile @plab2-proc-PipelinedProcBypassDpath.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_ZeroExtender @plab2-proc-PipelinedProcBypassDpath.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_ZeroExtender @plab2-proc-PipelinedProcBypassDpath.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_ZeroExtender @plab2-proc-PipelinedProcBypassDpath.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:237
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:237
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:237
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:237
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:237
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:237
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign jr_target_D = op0_byp_out_D @plab2-proc-PipelinedProcBypassDpath.v:247
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_SignExtender @plab2-proc-PipelinedProcBypassDpath.v:249
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_SignExtender @plab2-proc-PipelinedProcBypassDpath.v:249
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_SignExtender @plab2-proc-PipelinedProcBypassDpath.v:249
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_ZeroExtender @plab2-proc-PipelinedProcBypassDpath.v:256
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_ZeroExtender @plab2-proc-PipelinedProcBypassDpath.v:256
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_ZeroExtender @plab2-proc-PipelinedProcBypassDpath.v:256
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:268
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:268
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:268
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:268
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:268
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:268
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux4 @plab2-proc-PipelinedProcBypassDpath.v:268
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux5 @plab2-proc-PipelinedProcBypassDpath.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux5 @plab2-proc-PipelinedProcBypassDpath.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux5 @plab2-proc-PipelinedProcBypassDpath.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux5 @plab2-proc-PipelinedProcBypassDpath.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux5 @plab2-proc-PipelinedProcBypassDpath.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in4 in module vc_Mux5 @plab2-proc-PipelinedProcBypassDpath.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux5 @plab2-proc-PipelinedProcBypassDpath.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux5 @plab2-proc-PipelinedProcBypassDpath.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux3 @plab2-proc-PipelinedProcBypassDpath.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab2_proc_BrTarget @plab2-proc-PipelinedProcBypassDpath.v:305
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter pc_plus4 in module plab2_proc_BrTarget @plab2-proc-PipelinedProcBypassDpath.v:305
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter imm_sext in module plab2_proc_BrTarget @plab2-proc-PipelinedProcBypassDpath.v:305
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter br_target in module plab2_proc_BrTarget @plab2-proc-PipelinedProcBypassDpath.v:305
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab2_proc_JTarget @plab2-proc-PipelinedProcBypassDpath.v:313
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter pc_plus4 in module plab2_proc_JTarget @plab2-proc-PipelinedProcBypassDpath.v:313
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter imm_target in module plab2_proc_JTarget @plab2-proc-PipelinedProcBypassDpath.v:313
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter j_target in module plab2_proc_JTarget @plab2-proc-PipelinedProcBypassDpath.v:313
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dmem_write_data_D = op1_byp_out_D @plab2-proc-PipelinedProcBypassDpath.v:323
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcBypassDpath.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcBypassDpath.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcBypassDpath.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in_val in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcBypassDpath.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in_rdy in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcBypassDpath.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in_msg in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcBypassDpath.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out_val in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcBypassDpath.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out_rdy in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcBypassDpath.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out_msg in module plab1_imul_IntMulVarLat @plab2-proc-PipelinedProcBypassDpath.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab1_imul_MulDivReqMsgPack @plab2-proc-PipelinedProcBypassDpath.v:346
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter func in module plab1_imul_MulDivReqMsgPack @plab2-proc-PipelinedProcBypassDpath.v:346
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter a in module plab1_imul_MulDivReqMsgPack @plab2-proc-PipelinedProcBypassDpath.v:346
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter b in module plab1_imul_MulDivReqMsgPack @plab2-proc-PipelinedProcBypassDpath.v:346
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter msg in module plab1_imul_MulDivReqMsgPack @plab2-proc-PipelinedProcBypassDpath.v:346
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:374
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:374
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:374
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:374
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:374
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:374
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:385
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:385
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:385
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:385
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:385
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:385
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EqComparator @plab2-proc-PipelinedProcBypassDpath.v:396
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_EqComparator @plab2-proc-PipelinedProcBypassDpath.v:396
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_EqComparator @plab2-proc-PipelinedProcBypassDpath.v:396
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_EqComparator @plab2-proc-PipelinedProcBypassDpath.v:396
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_ZeroComparator @plab2-proc-PipelinedProcBypassDpath.v:404
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_ZeroComparator @plab2-proc-PipelinedProcBypassDpath.v:404
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter out in module vc_ZeroComparator @plab2-proc-PipelinedProcBypassDpath.v:404
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EqComparator @plab2-proc-PipelinedProcBypassDpath.v:411
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_EqComparator @plab2-proc-PipelinedProcBypassDpath.v:411
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter in1 in module vc_EqComparator @plab2-proc-PipelinedProcBypassDpath.v:411
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_EqComparator @plab2-proc-PipelinedProcBypassDpath.v:411
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab2_proc_Alu @plab2-proc-PipelinedProcBypassDpath.v:422
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module plab2_proc_Alu @plab2-proc-PipelinedProcBypassDpath.v:422
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module plab2_proc_Alu @plab2-proc-PipelinedProcBypassDpath.v:422
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter fn in module plab2_proc_Alu @plab2-proc-PipelinedProcBypassDpath.v:422
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module plab2_proc_Alu @plab2-proc-PipelinedProcBypassDpath.v:422
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign byp_data_X = ex_result_X @plab2-proc-PipelinedProcBypassDpath.v:443
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:445
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:445
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:445
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:445
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:445
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:445
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dmemreq_msg_addr = alu_result_X @plab2-proc-PipelinedProcBypassDpath.v:455
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dmemreq_msg_data = dmem_write_data_X @plab2-proc-PipelinedProcBypassDpath.v:456
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:464
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:464
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:464
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:464
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:464
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:464
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dmem_result_M = dmemresp_msg_data @plab2-proc-PipelinedProcBypassDpath.v:477
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign byp_data_M = wb_result_M @plab2-proc-PipelinedProcBypassDpath.v:489
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:497
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:497
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:497
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:497
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:497
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:497
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign to_mngr_data = wb_result_W @plab2-proc-PipelinedProcBypassDpath.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign byp_data_W = wb_result_W @plab2-proc-PipelinedProcBypassDpath.v:510
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign rf_wdata_W = wb_result_W @plab2-proc-PipelinedProcBypassDpath.v:512
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign stats_en = |(stats_en_W) @plab2-proc-PipelinedProcBypassDpath.v:520
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:522
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:522
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:522
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:522
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:522
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab2-proc-PipelinedProcBypassDpath.v:522
(check-sat)
(pop)

