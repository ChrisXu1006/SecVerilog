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
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign grants = {grants_p2, grants_p1, grants_p0} @plab4-net-RouterInputCtrl-Arb-Sep.v:46
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign {reqs_p2, reqs_p1, reqs_p0} = reqs @plab4-net-RouterInputCtrl-Arb-Sep.v:47
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:65
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter dest in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:65
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter in_val in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:65
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter in_rdy in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:65
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter reqs in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:65
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter grants in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:65
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:83
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter dest in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:83
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter in_val in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:83
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter in_rdy in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:83
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter reqs in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:83
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter grants in module plab4_net_RouterInputCtrl @plab4-net-RouterInputCtrl-Arb-Sep.v:83
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; assign in_rdy_d1 = |((reqs_d1)&(grants_d1)) @plab4-net-RouterInputCtrl-Arb-Sep.v:152
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; assign in_rdy_d2 = |((reqs_d2)&(grants_d2)) @plab4-net-RouterInputCtrl-Arb-Sep.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (join D1 (join D1 D2))  (Domain domain))))    ; reqs = reqs_d1 @plab4-net-RouterInputCtrl-Arb-Sep.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (join D1 D2)  LOW)))    ; domain = 0 @plab4-net-RouterInputCtrl-Arb-Sep.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq (join D2 (join D1 D2))  (Domain domain))))    ; reqs = reqs_d2 @plab4-net-RouterInputCtrl-Arb-Sep.v:111
(check-sat)
(pop)


(push)
(assert  (not(leq (join D1 D2)  LOW)))    ; domain = 1 @plab4-net-RouterInputCtrl-Arb-Sep.v:112
(check-sat)
(pop)


(push)
(assert  (not(leq (join D1 D2)  LOW)))    ; i = ($random())%(2) @plab4-net-RouterInputCtrl-Arb-Sep.v:117
(check-sat)
(pop)


(push)
(assert  (not(leq (join D1 (join D1 D2))  (Domain domain))))    ; reqs = reqs_d1 @plab4-net-RouterInputCtrl-Arb-Sep.v:120
(check-sat)
(pop)


(push)
(assert  (not(leq (join D1 D2)  LOW)))    ; domain = 0 @plab4-net-RouterInputCtrl-Arb-Sep.v:121
(check-sat)
(pop)


(push)
(assert  (not(leq (join D2 (join D1 D2))  (Domain domain))))    ; reqs = reqs_d2 @plab4-net-RouterInputCtrl-Arb-Sep.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq (join D1 D2)  LOW)))    ; domain = 1 @plab4-net-RouterInputCtrl-Arb-Sep.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (join D1 D2)  (Domain domain))))    ; reqs = 0 @plab4-net-RouterInputCtrl-Arb-Sep.v:131
(check-sat)
(pop)


(push)
(assert (and (= domain 0)  (not(leq (Domain domain)  D1))))    ; grants_d1 = grants @plab4-net-RouterInputCtrl-Arb-Sep.v:140
(check-sat)
(pop)


(push)
(assert (and (= domain 0)  (not(leq LOW  D2))))    ; grants_d2 = 0 @plab4-net-RouterInputCtrl-Arb-Sep.v:141
(check-sat)
(pop)


(push)
(assert (and (= domain 1) (not(= domain 0))  (not(leq LOW  D1))))    ; grants_d1 = 0 @plab4-net-RouterInputCtrl-Arb-Sep.v:145
(check-sat)
(pop)


(push)
(assert (and (= domain 1) (not(= domain 0))  (not(leq (Domain domain)  D2))))    ; grants_d2 = grants @plab4-net-RouterInputCtrl-Arb-Sep.v:146
(check-sat)
(pop)

