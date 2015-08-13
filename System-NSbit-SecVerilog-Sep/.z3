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

; function for data signals
(declare-fun Data (Int) Label)
(assert (= (Data 0) D1))
(assert (= (Data 1) D2))
(assert (= (Data 2) LOW))
(assert (= (Data 3) HIGH))

; function for control signals
(declare-fun Ctrl (Int) Label)
(assert (= (Ctrl 0) LOW))
(assert (= (Ctrl 1) LOW))
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
(assert  (not(leq LOW  LOW)))    ; grants = 0 @./vc-RRArb.v:16
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 1 @./vc-RRArb.v:17
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 2 @./vc-RRArb.v:18
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 4 @./vc-RRArb.v:19
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; i = ($random())%(2) @./vc-RRArb.v:21
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 1 @./vc-RRArb.v:23
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 2 @./vc-RRArb.v:25
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; i = ($random())%(2) @./vc-RRArb.v:28
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 2 @./vc-RRArb.v:30
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 4 @./vc-RRArb.v:32
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; i = ($random())%(2) @./vc-RRArb.v:35
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 1 @./vc-RRArb.v:37
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 4 @./vc-RRArb.v:39
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; i = ($random())%(3) @./vc-RRArb.v:42
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 1 @./vc-RRArb.v:44
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 2 @./vc-RRArb.v:46
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants = 4 @./vc-RRArb.v:48
(check-sat)
(pop)

