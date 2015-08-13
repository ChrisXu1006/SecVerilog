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
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(declare-fun reqs_p0_domain () Int)
(assert (<= 0  reqs_p0_domain))
(assert (<= reqs_p0_domain 1))
(declare-fun reqs_p1_domain () Int)
(assert (<= 0  reqs_p1_domain))
(assert (<= reqs_p1_domain 1))
(declare-fun reqs_p2_domain () Int)
(assert (<= 0  reqs_p2_domain))
(assert (<= reqs_p2_domain 1))

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
(assert  (not(leq (join (join (join (Domain reqs_p2_domain) (Domain reqs_p1_domain)) (Domain reqs_p0_domain)) (Domain out_domain))  LOW)))    ; arb_reqs = {reqs_p2, reqs_p1, reqs_p0} @plab4-net-RouterOutputCtrl-Sep.v:41
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain out_domain)  LOW)))    ; arb_reqs = 0 @plab4-net-RouterOutputCtrl-Sep.v:41
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (join (join (Domain reqs_p2_domain) (Domain reqs_p1_domain)) (Domain reqs_p0_domain)))))    ; assign {grants_p2, grants_p1, grants_p0} = grants @plab4-net-RouterOutputCtrl-Sep.v:42
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_RRArb @plab4-net-RouterOutputCtrl-Sep.v:52
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_RRArb @plab4-net-RouterOutputCtrl-Sep.v:52
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reqs in module vc_RRArb @plab4-net-RouterOutputCtrl-Sep.v:52
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter grants in module vc_RRArb @plab4-net-RouterOutputCtrl-Sep.v:52
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain reqs_p0_domain) (Domain reqs_p1_domain)) (Domain reqs_p2_domain))  (Domain out_domain))))    ; assign out_val = or (or (grants_p0) (grants_p1)) (grants_p2) @plab4-net-RouterOutputCtrl-Sep.v:63
(check-sat)
(pop)


(push)
(assert (and (= out_domain reqs_p0_domain)  (not(leq (Domain reqs_p0_domain)  LOW))))    ; xbar_sel = 0 @plab4-net-RouterOutputCtrl-Sep.v:72
(check-sat)
(pop)


(push)
(assert (and (= out_domain reqs_p0_domain)  (not(leq (Domain reqs_p0_domain)  LOW))))    ; out_domain = reqs_p0_domain @plab4-net-RouterOutputCtrl-Sep.v:73
(check-sat)
(pop)


(push)
(assert (and (= out_domain reqs_p1_domain)  (not(leq (Domain reqs_p1_domain)  LOW))))    ; xbar_sel = 1 @plab4-net-RouterOutputCtrl-Sep.v:77
(check-sat)
(pop)


(push)
(assert (and (= out_domain reqs_p1_domain)  (not(leq (Domain reqs_p1_domain)  LOW))))    ; out_domain = reqs_p1_domain @plab4-net-RouterOutputCtrl-Sep.v:78
(check-sat)
(pop)


(push)
(assert (and (= out_domain reqs_p2_domain)  (not(leq (Domain reqs_p2_domain)  LOW))))    ; xbar_sel = 2 @plab4-net-RouterOutputCtrl-Sep.v:82
(check-sat)
(pop)


(push)
(assert (and (= out_domain reqs_p2_domain)  (not(leq (Domain reqs_p2_domain)  LOW))))    ; out_domain = reqs_p2_domain @plab4-net-RouterOutputCtrl-Sep.v:83
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; out_domain = 0 @plab4-net-RouterOutputCtrl-Sep.v:87
(check-sat)
(pop)

