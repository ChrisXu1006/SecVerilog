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
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(declare-fun resp_in_domain_p0 () Int)
(assert (<= 0  resp_in_domain_p0))
(assert (<= resp_in_domain_p0 1))
(declare-fun resp_in_domain_p1 () Int)
(assert (<= 0  resp_in_domain_p1))
(assert (<= resp_in_domain_p1 1))
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))

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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_MemReqMsgToNetMsg @plab5-mcore-MemNet-sep.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab5_mcore_MemReqMsgToNetMsg @plab5-mcore-MemNet-sep.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter mem_msg in module plab5_mcore_MemReqMsgToNetMsg @plab5-mcore-MemNet-sep.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter net_msg_control in module plab5_mcore_MemReqMsgToNetMsg @plab5-mcore-MemNet-sep.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter net_msg_data in module plab5_mcore_MemReqMsgToNetMsg @plab5-mcore-MemNet-sep.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_MemReqMsgToNetMsg @plab5-mcore-MemNet-sep.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab5_mcore_MemReqMsgToNetMsg @plab5-mcore-MemNet-sep.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter mem_msg in module plab5_mcore_MemReqMsgToNetMsg @plab5-mcore-MemNet-sep.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter net_msg_control in module plab5_mcore_MemReqMsgToNetMsg @plab5-mcore-MemNet-sep.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter net_msg_data in module plab5_mcore_MemReqMsgToNetMsg @plab5-mcore-MemNet-sep.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Control req_out_domain_p0))))    ; Instantiate parameter domain in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq (Control req_out_domain_p0)  (Control req_out_domain_p0))))    ; Instantiate parameter msg in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq (Control req_out_domain_p0)  (Control req_out_domain_p0))))    ; Instantiate parameter payload in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq (Control req_out_domain_p0)  (Control req_out_domain_p0))))    ; assign {req_out_domain_p0_M, req_out_msg_control_p0} = req_out_msg_control_M_p0 @plab5-mcore-MemNet-sep.v:203
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Control req_out_domain_p1))))    ; Instantiate parameter domain in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:206
(check-sat)
(pop)


(push)
(assert  (not(leq (Control req_out_domain_p1)  (Control req_out_domain_p1))))    ; Instantiate parameter msg in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:206
(check-sat)
(pop)


(push)
(assert  (not(leq (Control req_out_domain_p1)  (Control req_out_domain_p1))))    ; Instantiate parameter payload in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:206
(check-sat)
(pop)


(push)
(assert  (not(leq (Control req_out_domain_p1)  (Control req_out_domain_p1))))    ; assign {req_out_domain_p1_M, req_out_msg_control_p1} = req_out_msg_control_M_p1 @plab5-mcore-MemNet-sep.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_out_domain_p0)  (Domain req_out_domain_p0))))    ; assign req_out_msg_data_p0 = req_net_out_msg_data_p0 @plab5-mcore-MemNet-sep.v:220
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_out_domain_p1)  (Domain req_out_domain_p1))))    ; assign req_out_msg_data_p1 = req_net_out_msg_data_p1 @plab5-mcore-MemNet-sep.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p0)  (Control resp_in_domain_p0))))    ; Instantiate parameter mem_msg_control in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain resp_in_domain_p0)  (Domain resp_in_domain_p0))))    ; Instantiate parameter mem_msg_data in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Control resp_in_domain_p0))))    ; Instantiate parameter domain in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p0)  (Control resp_in_domain_p0))))    ; Instantiate parameter net_msg_control in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain resp_in_domain_p0)  (Domain resp_in_domain_p0))))    ; Instantiate parameter net_msg_data in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p1)  (Control resp_in_domain_p1))))    ; Instantiate parameter mem_msg_control in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain resp_in_domain_p1)  (Domain resp_in_domain_p1))))    ; Instantiate parameter mem_msg_data in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Control resp_in_domain_p1))))    ; Instantiate parameter domain in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p1)  (Control resp_in_domain_p1))))    ; Instantiate parameter net_msg_control in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain resp_in_domain_p1)  (Domain resp_in_domain_p1))))    ; Instantiate parameter net_msg_data in module plab5_mcore_MemRespMsgToNetMsg @plab5-mcore-MemNet-sep.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Control resp_out_domain_p0))))    ; Instantiate parameter domain in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_out_domain_p0)  (Control resp_out_domain_p0))))    ; Instantiate parameter msg in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_out_domain_p0)  (Control resp_out_domain_p0))))    ; Instantiate parameter payload in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_out_domain_p0)  (Control resp_out_domain_p0))))    ; assign {resp_out_domain_p0_M, resp_out_msg_control_p0} = resp_out_msg_control_M_p0 @plab5-mcore-MemNet-sep.v:278
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; assign resp_out_msg_data_p0 = resp_net_out_msg_data_p0 @plab5-mcore-MemNet-sep.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Control resp_out_domain_p0) (Domain resp_out_domain_p0))  (Domain resp_out_domain_p0))))    ; assign resp_out_msg_p0 = {resp_out_msg_control_p0, resp_out_msg_data_p0} @plab5-mcore-MemNet-sep.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Control resp_out_domain_p1))))    ; Instantiate parameter domain in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:285
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_out_domain_p1)  (Control resp_out_domain_p1))))    ; Instantiate parameter msg in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:285
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_out_domain_p1)  (Control resp_out_domain_p1))))    ; Instantiate parameter payload in module vc_NetMsgUnpack @plab5-mcore-MemNet-sep.v:285
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_out_domain_p1)  (Control resp_out_domain_p1))))    ; assign {resp_out_domain_p1_M, resp_out_msg_control_p1} = resp_out_msg_control_M_p1 @plab5-mcore-MemNet-sep.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain resp_out_domain_p1)  (Domain resp_out_domain_p1))))    ; assign resp_out_msg_data_p1 = resp_net_out_msg_data_p1 @plab5-mcore-MemNet-sep.v:297
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Control resp_out_domain_p1) (Domain resp_out_domain_p1))  (Domain resp_out_domain_p1))))    ; assign resp_out_msg_p1 = {resp_out_msg_control_p1, resp_out_msg_data_p1} @plab5-mcore-MemNet-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; assign req_net_in_val_p0 = req_in_val_p0 @plab5-mcore-MemNet-sep.v:318
(check-sat)
(pop)


