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
(declare-fun req0_domain () Int)
(assert (<= 0  req0_domain))
(assert (<= req0_domain 1))
(declare-fun req1_domain () Int)
(assert (<= 0  req1_domain))
(assert (<= req1_domain 1))
(declare-fun req_domain () Int)
(assert (<= 0  req_domain))
(assert (<= req_domain 1))
(declare-fun resp0_domain () Int)
(assert (<= 0  resp0_domain))
(assert (<= resp0_domain 1))
(declare-fun resp1_domain () Int)
(assert (<= 0  resp1_domain))
(assert (<= resp1_domain 1))
(declare-fun resp_domain () Int)
(assert (<= 0  resp_domain))
(assert (<= resp_domain 1))

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
(assert  (not(leq LOW  (Domain req_domain))))    ; state_reg <= STATE_IDLE @plab5-mcore-mem-arbiter.v:84
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; state_reg <= state_next @plab5-mcore-mem-arbiter.v:86
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; state_next = state_reg @plab5-mcore-mem-arbiter.v:90
(check-sat)
(pop)


(push)
(assert (and (= req0_domain req_domain)  (not(leq (join (Domain req0_domain) (Domain req_domain))  (Domain req_domain)))))    ; state_next = STATE_REQ0 @plab5-mcore-mem-arbiter.v:96
(check-sat)
(pop)


(push)
(assert (and (= req1_domain req_domain)  (not(leq (join (Domain req1_domain) (join (Domain req0_domain) (Domain req_domain)))  (Domain req_domain)))))    ; state_next = STATE_REQ1 @plab5-mcore-mem-arbiter.v:98
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; state_next = STATE_WAIT0 @plab5-mcore-mem-arbiter.v:102
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; state_next = STATE_WAIT1 @plab5-mcore-mem-arbiter.v:105
(check-sat)
(pop)


(push)
(assert (and (= req_domain resp_domain)  (not(leq (join (Domain resp_domain) (Domain req_domain))  (Domain req_domain)))))    ; state_next = STATE_RESP0 @plab5-mcore-mem-arbiter.v:109
(check-sat)
(pop)


(push)
(assert (and (= req_domain resp_domain)  (not(leq (join (Domain resp_domain) (Domain req_domain))  (Domain req_domain)))))    ; state_next = STATE_RESP1 @plab5-mcore-mem-arbiter.v:113
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; state_next = STATE_IDLE @plab5-mcore-mem-arbiter.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; state_next = STATE_IDLE @plab5-mcore-mem-arbiter.v:119
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req_domain))))    ; req_en = 0 @plab5-mcore-mem-arbiter.v:254
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain resp_domain))))    ; resp_en = 0 @plab5-mcore-mem-arbiter.v:255
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req0_domain))))    ; req0_rdy = 0 @plab5-mcore-mem-arbiter.v:256
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req1_domain))))    ; req1_rdy = 0 @plab5-mcore-mem-arbiter.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req_domain))))    ; req_val = 0 @plab5-mcore-mem-arbiter.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req_domain))))    ; req_control = 'bxxxx @plab5-mcore-mem-arbiter.v:259
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain req_domain))))    ; req_data = 'bxxxx @plab5-mcore-mem-arbiter.v:260
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain resp_domain))))    ; resp_rdy = 1 @plab5-mcore-mem-arbiter.v:262
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain resp0_domain))))    ; resp0_val = 0 @plab5-mcore-mem-arbiter.v:263
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain resp1_domain))))    ; resp1_val = 0 @plab5-mcore-mem-arbiter.v:264
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; resp0_domain = resp_domain_reg_out @plab5-mcore-mem-arbiter.v:266
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; resp1_domain = resp_domain_reg_out @plab5-mcore-mem-arbiter.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; req_en = 1 @plab5-mcore-mem-arbiter.v:272
(check-sat)
(pop)


(push)
(assert (and (= req_domain req0_domain)  (not(leq (Domain req_domain)  (Domain req_domain)))))    ; req_val = 1 @plab5-mcore-mem-arbiter.v:276
(check-sat)
(pop)


(push)
(assert (and (= req_domain req0_domain)  (not(leq (Domain req_domain)  (Domain req0_domain)))))    ; req0_rdy = 1 @plab5-mcore-mem-arbiter.v:277
(check-sat)
(pop)


(push)
(assert (and (= req_domain req0_domain)  (not(leq (join (Domain req0_domain) (Domain req_domain))  (Domain req_domain)))))    ; req_control = req0_control_reg_out @plab5-mcore-mem-arbiter.v:278
(check-sat)
(pop)


(push)
(assert (and (= req_domain req0_domain)  (not(leq (join (Domain req0_domain) (Domain req_domain))  (Domain req_domain)))))    ; req_data = req0_data_reg_out @plab5-mcore-mem-arbiter.v:279
(check-sat)
(pop)


