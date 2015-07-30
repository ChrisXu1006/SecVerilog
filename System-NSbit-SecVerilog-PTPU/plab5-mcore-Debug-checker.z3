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
(declare-fun debug_domain () Int)
(assert (<= 0  debug_domain))
(assert (<= debug_domain 1))
(declare-fun debug_domain_reg () Int)
(assert (<= 0  debug_domain_reg))
(assert (<= debug_domain_reg 1))
(declare-fun debug_resp_domain () Int)
(assert (<= 0  debug_resp_domain))
(assert (<= debug_resp_domain 1))
(declare-fun dma_domain () Int)
(assert (<= 0  dma_domain))
(assert (<= dma_domain 1))

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
(assert  (not(leq LOW  (Domain debug_domain_reg))))    ; state_reg <= STATE_IDLE @plab5-mcore-Debug-checker.v:66
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain debug_domain_reg)  (Domain debug_domain_reg))))    ; state_reg <= state_next @plab5-mcore-Debug-checker.v:68
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain debug_domain_reg)  (Domain debug_domain_reg))))    ; state_next = state_reg @plab5-mcore-Debug-checker.v:77
(check-sat)
(pop)


(push)
(assert (and (= debug_domain debug_domain_reg)  (not(leq (join (Domain debug_domain) (Domain debug_domain_reg))  (Domain debug_domain_reg)))))    ; state_next = STATE_DEB_CHECK @plab5-mcore-Debug-checker.v:83
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain debug_domain_reg)  (Domain debug_domain_reg))))    ; state_next = STATE_DEB_REQ @plab5-mcore-Debug-checker.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain debug_domain_reg)  (Domain debug_domain_reg))))    ; state_next = STATE_DEB_RESP @plab5-mcore-Debug-checker.v:89
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain debug_domain_reg)  (Domain debug_domain_reg))))    ; state_next = STATE_DEB_WAIT @plab5-mcore-Debug-checker.v:92
(check-sat)
(pop)


(push)
(assert (and (= debug_domain_reg dma_domain)  (not(leq (join (Domain dma_domain) (Domain debug_domain_reg))  (Domain debug_domain_reg)))))    ; state_next = STATE_DEB_RESP @plab5-mcore-Debug-checker.v:96
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain debug_domain_reg)  (Domain debug_domain_reg))))    ; state_next = STATE_IDLE @plab5-mcore-Debug-checker.v:99
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; debug_domain_reg <= 'bxxxx @plab5-mcore-Debug-checker.v:114
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain debug_domain_reg))))    ; debug_inst_reg <= 'bxxxx @plab5-mcore-Debug-checker.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain debug_domain_reg))))    ; debug_src_addr_reg <= 'bxxxx @plab5-mcore-Debug-checker.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain debug_domain_reg))))    ; debug_dest_addr_reg <= 'bxxxx @plab5-mcore-Debug-checker.v:117
(check-sat)
(pop)


(push)
(assert (and (= debug_domain_reg debug_domain)  (not(leq (Domain debug_domain)  LOW))))    ; debug_domain_reg <= debug_domain @plab5-mcore-Debug-checker.v:122
(check-sat)
(pop)


(push)
(assert (and (= debug_domain_reg debug_domain)  (not(leq (Domain debug_domain)  (Domain debug_domain_reg)))))    ; debug_inst_reg <= debug_inst @plab5-mcore-Debug-checker.v:123
(check-sat)
(pop)


(push)
(assert (and (= debug_domain_reg debug_domain)  (not(leq (Domain debug_domain)  (Domain debug_domain_reg)))))    ; debug_src_addr_reg <= debug_src_addr @plab5-mcore-Debug-checker.v:124
(check-sat)
(pop)


(push)
(assert (and (= debug_domain_reg debug_domain)  (not(leq (Domain debug_domain)  (Domain debug_domain_reg)))))    ; debug_dest_addr_reg <= debug_dest_addr @plab5-mcore-Debug-checker.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain debug_resp_domain))))    ; debug_ack = 0 @plab5-mcore-Debug-checker.v:140
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain debug_resp_domain))))    ; debug_data = 'bxxxx @plab5-mcore-Debug-checker.v:141
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; debug_resp_domain = debug_domain_reg @plab5-mcore-Debug-checker.v:142
(check-sat)
(pop)


(push)
(assert (and (= debug_resp_domain debug_domain_reg)  (not(leq LOW  (Domain dma_domain)))))    ; dma_db_val = 0 @plab5-mcore-Debug-checker.v:144
(check-sat)
(pop)


(push)
(assert (and (= debug_resp_domain debug_domain_reg)  (not(leq LOW  (Domain dma_domain)))))    ; dma_db_src_addr = 'bxxxx @plab5-mcore-Debug-checker.v:145
(check-sat)
(pop)


(push)
(assert (and (= debug_resp_domain debug_domain_reg)  (not(leq LOW  (Domain dma_domain)))))    ; dma_db_dest_addr = 'bxxxx @plab5-mcore-Debug-checker.v:146
(check-sat)
(pop)


(push)
(assert (and (= debug_resp_domain debug_domain_reg)  (not(leq LOW  (Domain dma_domain)))))    ; dma_db_inst = 'bx @plab5-mcore-Debug-checker.v:147
(check-sat)
(pop)


(push)
(assert (and (= debug_resp_domain debug_domain_reg) (= debug_domain_reg dma_domain)  (not(leq (Domain debug_domain_reg)  (Domain dma_domain)))))    ; dma_db_val = 1 @plab5-mcore-Debug-checker.v:153
(check-sat)
(pop)


(push)
(assert (and (= debug_resp_domain debug_domain_reg) (= debug_domain_reg dma_domain)  (not(leq (Domain debug_domain_reg)  (Domain dma_domain)))))    ; dma_db_src_addr = debug_src_addr_reg @plab5-mcore-Debug-checker.v:154
(check-sat)
(pop)


(push)
(assert (and (= debug_resp_domain debug_domain_reg) (= debug_domain_reg dma_domain)  (not(leq (Domain debug_domain_reg)  (Domain dma_domain)))))    ; dma_db_dest_addr = debug_dest_addr_reg @plab5-mcore-Debug-checker.v:155
(check-sat)
(pop)


(push)
(assert (and (= debug_resp_domain debug_domain_reg) (= debug_domain_reg dma_domain)  (not(leq (Domain debug_domain_reg)  (Domain dma_domain)))))    ; dma_db_inst = debug_inst_reg @plab5-mcore-Debug-checker.v:156
(check-sat)
(pop)


(push)
(assert (and (= debug_resp_domain debug_domain_reg) (= debug_domain_reg dma_domain)  (not(leq (Domain debug_domain_reg)  (Domain debug_resp_domain)))))    ; debug_ack = 1 @plab5-mcore-Debug-checker.v:162
(check-sat)
(pop)


(push)
(assert (and (= debug_resp_domain debug_domain_reg) (= debug_domain_reg dma_domain)  (not(leq (join (Domain dma_domain) (Domain debug_domain_reg))  (Domain debug_resp_domain)))))    ; debug_data = dma_db_debug_data @plab5-mcore-Debug-checker.v:163
(check-sat)
(pop)