(push)
(assert  (not(leq (Control req_out_domain_p0)  (Control req_out_domain_p0))))    ; req_net_out_rdy_p0 = {0, req_out_rdy_p0[0]} @plab5-mcore-MemNet-sep.v:319
(check-sat)
(pop)


(push)
(assert  (not(leq (Control req_out_domain_p0)  (Control req_out_domain_p0))))    ; req_net_out_rdy_p0 = req_out_rdy_p0 @plab5-mcore-MemNet-sep.v:319
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p0)  (Control resp_in_domain_p0))))    ; resp_net_in_val_p0 = {0, resp_in_val_p0[0]} @plab5-mcore-MemNet-sep.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p0)  (Control resp_in_domain_p0))))    ; resp_net_in_val_p0 = resp_in_val_p0 @plab5-mcore-MemNet-sep.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_out_domain_p0)  (Control resp_out_domain_p0))))    ; assign resp_net_out_rdy_p0 = resp_out_rdy_p0 @plab5-mcore-MemNet-sep.v:323
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; assign req_net_in_val_p1 = req_in_val_p1 @plab5-mcore-MemNet-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Control req_out_domain_p1)  (Control req_out_domain_p1))))    ; req_net_out_rdy_p1 = {0, req_out_rdy_p1[0]} @plab5-mcore-MemNet-sep.v:326
(check-sat)
(pop)