(push)
(assert (and (= req_domain req0_domain)  (not(leq (Domain req_domain)  LOW))))    ; req_domain = req0_domain_reg_out @plab5-mcore-mem-arbiter.v:280
(check-sat)
(pop)


(push)
(assert (and (= req_domain req1_domain)  (not(leq (Domain req_domain)  (Domain req_domain)))))    ; req_val = 1 @plab5-mcore-mem-arbiter.v:286
(check-sat)
(pop)


(push)
(assert (and (= req_domain req1_domain)  (not(leq (Domain req_domain)  (Domain req1_domain)))))    ; req1_rdy = 1 @plab5-mcore-mem-arbiter.v:287
(check-sat)
(pop)


(push)
(assert (and (= req_domain req1_domain)  (not(leq (join (Domain req1_domain) (Domain req_domain))  (Domain req_domain)))))    ; req_control = req1_control_reg_out @plab5-mcore-mem-arbiter.v:288
(check-sat)
(pop)


(push)
(assert (and (= req_domain req1_domain)  (not(leq (join (Domain req1_domain) (Domain req_domain))  (Domain req_domain)))))    ; req_data = req1_data_reg_out @plab5-mcore-mem-arbiter.v:289
(check-sat)
(pop)


(push)
(assert (and (= req_domain req1_domain)  (not(leq (Domain req_domain)  LOW))))    ; req_domain = req1_domain_reg_out @plab5-mcore-mem-arbiter.v:290
(check-sat)
(pop)


(push)
(assert (and (= resp_domain req_domain)  (not(leq (Domain req_domain)  (Domain resp_domain)))))    ; resp_en = 1 @plab5-mcore-mem-arbiter.v:296
(check-sat)
(pop)


(push)
(assert (and (= resp_domain req_domain)  (not(leq (Domain req_domain)  (Domain resp_domain)))))    ; resp_en = 1 @plab5-mcore-mem-arbiter.v:300
(check-sat)
(pop)


(push)
(assert (and (and (= req_domain resp_domain) (= resp0_domain resp_domain))  (not(leq (Domain req_domain)  (Domain resp0_domain)))))    ; resp0_val = 1 @plab5-mcore-mem-arbiter.v:304
(check-sat)
(pop)


(push)
(assert (and (and (= req_domain resp_domain) (= resp0_domain resp_domain))  (not(leq (Domain req_domain)  (Domain resp_domain)))))    ; resp_rdy = 1 @plab5-mcore-mem-arbiter.v:305
(check-sat)
(pop)


(push)
(assert (and (and (= req_domain resp_domain) (= resp0_domain resp_domain))  (not(leq (join (Domain resp_domain) (Domain req_domain))  (Domain resp0_domain)))))    ; resp0_control = resp_control_reg_out @plab5-mcore-mem-arbiter.v:306
(check-sat)
(pop)


(push)
(assert (and (and (= req_domain resp_domain) (= resp0_domain resp_domain))  (not(leq (join (Domain resp_domain) (Domain req_domain))  (Domain resp0_domain)))))    ; resp0_data = resp_data_reg_out @plab5-mcore-mem-arbiter.v:307
(check-sat)
(pop)


(push)
(assert (and (and (= req_domain resp_domain) (= resp0_domain resp_domain))  (not(leq (join (Domain resp_domain) (Domain req_domain))  (Domain resp0_domain)))))    ; resp0_insecure = resp_insecure @plab5-mcore-mem-arbiter.v:308
(check-sat)
(pop)


(push)
(assert (and (and (= req_domain resp_domain) (= resp1_domain resp_domain))  (not(leq (Domain req_domain)  (Domain resp1_domain)))))    ; resp1_val = 1 @plab5-mcore-mem-arbiter.v:314
(check-sat)
(pop)


(push)
(assert (and (and (= req_domain resp_domain) (= resp1_domain resp_domain))  (not(leq (Domain req_domain)  (Domain resp_domain)))))    ; resp_rdy = 1 @plab5-mcore-mem-arbiter.v:315
(check-sat)
(pop)


(push)
(assert (and (and (= req_domain resp_domain) (= resp1_domain resp_domain))  (not(leq (join (Domain resp_domain) (Domain req_domain))  (Domain resp1_domain)))))    ; resp1_control = resp_control_reg_out @plab5-mcore-mem-arbiter.v:316
(check-sat)
(pop)


(push)
(assert (and (and (= req_domain resp_domain) (= resp1_domain resp_domain))  (not(leq (join (Domain resp_domain) (Domain req_domain))  (Domain resp1_domain)))))    ; resp1_data = resp_data_reg_out @plab5-mcore-mem-arbiter.v:317
(check-sat)
(pop)


(push)
(assert (and (and (= req_domain resp_domain) (= resp1_domain resp_domain))  (not(leq (join (Domain resp_domain) (Domain req_domain))  (Domain resp1_domain)))))    ; resp1_insecure = resp_insecure @plab5-mcore-mem-arbiter.v:318
(check-sat)
(pop)

