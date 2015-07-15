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
(declare-fun in_domain_p0 () Int)
(assert (<= 0  in_domain_p0))
(assert (<= in_domain_p0 1))
(declare-fun in_domain_p1 () Int)
(assert (<= 0  in_domain_p1))
(assert (<= in_domain_p1 1))
(declare-fun out0_domain_p0 () Int)
(assert (<= 0  out0_domain_p0))
(assert (<= out0_domain_p0 1))
(declare-fun out0_domain_p1 () Int)
(assert (<= 0  out0_domain_p1))
(assert (<= out0_domain_p1 1))
(declare-fun out1_domain_p0 () Int)
(assert (<= 0  out1_domain_p0))
(assert (<= out1_domain_p0 1))
(declare-fun out1_domain_p1 () Int)
(assert (<= 0  out1_domain_p1))
(assert (<= out1_domain_p1 1))
(declare-fun out2_domain_p0 () Int)
(assert (<= 0  out2_domain_p0))
(assert (<= out2_domain_p0 1))
(declare-fun out2_domain_p1 () Int)
(assert (<= 0  out2_domain_p1))
(assert (<= out2_domain_p1 1))

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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in0_val_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in0_rdy_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in0_msg_control_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in0_msg_data_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in0_val_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in0_rdy_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in0_msg_control_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in0_msg_data_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq (Control in_domain_p0)  (Domain in_domain_p0))))    ; Instantiate parameter in1_val in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in_domain_p0)  (Control in_domain_p0))))    ; Instantiate parameter in1_rdy in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq (Control in_domain_p0)  (Domain in_domain_p0))))    ; Instantiate parameter in1_msg_control in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in_domain_p0)  (Domain in_domain_p0))))    ; Instantiate parameter in1_msg_data in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in2_val_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in2_rdy_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in2_msg_control_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in2_msg_data_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in2_val_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in2_rdy_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in2_msg_control_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in2_msg_data_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out0_domain () Int)
(assert (<= 0  out0_domain))
(assert (<= out0_domain 1))
(assert  (not(leq (Domain out0_domain)  (Control out0_domain))))    ; Instantiate parameter out0_val in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out0_domain () Int)
(assert (<= 0  out0_domain))
(assert (<= out0_domain 1))
(assert  (not(leq (Control out0_domain)  (Domain out0_domain))))    ; Instantiate parameter out0_rdy in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out0_domain () Int)
(assert (<= 0  out0_domain))
(assert (<= out0_domain 1))
(assert  (not(leq (Domain out0_domain)  (Control out0_domain))))    ; Instantiate parameter out0_msg_control in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out0_domain () Int)
(assert (<= 0  out0_domain))
(assert (<= out0_domain 1))
(assert  (not(leq (Domain out0_domain)  (Domain out0_domain))))    ; Instantiate parameter out0_msg_data in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out0_domain in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out1_domain () Int)
(assert (<= 0  out1_domain))
(assert (<= out1_domain 1))
(assert  (not(leq (Domain out1_domain)  (Control out1_domain))))    ; Instantiate parameter out1_val in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out1_domain () Int)
(assert (<= 0  out1_domain))
(assert (<= out1_domain 1))
(assert  (not(leq (Control out1_domain)  (Domain out1_domain))))    ; Instantiate parameter out1_rdy in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out1_domain () Int)
(assert (<= 0  out1_domain))
(assert (<= out1_domain 1))
(assert  (not(leq (Domain out1_domain)  (Control out1_domain))))    ; Instantiate parameter out1_msg_control in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out1_domain () Int)
(assert (<= 0  out1_domain))
(assert (<= out1_domain 1))
(assert  (not(leq (Domain out1_domain)  (Domain out1_domain))))    ; Instantiate parameter out1_msg_data in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out1_domain in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out2_domain () Int)
(assert (<= 0  out2_domain))
(assert (<= out2_domain 1))
(assert  (not(leq (Domain out2_domain)  (Control out2_domain))))    ; Instantiate parameter out2_val in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out2_domain () Int)
(assert (<= 0  out2_domain))
(assert (<= out2_domain 1))
(assert  (not(leq (Control out2_domain)  (Domain out2_domain))))    ; Instantiate parameter out2_rdy in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out2_domain () Int)
(assert (<= 0  out2_domain))
(assert (<= out2_domain 1))
(assert  (not(leq (Domain out2_domain)  (Control out2_domain))))    ; Instantiate parameter out2_msg_control in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(declare-fun out2_domain () Int)
(assert (<= 0  out2_domain))
(assert (<= out2_domain 1))
(assert  (not(leq (Domain out2_domain)  (Domain out2_domain))))    ; Instantiate parameter out2_msg_data in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out2_domain in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain in_domain_p0))))    ; Instantiate parameter num_free_prev in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain in_domain_p0))))    ; Instantiate parameter num_free_next in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in0_val_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in0_rdy_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in0_msg_control_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in0_msg_data_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in0_val_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in0_rdy_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in0_msg_control_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in0_msg_data_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq (Control in_domain_p1)  (Domain in_domain_p1))))    ; Instantiate parameter in1_val in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in_domain_p1)  (Control in_domain_p1))))    ; Instantiate parameter in1_rdy in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq (Control in_domain_p1)  (Domain in_domain_p1))))    ; Instantiate parameter in1_msg_control in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in_domain_p1)  (Domain in_domain_p1))))    ; Instantiate parameter in1_msg_data in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in2_val_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in2_rdy_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in2_msg_control_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in2_msg_data_d1 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in2_val_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in2_rdy_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in2_msg_control_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in2_msg_data_d2 in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out0_domain () Int)
(assert (<= 0  out0_domain))
(assert (<= out0_domain 1))
(assert  (not(leq (Domain out0_domain)  (Control out0_domain))))    ; Instantiate parameter out0_val in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out0_domain () Int)
(assert (<= 0  out0_domain))
(assert (<= out0_domain 1))
(assert  (not(leq (Control out0_domain)  (Domain out0_domain))))    ; Instantiate parameter out0_rdy in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out0_domain () Int)
(assert (<= 0  out0_domain))
(assert (<= out0_domain 1))
(assert  (not(leq (Domain out0_domain)  (Control out0_domain))))    ; Instantiate parameter out0_msg_control in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out0_domain () Int)
(assert (<= 0  out0_domain))
(assert (<= out0_domain 1))
(assert  (not(leq (Domain out0_domain)  (Domain out0_domain))))    ; Instantiate parameter out0_msg_data in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out0_domain in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out1_domain () Int)
(assert (<= 0  out1_domain))
(assert (<= out1_domain 1))
(assert  (not(leq (Domain out1_domain)  (Control out1_domain))))    ; Instantiate parameter out1_val in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out1_domain () Int)
(assert (<= 0  out1_domain))
(assert (<= out1_domain 1))
(assert  (not(leq (Control out1_domain)  (Domain out1_domain))))    ; Instantiate parameter out1_rdy in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out1_domain () Int)
(assert (<= 0  out1_domain))
(assert (<= out1_domain 1))
(assert  (not(leq (Domain out1_domain)  (Control out1_domain))))    ; Instantiate parameter out1_msg_control in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out1_domain () Int)
(assert (<= 0  out1_domain))
(assert (<= out1_domain 1))
(assert  (not(leq (Domain out1_domain)  (Domain out1_domain))))    ; Instantiate parameter out1_msg_data in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out1_domain in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out2_domain () Int)
(assert (<= 0  out2_domain))
(assert (<= out2_domain 1))
(assert  (not(leq (Domain out2_domain)  (Control out2_domain))))    ; Instantiate parameter out2_val in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out2_domain () Int)
(assert (<= 0  out2_domain))
(assert (<= out2_domain 1))
(assert  (not(leq (Control out2_domain)  (Domain out2_domain))))    ; Instantiate parameter out2_rdy in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out2_domain () Int)
(assert (<= 0  out2_domain))
(assert (<= out2_domain 1))
(assert  (not(leq (Domain out2_domain)  (Control out2_domain))))    ; Instantiate parameter out2_msg_control in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(declare-fun out2_domain () Int)
(assert (<= 0  out2_domain))
(assert (<= out2_domain 1))
(assert  (not(leq (Domain out2_domain)  (Domain out2_domain))))    ; Instantiate parameter out2_msg_data in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out2_domain in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain in_domain_p1))))    ; Instantiate parameter num_free_prev in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain in_domain_p1))))    ; Instantiate parameter num_free_next in module plab4_net_RouterAlt_Sep @plab4-net-RingNetAlt-sep.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out2_domain_p1)  (Control out2_domain_p1))))    ; Instantiate parameter out_val in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_val_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_val_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_rdy_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_rdy_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out2_domain_p1)  (Control out2_domain_p1))))    ; Instantiate parameter out_rdy in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out2_domain_p1)  (Control out2_domain_p1))))    ; Instantiate parameter out_msg_control in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_msg_control_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_msg_control_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain out2_domain_p1)  (Domain out2_domain_p1))))    ; Instantiate parameter out_msg_data in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_msg_data_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_msg_data_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out0_domain_p1)  (Control out0_domain_p1))))    ; Instantiate parameter out_val in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_val_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_val_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_rdy_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_rdy_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out0_domain_p1)  (Control out0_domain_p1))))    ; Instantiate parameter out_rdy in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out0_domain_p1)  (Control out0_domain_p1))))    ; Instantiate parameter out_msg_control in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_msg_control_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_msg_control_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain out0_domain_p1)  (Domain out0_domain_p1))))    ; Instantiate parameter out_msg_data in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_msg_data_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_msg_data_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out2_domain_p0)  (Control out2_domain_p0))))    ; Instantiate parameter out_val in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_val_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_val_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_rdy_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_rdy_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out2_domain_p0)  (Control out2_domain_p0))))    ; Instantiate parameter out_rdy in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out2_domain_p0)  (Control out2_domain_p0))))    ; Instantiate parameter out_msg_control in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_msg_control_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_msg_control_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain out2_domain_p0)  (Domain out2_domain_p0))))    ; Instantiate parameter out_msg_data in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_msg_data_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_msg_data_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out0_domain_p0)  (Control out0_domain_p0))))    ; Instantiate parameter out_val in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_val_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_val_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_rdy_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_rdy_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out0_domain_p0)  (Control out0_domain_p0))))    ; Instantiate parameter out_rdy in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq (Control out0_domain_p0)  (Control out0_domain_p0))))    ; Instantiate parameter out_msg_control in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_msg_control_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_msg_control_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain out0_domain_p0)  (Domain out0_domain_p0))))    ; Instantiate parameter out_msg_data in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_msg_data_d1 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_msg_data_d2 in module plab4_net_demux @plab4-net-RingNetAlt-sep.v:378
(check-sat)
(pop)

