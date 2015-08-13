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
(declare-fun db_domain () Int)
(assert (<= 0  db_domain))
(assert (<= db_domain 1))
(declare-fun db_resp_domain () Int)
(assert (<= 0  db_resp_domain))
(assert (<= db_resp_domain 1))
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
(assert  (not(leq LOW  (Domain domain))))    ; state_reg <= STATE_IDLE @plab5-mcore-Debug-Interface.v:55
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_reg <= state_next @plab5-mcore-Debug-Interface.v:58
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = state_reg @plab5-mcore-Debug-Interface.v:64
(check-sat)
(pop)


(push)
(assert (and (= domain db_domain)  (not(leq (join (Domain db_domain) (Domain domain))  (Domain domain)))))    ; state_next = STATE_DEBUG_REQ @plab5-mcore-Debug-Interface.v:70
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_DEBUG_WAIT @plab5-mcore-Debug-Interface.v:73
(check-sat)
(pop)


(push)
(assert (and (= domain db_resp_domain)  (not(leq (join (Domain db_resp_domain) (Domain domain))  (Domain domain)))))    ; state_next = STATE_EXTRACT_RES @plab5-mcore-Debug-Interface.v:77
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EXTRACT_WAIT @plab5-mcore-Debug-Interface.v:80
(check-sat)
(pop)


(push)
(assert (and (= domain db_resp_domain)  (not(leq (join (Domain db_resp_domain) (Domain domain))  (Domain domain)))))    ; state_next = STATE_RES_CHECK @plab5-mcore-Debug-Interface.v:84
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_IDLE @plab5-mcore-Debug-Interface.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; db_en = 0 @plab5-mcore-Debug-Interface.v:144
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; inst = 'bx @plab5-mcore-Debug-Interface.v:145
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; result_rdy = 0 @plab5-mcore-Debug-Interface.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; start = 0 @plab5-mcore-Debug-Interface.v:151
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; src_addr = 'bxxxx @plab5-mcore-Debug-Interface.v:152
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; dest_addr = 'bxxxx @plab5-mcore-Debug-Interface.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; db_en = 1 @plab5-mcore-Debug-Interface.v:154
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; start = 1 @plab5-mcore-Debug-Interface.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; inst = 0 @plab5-mcore-Debug-Interface.v:159
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; src_addr = src_addr_reg_out @plab5-mcore-Debug-Interface.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; dest_addr = dest_addr_reg_out @plab5-mcore-Debug-Interface.v:161
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; start = 0 @plab5-mcore-Debug-Interface.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; src_addr = src_addr_reg_out @plab5-mcore-Debug-Interface.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; dest_addr = dest_addr_reg_out @plab5-mcore-Debug-Interface.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; start = 1 @plab5-mcore-Debug-Interface.v:171
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; inst = 1 @plab5-mcore-Debug-Interface.v:172
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; src_addr = dest_addr_reg_out @plab5-mcore-Debug-Interface.v:173
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; dest_addr = 'bxxxx @plab5-mcore-Debug-Interface.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; start = 0 @plab5-mcore-Debug-Interface.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; inst = 1 @plab5-mcore-Debug-Interface.v:179
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; src_addr = dest_addr_reg_out @plab5-mcore-Debug-Interface.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; dest_addr = 'bxxxx @plab5-mcore-Debug-Interface.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; start = 0 @plab5-mcore-Debug-Interface.v:185
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; src_addr = 'bxxxx @plab5-mcore-Debug-Interface.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; dest_addr = 'bxxxx @plab5-mcore-Debug-Interface.v:187
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; result_rdy = 1 @plab5-mcore-Debug-Interface.v:188
(check-sat)
(pop)