(push)
(assert  (not(leq (Control req_out_domain_p1)  (Control req_out_domain_p1))))    ; req_net_out_rdy_p1 = req_out_rdy_p1 @plab5-mcore-MemNet-sep.v:326
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p1)  (Control resp_in_domain_p1))))    ; resp_net_in_val_p1 = {0, resp_in_val_p1[0]} @plab5-mcore-MemNet-sep.v:328
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p1)  (Control resp_in_domain_p1))))    ; resp_net_in_val_p1 = resp_in_val_p1 @plab5-mcore-MemNet-sep.v:328
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_out_domain_p1)  (Control resp_out_domain_p1))))    ; assign resp_net_out_rdy_p1 = resp_out_rdy_p1 @plab5-mcore-MemNet-sep.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter in_val_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter in_rdy_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in_domain_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter in_msg_control_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter in_msg_data_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p0 () Int)
(assert (<= 0  out1_domain_p0))
(assert (<= out1_domain_p0 1))
(assert  (not(leq (Control out1_domain_p0)  (Control out1_domain_p0))))    ; Instantiate parameter out_val_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p0 () Int)
(assert (<= 0  out1_domain_p0))
(assert (<= out1_domain_p0 1))
(assert  (not(leq (Control out1_domain_p0)  (Control out1_domain_p0))))    ; Instantiate parameter out_rdy_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p0 () Int)
(assert (<= 0  out1_domain_p0))
(assert (<= out1_domain_p0 1))
(assert  (not(leq (Control out1_domain_p0)  (Control out1_domain_p0))))    ; Instantiate parameter out_msg_control_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p0 () Int)
(assert (<= 0  out1_domain_p0))
(assert (<= out1_domain_p0 1))
(assert  (not(leq (Domain out1_domain_p0)  (Domain out1_domain_p0))))    ; Instantiate parameter out_msg_data_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out1_domain_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter in_val_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter in_rdy_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in_domain_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter in_msg_control_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter in_msg_data_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p1 () Int)
(assert (<= 0  out1_domain_p1))
(assert (<= out1_domain_p1 1))
(assert  (not(leq (Control out1_domain_p1)  (Control out1_domain_p1))))    ; Instantiate parameter out_val_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p1 () Int)
(assert (<= 0  out1_domain_p1))
(assert (<= out1_domain_p1 1))
(assert  (not(leq (Control out1_domain_p1)  (Control out1_domain_p1))))    ; Instantiate parameter out_rdy_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p1 () Int)
(assert (<= 0  out1_domain_p1))
(assert (<= out1_domain_p1 1))
(assert  (not(leq (Control out1_domain_p1)  (Control out1_domain_p1))))    ; Instantiate parameter out_msg_control_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p1 () Int)
(assert (<= 0  out1_domain_p1))
(assert (<= out1_domain_p1 1))
(assert  (not(leq (Domain out1_domain_p1)  (Domain out1_domain_p1))))    ; Instantiate parameter out_msg_data_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out1_domain_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p0)  (Control resp_in_domain_p0))))    ; Instantiate parameter in_val_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p0)  (Control resp_in_domain_p0))))    ; Instantiate parameter in_rdy_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in_domain_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p0)  (Control resp_in_domain_p0))))    ; Instantiate parameter in_msg_control_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain resp_in_domain_p0)  (Domain resp_in_domain_p0))))    ; Instantiate parameter in_msg_data_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p0 () Int)
(assert (<= 0  out1_domain_p0))
(assert (<= out1_domain_p0 1))
(assert  (not(leq (Control out1_domain_p0)  (Control out1_domain_p0))))    ; Instantiate parameter out_val_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p0 () Int)
(assert (<= 0  out1_domain_p0))
(assert (<= out1_domain_p0 1))
(assert  (not(leq (Control out1_domain_p0)  (Control out1_domain_p0))))    ; Instantiate parameter out_rdy_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p0 () Int)
(assert (<= 0  out1_domain_p0))
(assert (<= out1_domain_p0 1))
(assert  (not(leq (Control out1_domain_p0)  (Control out1_domain_p0))))    ; Instantiate parameter out_msg_control_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p0 () Int)
(assert (<= 0  out1_domain_p0))
(assert (<= out1_domain_p0 1))
(assert  (not(leq (Domain out1_domain_p0)  (Domain out1_domain_p0))))    ; Instantiate parameter out_msg_data_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out1_domain_p0 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p1)  (Control resp_in_domain_p1))))    ; Instantiate parameter in_val_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p1)  (Control resp_in_domain_p1))))    ; Instantiate parameter in_rdy_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in_domain_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq (Control resp_in_domain_p1)  (Control resp_in_domain_p1))))    ; Instantiate parameter in_msg_control_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain resp_in_domain_p1)  (Domain resp_in_domain_p1))))    ; Instantiate parameter in_msg_data_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p1 () Int)
(assert (<= 0  out1_domain_p1))
(assert (<= out1_domain_p1 1))
(assert  (not(leq (Control out1_domain_p1)  (Control out1_domain_p1))))    ; Instantiate parameter out_val_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p1 () Int)
(assert (<= 0  out1_domain_p1))
(assert (<= out1_domain_p1 1))
(assert  (not(leq (Control out1_domain_p1)  (Control out1_domain_p1))))    ; Instantiate parameter out_rdy_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p1 () Int)
(assert (<= 0  out1_domain_p1))
(assert (<= out1_domain_p1 1))
(assert  (not(leq (Control out1_domain_p1)  (Control out1_domain_p1))))    ; Instantiate parameter out_msg_control_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(declare-fun out1_domain_p1 () Int)
(assert (<= 0  out1_domain_p1))
(assert (<= out1_domain_p1 1))
(assert  (not(leq (Domain out1_domain_p1)  (Domain out1_domain_p1))))    ; Instantiate parameter out_msg_data_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out1_domain_p1 in module plab4_net_RingNetAlt_Sep @plab5-mcore-MemNet-sep.v:366
(check-sat)
(pop)

