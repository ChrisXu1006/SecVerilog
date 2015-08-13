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
(declare-fun in0_reqs_domain () Int)
(assert (<= 0  in0_reqs_domain))
(assert (<= in0_reqs_domain 1))
(declare-fun in2_reqs_domain () Int)
(assert (<= 0  in2_reqs_domain))
(assert (<= in2_reqs_domain 1))
(declare-fun out0_domain () Int)
(assert (<= 0  out0_domain))
(assert (<= out0_domain 1))
(declare-fun out1_domain () Int)
(assert (<= 0  out1_domain))
(assert (<= out1_domain 1))
(declare-fun out2_domain () Int)
(assert (<= 0  out2_domain))
(assert (<= out2_domain 1))

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
(assert  (not(leq D1  D1)))    ; assign in0_rdy_d1 = and (in0_rdy_control_d1) (in0_rdy_data_d1) @plab4-net-RouterAlt-Sep.v:93
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; assign in0_rdy_d2 = and (in0_rdy_control_d2) (in0_rdy_data_d2) @plab4-net-RouterAlt-Sep.v:94
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign in1_rdy = and (in1_rdy_control) (in1_rdy_data) @plab4-net-RouterAlt-Sep.v:95
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; assign in2_rdy_d1 = and (in2_rdy_control_d1) (in2_rdy_data_d1) @plab4-net-RouterAlt-Sep.v:96
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; assign in2_rdy_d2 = and (in2_rdy_control_d2) (in2_rdy_data_d2) @plab4-net-RouterAlt-Sep.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab4-net-RouterAlt-Sep.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab4-net-RouterAlt-Sep.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter enq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter enq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter enq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter deq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter deq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter num_free_entries in module vc_Queue @plab4-net-RouterAlt-Sep.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab4-net-RouterAlt-Sep.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab4-net-RouterAlt-Sep.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter enq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter enq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter enq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter deq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter deq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter num_free_entries in module vc_Queue @plab4-net-RouterAlt-Sep.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter in0 in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter in1 in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in0_domain in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in1_domain in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in0_reqs_domain)  (Domain in0_reqs_domain))))    ; Instantiate parameter out in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab4-net-RouterAlt-Sep.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab4-net-RouterAlt-Sep.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter enq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter enq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter enq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter deq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter deq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter num_free_entries in module vc_Queue @plab4-net-RouterAlt-Sep.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab4-net-RouterAlt-Sep.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab4-net-RouterAlt-Sep.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter enq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter enq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter enq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter deq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter deq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter num_free_entries in module vc_Queue @plab4-net-RouterAlt-Sep.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter in0 in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter in1 in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in0_domain in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in1_domain in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in0_reqs_domain)  (Domain in0_reqs_domain))))    ; Instantiate parameter out in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab4-net-RouterAlt-Sep.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab4-net-RouterAlt-Sep.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter enq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter enq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter enq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter deq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter deq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab4-net-RouterAlt-Sep.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab4-net-RouterAlt-Sep.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter enq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter enq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter enq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter deq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter deq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab4-net-RouterAlt-Sep.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab4-net-RouterAlt-Sep.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter enq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter enq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter enq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter deq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter deq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter num_free_entries in module vc_Queue @plab4-net-RouterAlt-Sep.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab4-net-RouterAlt-Sep.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab4-net-RouterAlt-Sep.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter enq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter enq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter enq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter deq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter deq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter num_free_entries in module vc_Queue @plab4-net-RouterAlt-Sep.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter in0 in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:390
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter in1 in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:390
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in0_domain in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:390
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in1_domain in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:390
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:390
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in2_reqs_domain)  (Domain in2_reqs_domain))))    ; Instantiate parameter out in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:390
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab4-net-RouterAlt-Sep.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab4-net-RouterAlt-Sep.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter enq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter enq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter enq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter deq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter deq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter num_free_entries in module vc_Queue @plab4-net-RouterAlt-Sep.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab4-net-RouterAlt-Sep.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab4-net-RouterAlt-Sep.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter enq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter enq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter enq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab4-net-RouterAlt-Sep.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter deq_val in module vc_Queue @plab4-net-RouterAlt-Sep.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab4-net-RouterAlt-Sep.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter deq_msg in module vc_Queue @plab4-net-RouterAlt-Sep.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter num_free_entries in module vc_Queue @plab4-net-RouterAlt-Sep.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter in0 in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:458
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter in1 in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:458
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in0_domain in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:458
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in1_domain in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:458
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:458
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in2_reqs_domain)  (Domain in2_reqs_domain))))    ; Instantiate parameter out in module vc_Mux2_dd @plab4-net-RouterAlt-Sep.v:458
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in0_reqs_domain)  (Domain in0_reqs_domain))))    ; Instantiate parameter in0 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in2_reqs_domain)  (Domain in2_reqs_domain))))    ; Instantiate parameter in2 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in0_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in1_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in2_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel0 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel1 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel2 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain out0_domain)  (Domain out0_domain))))    ; Instantiate parameter out0 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain out1_domain)  (Domain out1_domain))))    ; Instantiate parameter out1 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain out2_domain)  (Domain out2_domain))))    ; Instantiate parameter out2 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out0_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out1_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out2_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in0_reqs_domain)  (Domain in0_reqs_domain))))    ; Instantiate parameter in0 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in2_reqs_domain)  (Domain in2_reqs_domain))))    ; Instantiate parameter in2 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in0_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in1_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in2_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel0 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel1 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel2 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain out0_domain)  (Domain out0_domain))))    ; Instantiate parameter out0 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain out1_domain)  (Domain out1_domain))))    ; Instantiate parameter out1 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain out2_domain)  (Domain out2_domain))))    ; Instantiate parameter out2 in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out0_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out1_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out2_domain in module vc_Crossbar3 @plab4-net-RouterAlt-Sep.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain in2_reqs_domain) (Domain domain)) (Domain in0_reqs_domain))  (join (join (Domain in2_reqs_domain) (Domain domain)) (Domain in0_reqs_domain)))))    ; assign {out0_reqs_p2, out0_reqs_p1, out0_reqs_p0} = {in2_reqs_p0, in1_reqs_p0, in0_reqs_p0} @plab4-net-RouterAlt-Sep.v:607
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain in2_reqs_domain) (Domain domain)) (Domain in0_reqs_domain))  (join (join (Domain in2_reqs_domain) (Domain domain)) (Domain in0_reqs_domain)))))    ; assign {out1_reqs_p2, out1_reqs_p1, out1_reqs_p0} = {in2_reqs_p1, in1_reqs_p1, in0_reqs_p1} @plab4-net-RouterAlt-Sep.v:609
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain in2_reqs_domain) (Domain domain)) (Domain in0_reqs_domain))  (join (join (Domain in2_reqs_domain) (Domain domain)) (Domain in0_reqs_domain)))))    ; assign {out2_reqs_p2, out2_reqs_p1, out2_reqs_p0} = {in2_reqs_p2, in1_reqs_p2, in0_reqs_p2} @plab4-net-RouterAlt-Sep.v:611
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in0_reqs_domain)  (Domain in0_reqs_domain))))    ; assign {in0_grants_p2, in0_grants_p1, in0_grants_p0} = {out2_grants_p0, out1_grants_p0, out0_grants_p0} @plab4-net-RouterAlt-Sep.v:614
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign {in1_grants_p2, in1_grants_p1, in1_grants_p0} = {out2_grants_p1, out1_grants_p1, out0_grants_p1} @plab4-net-RouterAlt-Sep.v:616
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in2_reqs_domain)  (Domain in2_reqs_domain))))    ; assign {in2_grants_p2, in2_grants_p1, in2_grants_p0} = {out2_grants_p2, out1_grants_p2, out0_grants_p2} @plab4-net-RouterAlt-Sep.v:618
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; assign dest0_d1 = in0_deq_msg_control_d1[((((pc)-(1))+(o))+(s))+(s):((((pc)-(1))+(o))+(s))+(1)] @plab4-net-RouterAlt-Sep.v:621
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; assign dest0_d2 = in0_deq_msg_control_d2[((((pc)-(1))+(o))+(s))+(s):((((pc)-(1))+(o))+(s))+(1)] @plab4-net-RouterAlt-Sep.v:622
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dest1 = in1_deq_msg_control[((((pc)-(1))+(o))+(s))+(s):((((pc)-(1))+(o))+(s))+(1)] @plab4-net-RouterAlt-Sep.v:623
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; assign dest2_d1 = in2_deq_msg_control_d1[((((pc)-(1))+(o))+(s))+(s):((((pc)-(1))+(o))+(s))+(1)] @plab4-net-RouterAlt-Sep.v:624
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; assign dest2_d2 = in2_deq_msg_control_d2[((((pc)-(1))+(o))+(s))+(s):((((pc)-(1))+(o))+(s))+(1)] @plab4-net-RouterAlt-Sep.v:625
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter dest_d1 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter dest_d2 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_val_d1 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_val_d2 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_rdy_d1 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_rdy_d2 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter reqs_p0 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter reqs_p1 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter reqs_p2 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter grants_p0 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter grants_p1 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter grants_p2 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:633
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign num_free0 = (num_free0_control_d1)+(num_free0_control_d2) @plab4-net-RouterAlt-Sep.v:654
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign num_free2 = (num_free2_control_d1)+(num_free2_control_d2) @plab4-net-RouterAlt-Sep.v:655
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter dest in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in_val in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in_rdy in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter num_free0 in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter num_free2 in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter num_free_chan0 in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter num_free_chan2 in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter reqs_p0 in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter reqs_p1 in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter reqs_p2 in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter grants_p0 in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter grants_p1 in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter grants_p2 in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_RouterAdaptiveInputTerminalCtrl_Sep @plab4-net-RouterAlt-Sep.v:664
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter dest_d1 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter dest_d2 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_val_d1 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_val_d2 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter in_rdy_d1 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter in_rdy_d2 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter reqs_p0 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter reqs_p1 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter reqs_p2 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter grants_p0 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter grants_p1 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter grants_p2 in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_RouterInputCtrlArb_Sep @plab4-net-RouterAlt-Sep.v:694
(check-sat)
(pop)

