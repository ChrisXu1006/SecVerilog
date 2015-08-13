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
(declare-fun dma_domain () Int)
(assert (<= 0  dma_domain))
(assert (<= dma_domain 1))
(declare-fun noc_domain () Int)
(assert (<= 0  noc_domain))
(assert (<= noc_domain 1))
(declare-fun noc_domain_reg () Int)
(assert (<= 0  noc_domain_reg))
(assert (<= noc_domain_reg 1))
(declare-fun noc_resp_domain () Int)
(assert (<= 0  noc_resp_domain))
(assert (<= noc_resp_domain 1))

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
(assert  (not(leq LOW  (Domain noc_domain_reg))))    ; state_reg <= STATE_IDLE @plab5-mcore-DMA-checker.v:80
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain noc_domain_reg)  (Domain noc_domain_reg))))    ; state_reg <= state_next @plab5-mcore-DMA-checker.v:82
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain noc_domain_reg)  (Domain noc_domain_reg))))    ; state_next = state_reg @plab5-mcore-DMA-checker.v:91
(check-sat)
(pop)


(push)
(assert (and (= noc_domain noc_domain_reg)  (not(leq (join (Domain noc_domain) (Domain noc_domain_reg))  (Domain noc_domain_reg)))))    ; state_next = STATE_NOC_CHECK @plab5-mcore-DMA-checker.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain noc_domain_reg)  (Domain noc_domain_reg))))    ; state_next = STATE_NOC_REQ @plab5-mcore-DMA-checker.v:101
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain noc_domain_reg)  (Domain noc_domain_reg))))    ; state_next = STATE_NOC_RESP @plab5-mcore-DMA-checker.v:103
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain noc_domain_reg)  (Domain noc_domain_reg))))    ; state_next = STATE_NOC_WAIT @plab5-mcore-DMA-checker.v:106
(check-sat)
(pop)


(push)
(assert (and (= dma_domain noc_domain_reg)  (not(leq (join (Domain dma_domain) (Domain noc_domain_reg))  (Domain noc_domain_reg)))))    ; state_next = STATE_NOC_RESP @plab5-mcore-DMA-checker.v:110
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain noc_domain_reg)  (Domain noc_domain_reg))))    ; state_next = STATE_IDLE @plab5-mcore-DMA-checker.v:113
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; noc_domain_reg <= 'bxxxx @plab5-mcore-DMA-checker.v:128
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain noc_domain_reg))))    ; noc_src_addr_reg <= 'bxxxx @plab5-mcore-DMA-checker.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain noc_domain_reg))))    ; noc_dest_addr_reg <= 'bxxxx @plab5-mcore-DMA-checker.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain noc_domain_reg))))    ; noc_req_control_reg <= 'bxxxx @plab5-mcore-DMA-checker.v:131
(check-sat)
(pop)


(push)
(assert (and (= noc_domain_reg noc_domain)  (not(leq (Domain noc_domain)  LOW))))    ; noc_domain_reg <= noc_domain @plab5-mcore-DMA-checker.v:135
(check-sat)
(pop)


(push)
(assert (and (= noc_domain_reg noc_domain)  (not(leq (Domain noc_domain)  (Domain noc_domain_reg)))))    ; noc_src_addr_reg <= noc_src_addr @plab5-mcore-DMA-checker.v:136
(check-sat)
(pop)


(push)
(assert (and (= noc_domain_reg noc_domain)  (not(leq (Domain noc_domain)  (Domain noc_domain_reg)))))    ; noc_dest_addr_reg <= noc_dest_addr @plab5-mcore-DMA-checker.v:137
(check-sat)
(pop)


(push)
(assert (and (= noc_domain_reg noc_domain)  (not(leq (Domain noc_domain)  (Domain noc_domain_reg)))))    ; noc_req_control_reg <= noc_req_control @plab5-mcore-DMA-checker.v:138
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain noc_domain))))    ; noc_rdy = 0 @plab5-mcore-DMA-checker.v:152
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain noc_resp_domain))))    ; noc_ack = 0 @plab5-mcore-DMA-checker.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; noc_resp_domain = noc_domain_reg @plab5-mcore-DMA-checker.v:154
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg)  (not(leq LOW  (Domain dma_domain)))))    ; dma_val = 0 @plab5-mcore-DMA-checker.v:156
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg)  (not(leq LOW  (Domain dma_domain)))))    ; dma_src_addr = 'bxxxx @plab5-mcore-DMA-checker.v:157
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg)  (not(leq LOW  (Domain dma_domain)))))    ; dma_dest_addr = 'bxxxx @plab5-mcore-DMA-checker.v:158
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg)  (not(leq LOW  (Domain dma_domain)))))    ; dma_req_control = 'bxxxx @plab5-mcore-DMA-checker.v:159
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg)  (not(leq LOW  (Domain dma_domain)))))    ; dma_inst = 'bx @plab5-mcore-DMA-checker.v:160
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg) (= noc_domain noc_domain_reg)  (not(leq (Domain noc_domain_reg)  (Domain noc_domain)))))    ; noc_rdy = 1 @plab5-mcore-DMA-checker.v:166
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg) (= noc_domain_reg dma_domain)  (not(leq (Domain noc_domain_reg)  (Domain dma_domain)))))    ; dma_val = 1 @plab5-mcore-DMA-checker.v:171
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg) (= noc_domain_reg dma_domain)  (not(leq (Domain noc_domain_reg)  (Domain dma_domain)))))    ; dma_src_addr = noc_src_addr_reg @plab5-mcore-DMA-checker.v:172
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg) (= noc_domain_reg dma_domain)  (not(leq (Domain noc_domain_reg)  (Domain dma_domain)))))    ; dma_dest_addr = noc_dest_addr_reg @plab5-mcore-DMA-checker.v:173
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg) (= noc_domain_reg dma_domain)  (not(leq (Domain noc_domain_reg)  (Domain dma_domain)))))    ; dma_req_control = noc_req_control_reg @plab5-mcore-DMA-checker.v:174
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg) (= noc_domain_reg dma_domain)  (not(leq (Domain noc_domain_reg)  (Domain dma_domain)))))    ; dma_inst = 0 @plab5-mcore-DMA-checker.v:175
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg)  (not(leq (Domain noc_domain_reg)  (Domain noc_resp_domain)))))    ; noc_ack = 1 @plab5-mcore-DMA-checker.v:180
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg)  (not(leq (Domain noc_domain_reg)  (Domain noc_resp_domain)))))    ; noc_resp_control[14:12] = noc_req_control_reg[46:44] @plab5-mcore-DMA-checker.v:189
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg)  (not(leq (Domain noc_domain_reg)  (Domain noc_resp_domain)))))    ; noc_resp_control[11:4] = noc_req_control_reg[43:36] @plab5-mcore-DMA-checker.v:190
(check-sat)
(pop)


(push)
(assert (and (= noc_resp_domain noc_domain_reg)  (not(leq (Domain noc_domain_reg)  (Domain noc_resp_domain)))))    ; noc_resp_control[3:0] = noc_req_control_reg[3:0] @plab5-mcore-DMA-checker.v:191
(check-sat)
(pop)

