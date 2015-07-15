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
(declare-fun req_domain () Int)
(assert (<= 0  req_domain))
(assert (<= req_domain 1))

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
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; assign val_PF = and (imemreq_val) (imemreq_rdy) @plab2-proc-PipelinedProcDynamic.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req_domain))))    ; Instantiate parameter type in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req_domain))))    ; Instantiate parameter opaque in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter addr in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req_domain))))    ; Instantiate parameter len in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req_domain))))    ; Instantiate parameter data in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter msg in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter type in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req_domain))))    ; Instantiate parameter opaque in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter addr in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req_domain))))    ; Instantiate parameter len in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter data in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter msg in module vc_MemReqMsgPack @plab2-proc-PipelinedProcDynamic.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; assign debug_msg = dmemreq_msg @plab2-proc-PipelinedProcDynamic.v:188
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter msg in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter opaque in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter type in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter len in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter data in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:204
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter msg in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:204
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter opaque in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:204
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter type in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:204
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter len in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:204
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter data in module vc_MemRespMsgUnpack @plab2-proc-PipelinedProcDynamic.v:204
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_DropUnit @plab2-proc-PipelinedProcDynamic.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_DropUnit @plab2-proc-PipelinedProcDynamic.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_DropUnit @plab2-proc-PipelinedProcDynamic.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter drop in module vc_DropUnit @plab2-proc-PipelinedProcDynamic.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter in_msg in module vc_DropUnit @plab2-proc-PipelinedProcDynamic.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter in_val in module vc_DropUnit @plab2-proc-PipelinedProcDynamic.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter in_rdy in module vc_DropUnit @plab2-proc-PipelinedProcDynamic.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter out_msg in module vc_DropUnit @plab2-proc-PipelinedProcDynamic.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter out_val in module vc_DropUnit @plab2-proc-PipelinedProcDynamic.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter out_rdy in module vc_DropUnit @plab2-proc-PipelinedProcDynamic.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter def_domain in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out_domain in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter intr_rq in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter intr_set in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter intr_ack in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter intr_val in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter cacheable in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter imemreq_val in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter imemreq_rdy in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter imemresp_val in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter imemresp_rdy in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter imemresp_drop in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter dmemreq_val in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter dmemreq_rdy in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter dmemreq_msg_type in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter dmemresp_val in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter dmemresp_rdy in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter debug_val in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter debug_rdy in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter from_mngr_val in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter from_mngr_rdy in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter to_mngr_val in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter to_mngr_rdy in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter mul_req_val_D in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter mul_req_rdy_D in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter mul_resp_val_X in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter mul_resp_rdy_X in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter pc_sel_F in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter reg_en_F in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter reg_en_D in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter reg_en_X in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter reg_en_M in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter reg_en_W in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter op0_sel_D in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter op1_sel_D in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter op0_byp_sel_D in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter op1_byp_sel_D in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter mfc_sel_D in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter ex_result_sel_X in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter wb_result_sel_M in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter alu_fn_X in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter rf_waddr_W in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter rf_wen_W in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter stats_en_wen_W in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter inst_D in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter br_cond_zero_X in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter br_cond_neg_X in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter br_cond_eq_X in module plab2_proc_PipelinedProcDynamicCtrl @plab2-proc-PipelinedProcDynamic.v:240
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab2-proc-PipelinedProcDynamic.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab2-proc-PipelinedProcDynamic.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab2-proc-PipelinedProcDynamic.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter enq_val in module vc_Queue @plab2-proc-PipelinedProcDynamic.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter enq_rdy in module vc_Queue @plab2-proc-PipelinedProcDynamic.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter enq_msg in module vc_Queue @plab2-proc-PipelinedProcDynamic.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab2-proc-PipelinedProcDynamic.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter deq_val in module vc_Queue @plab2-proc-PipelinedProcDynamic.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab2-proc-PipelinedProcDynamic.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter deq_msg in module vc_Queue @plab2-proc-PipelinedProcDynamic.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter imemreq_msg_addr in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter imemresp_msg_data in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter dmemreq_msg_addr in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter dmemreq_msg_data in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter dmemresp_msg_data in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter from_mngr_data in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter to_mngr_data in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter mul_req_val_D in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter mul_req_rdy_D in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter mul_resp_val_X in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter mul_resp_rdy_X in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter pc_sel_F in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter reg_en_F in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter reg_en_D in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter reg_en_X in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter reg_en_M in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter reg_en_W in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter op0_sel_D in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter op1_sel_D in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter op0_byp_sel_D in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter op1_byp_sel_D in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter mfc_sel_D in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter alu_fn_X in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter ex_result_sel_X in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter wb_result_sel_M in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter rf_waddr_W in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter rf_wen_W in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter stats_en_wen_W in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter inst_D in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter br_cond_zero_X in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter br_cond_neg_X in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter br_cond_eq_X in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter stats_en in module plab2_proc_PipelinedProcDynamicDpath @plab2-proc-PipelinedProcDynamic.v:349
(check-sat)
(pop)

