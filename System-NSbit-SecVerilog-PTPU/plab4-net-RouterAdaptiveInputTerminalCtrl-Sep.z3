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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab4_net_AdaptiveRouteCompute @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter dest in module plab4_net_AdaptiveRouteCompute @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter num_free_chan0 in module plab4_net_AdaptiveRouteCompute @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter num_free_chan2 in module plab4_net_AdaptiveRouteCompute @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter route in module plab4_net_AdaptiveRouteCompute @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign {reqs_p2, reqs_p1, reqs_p0} = reqs @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:75
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign grants = {grants_p2, grants_p1, grants_p0} @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:76
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign in_rdy = |((reqs)&(grants)) @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:79
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; reqs = 1 @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:85
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; reqs = 0 @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:85
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; reqs = 2 @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:86
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; reqs = 4 @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; reqs = 0 @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; reqs = 0 @plab4-net-RouterAdaptiveInputTerminalCtrl-Sep.v:92
(check-sat)
(pop)

