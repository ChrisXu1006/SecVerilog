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
(assert (and (= domain 0)  (not(leq (Control domain)  D1))))    ; in_val_d1 = out_val @plab4-net-demux.v:44
(check-sat)
(pop)


(push)
(assert (and (= domain 0)  (not(leq LOW  D2))))    ; in_val_d2 = 0 @plab4-net-demux.v:45
(check-sat)
(pop)


(push)
(assert (and (= domain 0)  (not(leq D1  (Control domain)))))    ; out_rdy = in_rdy_d1 @plab4-net-demux.v:47
(check-sat)
(pop)


(push)
(assert (and (= domain 0)  (not(leq (Control domain)  D1))))    ; in_msg_control_d1 = out_msg_control @plab4-net-demux.v:49
(check-sat)
(pop)


(push)
(assert (and (= domain 0)  (not(leq (Domain domain)  D1))))    ; in_msg_data_d1 = out_msg_data @plab4-net-demux.v:50
(check-sat)
(pop)


(push)
(assert (and (not(= domain 0)) (= domain 1)  (not(leq LOW  D1))))    ; in_val_d1 = 0 @plab4-net-demux.v:55
(check-sat)
(pop)


(push)
(assert (and (not(= domain 0)) (= domain 1)  (not(leq (Control domain)  D2))))    ; in_val_d2 = out_val @plab4-net-demux.v:56
(check-sat)
(pop)


(push)
(assert (and (not(= domain 0)) (= domain 1)  (not(leq D2  (Control domain)))))    ; out_rdy = in_rdy_d2 @plab4-net-demux.v:58
(check-sat)
(pop)


(push)
(assert (and (not(= domain 0)) (= domain 1)  (not(leq (Control domain)  D2))))    ; in_msg_control_d2 = out_msg_control @plab4-net-demux.v:60
(check-sat)
(pop)


(push)
(assert (and (not(= domain 0)) (= domain 1)  (not(leq (Domain domain)  D2))))    ; in_msg_data_d2 = out_msg_data @plab4-net-demux.v:61
(check-sat)
(pop)


(push)
(assert (and (not(= domain 0)) (not(= domain 1))  (not(leq LOW  D1))))    ; in_val_d1 = 0 @plab4-net-demux.v:65
(check-sat)
(pop)


(push)
(assert (and (not(= domain 0)) (not(= domain 1))  (not(leq LOW  D2))))    ; in_val_d2 = 0 @plab4-net-demux.v:66
(check-sat)
(pop)


(push)
(assert (and (not(= domain 0)) (not(= domain 1))  (not(leq LOW  (Control domain)))))    ; out_rdy = 1 @plab4-net-demux.v:68
(check-sat)
(pop)

