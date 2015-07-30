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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Reg @plab1-imul-IntMulVarLat.v:67
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Reg @plab1-imul-IntMulVarLat.v:67
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_Reg @plab1-imul-IntMulVarLat.v:67
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_Reg @plab1-imul-IntMulVarLat.v:67
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_GtComparator @plab1-imul-IntMulVarLat.v:77
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_GtComparator @plab1-imul-IntMulVarLat.v:77
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter in1 in module vc_GtComparator @plab1-imul-IntMulVarLat.v:77
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_GtComparator @plab1-imul-IntMulVarLat.v:77
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab1_imul_CountZeros @plab1-imul-IntMulVarLat.v:89
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter to_be_counted in module plab1_imul_CountZeros @plab1-imul-IntMulVarLat.v:89
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter count in module plab1_imul_CountZeros @plab1-imul-IntMulVarLat.v:89
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_RightLogicalShifter @plab1-imul-IntMulVarLat.v:100
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_RightLogicalShifter @plab1-imul-IntMulVarLat.v:100
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter shamt in module vc_RightLogicalShifter @plab1-imul-IntMulVarLat.v:100
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_RightLogicalShifter @plab1-imul-IntMulVarLat.v:100
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign b_lsb = right_shift_out[0] @plab1-imul-IntMulVarLat.v:108
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_RightLogicalShifter @plab1-imul-IntMulVarLat.v:112
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_RightLogicalShifter @plab1-imul-IntMulVarLat.v:112
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter shamt in module vc_RightLogicalShifter @plab1-imul-IntMulVarLat.v:112
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_RightLogicalShifter @plab1-imul-IntMulVarLat.v:112
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Reg @plab1-imul-IntMulVarLat.v:138
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Reg @plab1-imul-IntMulVarLat.v:138
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_Reg @plab1-imul-IntMulVarLat.v:138
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_Reg @plab1-imul-IntMulVarLat.v:138
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_LeftLogicalShifter @plab1-imul-IntMulVarLat.v:150
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_LeftLogicalShifter @plab1-imul-IntMulVarLat.v:150
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter shamt in module vc_LeftLogicalShifter @plab1-imul-IntMulVarLat.v:150
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_LeftLogicalShifter @plab1-imul-IntMulVarLat.v:150
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_LeftLogicalShifter @plab1-imul-IntMulVarLat.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module vc_LeftLogicalShifter @plab1-imul-IntMulVarLat.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter shamt in module vc_LeftLogicalShifter @plab1-imul-IntMulVarLat.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_LeftLogicalShifter @plab1-imul-IntMulVarLat.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnReg @plab1-imul-IntMulVarLat.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnReg @plab1-imul-IntMulVarLat.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnReg @plab1-imul-IntMulVarLat.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter q in module vc_EnReg @plab1-imul-IntMulVarLat.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnReg @plab1-imul-IntMulVarLat.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnReg @plab1-imul-IntMulVarLat.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_SimpleAdder @plab1-imul-IntMulVarLat.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_SimpleAdder @plab1-imul-IntMulVarLat.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_SimpleAdder @plab1-imul-IntMulVarLat.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_SimpleAdder @plab1-imul-IntMulVarLat.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign out_msg = result_reg_out @plab1-imul-IntMulVarLat.v:221
(check-sat)
(pop)

