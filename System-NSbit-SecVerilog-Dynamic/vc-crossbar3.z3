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
(declare-fun in0_domain () Int)
(assert (<= 0  in0_domain))
(assert (<= in0_domain 1))
(declare-fun in1_domain () Int)
(assert (<= 0  in1_domain))
(assert (<= in1_domain 1))
(declare-fun in2_domain () Int)
(assert (<= 0  in2_domain))
(assert (<= in2_domain 1))
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
(assert  (not(leq (Domain in0_domain)  (Domain in0_domain))))    ; Instantiate parameter in0 in module vc_Mux31 @vc-crossbar3.v:44
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in1_domain)  (Domain in1_domain))))    ; Instantiate parameter in1 in module vc_Mux31 @vc-crossbar3.v:44
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in2_domain)  (Domain in2_domain))))    ; Instantiate parameter in2 in module vc_Mux31 @vc-crossbar3.v:44
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in0_domain in module vc_Mux31 @vc-crossbar3.v:44
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in1_domain in module vc_Mux31 @vc-crossbar3.v:44
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in2_domain in module vc_Mux31 @vc-crossbar3.v:44
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel in module vc_Mux31 @vc-crossbar3.v:44
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter out in module vc_Mux31 @vc-crossbar3.v:44
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out_domain in module vc_Mux31 @vc-crossbar3.v:44
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in0_domain)  (Domain in0_domain))))    ; Instantiate parameter in0 in module vc_Mux31 @vc-crossbar3.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in1_domain)  (Domain in1_domain))))    ; Instantiate parameter in1 in module vc_Mux31 @vc-crossbar3.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in2_domain)  (Domain in2_domain))))    ; Instantiate parameter in2 in module vc_Mux31 @vc-crossbar3.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in0_domain in module vc_Mux31 @vc-crossbar3.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in1_domain in module vc_Mux31 @vc-crossbar3.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in2_domain in module vc_Mux31 @vc-crossbar3.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel in module vc_Mux31 @vc-crossbar3.v:57
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter out in module vc_Mux31 @vc-crossbar3.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out_domain in module vc_Mux31 @vc-crossbar3.v:57
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in0_domain)  (Domain in0_domain))))    ; Instantiate parameter in0 in module vc_Mux31 @vc-crossbar3.v:70
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in1_domain)  (Domain in1_domain))))    ; Instantiate parameter in1 in module vc_Mux31 @vc-crossbar3.v:70
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain in2_domain)  (Domain in2_domain))))    ; Instantiate parameter in2 in module vc_Mux31 @vc-crossbar3.v:70
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in0_domain in module vc_Mux31 @vc-crossbar3.v:70
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in1_domain in module vc_Mux31 @vc-crossbar3.v:70
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in2_domain in module vc_Mux31 @vc-crossbar3.v:70
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel in module vc_Mux31 @vc-crossbar3.v:70
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter out in module vc_Mux31 @vc-crossbar3.v:70
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out_domain in module vc_Mux31 @vc-crossbar3.v:70
(check-sat)
(pop)

