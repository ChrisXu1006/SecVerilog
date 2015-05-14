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

; assertions to be verified

(push)
(assert  (not(leq LOW  LOW)))    ; grants_int[i] = reqs_int[i] @./vc-arbiters.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; grants_int[i] = and (!(kills[i])) (reqs_int[i]) @./vc-arbiters.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; kills[(i)+(1)] = grants_int[i] @./vc-arbiters.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; kills[(i)+(1)] = or (kills[i]) (grants_int[i]) @./vc-arbiters.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign kills[0] = 1 @./vc-arbiters.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign priority_int = {{p_num_reqs{0}}, priority} @./vc-arbiters.v:128
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign reqs_int = {reqs, reqs} @./vc-arbiters.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign grants = ((grants_int[(p_num_reqs)-(1):0])|(grants_int[((2)*(p_num_reqs))-(1):p_num_reqs]))&({p_num_reqs{~(kin)}}) @./vc-arbiters.v:161
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign kout = or (kills[(2)*(p_num_reqs)]) (kin) @./vc-arbiters.v:165
(check-sat)
(pop)
