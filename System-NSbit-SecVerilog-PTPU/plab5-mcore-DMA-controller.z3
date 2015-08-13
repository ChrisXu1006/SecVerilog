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
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))

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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab5-mcore-DMA-controller.v:86
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab5-mcore-DMA-controller.v:86
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab5-mcore-DMA-controller.v:86
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab5-mcore-DMA-controller.v:86
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab5-mcore-DMA-controller.v:86
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab5-mcore-DMA-controller.v:86
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab5-mcore-DMA-controller.v:96
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab5-mcore-DMA-controller.v:96
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab5-mcore-DMA-controller.v:96
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab5-mcore-DMA-controller.v:96
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab5-mcore-DMA-controller.v:96
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab5-mcore-DMA-controller.v:96
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab5-mcore-DMA-controller.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab5-mcore-DMA-controller.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab5-mcore-DMA-controller.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab5-mcore-DMA-controller.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab5-mcore-DMA-controller.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab5-mcore-DMA-controller.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab5-mcore-DMA-controller.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab5-mcore-DMA-controller.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab5-mcore-DMA-controller.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab5-mcore-DMA-controller.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab5-mcore-DMA-controller.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab5-mcore-DMA-controller.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab5-mcore-DMA-controller.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab5-mcore-DMA-controller.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab5-mcore-DMA-controller.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab5-mcore-DMA-controller.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab5-mcore-DMA-controller.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab5-mcore-DMA-controller.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab5-mcore-DMA-controller.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab5-mcore-DMA-controller.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab5-mcore-DMA-controller.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab5-mcore-DMA-controller.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab5-mcore-DMA-controller.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab5-mcore-DMA-controller.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab5-mcore-DMA-controller.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab5-mcore-DMA-controller.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab5-mcore-DMA-controller.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab5-mcore-DMA-controller.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab5-mcore-DMA-controller.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab5-mcore-DMA-controller.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab5_mcore_MemReqCMsgPack @plab5-mcore-DMA-controller.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter type in module plab5_mcore_MemReqCMsgPack @plab5-mcore-DMA-controller.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain mem_req_domain))))    ; Instantiate parameter opaque in module plab5_mcore_MemReqCMsgPack @plab5-mcore-DMA-controller.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter addr in module plab5_mcore_MemReqCMsgPack @plab5-mcore-DMA-controller.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain mem_req_domain))))    ; Instantiate parameter len in module plab5_mcore_MemReqCMsgPack @plab5-mcore-DMA-controller.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter msg in module plab5_mcore_MemReqCMsgPack @plab5-mcore-DMA-controller.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab5-mcore-DMA-controller.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab5-mcore-DMA-controller.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter enq_domain in module vc_Queue @plab5-mcore-DMA-controller.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter enq_val in module vc_Queue @plab5-mcore-DMA-controller.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter enq_rdy in module vc_Queue @plab5-mcore-DMA-controller.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter enq_msg in module vc_Queue @plab5-mcore-DMA-controller.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter deq_domain in module vc_Queue @plab5-mcore-DMA-controller.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter deq_val in module vc_Queue @plab5-mcore-DMA-controller.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab5-mcore-DMA-controller.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter deq_msg in module vc_Queue @plab5-mcore-DMA-controller.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign domain = secure_reg @plab5-mcore-DMA-controller.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; state_reg <= STATE_IDLE @plab5-mcore-DMA-controller.v:225
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_reg <= state_next @plab5-mcore-DMA-controller.v:228
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = state_reg @plab5-mcore-DMA-controller.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_DEBUG_REG @plab5-mcore-DMA-controller.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_NET_REG @plab5-mcore-DMA-controller.v:240
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_READ_MEM_REQ @plab5-mcore-DMA-controller.v:243
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_READ_MEM_REQ @plab5-mcore-DMA-controller.v:246
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain domain)  (not(leq (join (Domain mem_req_domain) (Domain domain))  (Domain domain)))))    ; state_next = STATE_READ_MEM_WAIT @plab5-mcore-DMA-controller.v:250
(check-sat)
(pop)


(push)
(assert (and (= mem_resp_domain domain)  (not(leq (join (Domain mem_resp_domain) (Domain domain))  (Domain domain)))))    ; state_next = STATE_READ_MEM_DONE @plab5-mcore-DMA-controller.v:254
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WRITE_MEM_REQ @plab5-mcore-DMA-controller.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WRITE_MEM_REQ @plab5-mcore-DMA-controller.v:260
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_DEBUG_RES @plab5-mcore-DMA-controller.v:262
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain domain)  (not(leq (join (Domain mem_req_domain) (Domain domain))  (Domain domain)))))    ; state_next = STATE_WRITE_MEM_WAIT @plab5-mcore-DMA-controller.v:266
(check-sat)
(pop)


(push)
(assert (and (= mem_resp_domain domain)  (not(leq (join (Domain mem_resp_domain) (Domain domain))  (Domain domain)))))    ; state_next = STATE_WRITE_MEM_DONE @plab5-mcore-DMA-controller.v:270
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_ACK @plab5-mcore-DMA-controller.v:273
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_IDLE @plab5-mcore-DMA-controller.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_IDLE @plab5-mcore-DMA-controller.v:279
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; rdy = 0 @plab5-mcore-DMA-controller.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; ack = 0 @plab5-mcore-DMA-controller.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain mem_resp_domain))))    ; enq_en = 0 @plab5-mcore-DMA-controller.v:290
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; dmareq_en = 0 @plab5-mcore-DMA-controller.v:291
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; mem_req_domain = 1 @plab5-mcore-DMA-controller.v:292
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1)  (not(leq LOW  (Domain mem_req_domain)))))    ; mem_req_val = 0 @plab5-mcore-DMA-controller.v:293
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1)  (not(leq LOW  (Domain mem_req_domain)))))    ; mem_req_type = 'bxxx @plab5-mcore-DMA-controller.v:294
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1)  (not(leq LOW  (Domain mem_req_domain)))))    ; mem_req_addr = 'bxxxx @plab5-mcore-DMA-controller.v:295
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1)  (not(leq (Domain domain)  (Domain domain)))))    ; rdy = 1 @plab5-mcore-DMA-controller.v:300
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1)  (not(leq (Domain domain)  (Domain domain)))))    ; dmareq_en = 1 @plab5-mcore-DMA-controller.v:301
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1)  (not(leq (Domain domain)  (Domain domain)))))    ; status = 'bx @plab5-mcore-DMA-controller.v:302
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1)  (not(leq (Domain domain)  (Domain domain)))))    ; status = 1 @plab5-mcore-DMA-controller.v:306
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1)  (not(leq (Domain domain)  (Domain domain)))))    ; status = 0 @plab5-mcore-DMA-controller.v:310
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1) (= domain mem_req_domain)  (not(leq (Domain domain)  (Domain mem_req_domain)))))    ; mem_req_val = 1 @plab5-mcore-DMA-controller.v:315
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1) (= domain mem_req_domain)  (not(leq (Domain domain)  (Domain mem_req_domain)))))    ; mem_req_type = 0 @plab5-mcore-DMA-controller.v:316
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1) (= domain mem_req_domain)  (not(leq (Domain domain)  (Domain mem_req_domain)))))    ; mem_req_addr = src_addr_reg_out @plab5-mcore-DMA-controller.v:318
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1) (= domain mem_req_domain)  (not(leq (Domain domain)  (Domain mem_req_domain)))))    ; mem_req_addr = db_src_addr_reg_out @plab5-mcore-DMA-controller.v:320
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1) (= mem_resp_domain domain)  (not(leq (Domain domain)  (Domain mem_resp_domain)))))    ; enq_en = 1 @plab5-mcore-DMA-controller.v:326
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1) (= domain mem_req_domain)  (not(leq (Domain domain)  (Domain mem_req_domain)))))    ; mem_req_val = 1 @plab5-mcore-DMA-controller.v:331
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1) (= domain mem_req_domain)  (not(leq (Domain domain)  (Domain mem_req_domain)))))    ; mem_req_type = 1 @plab5-mcore-DMA-controller.v:332
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1) (= domain mem_req_domain)  (not(leq (Domain domain)  (Domain mem_req_domain)))))    ; mem_req_addr = dest_addr_reg_out @plab5-mcore-DMA-controller.v:334
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1) (= domain mem_req_domain)  (not(leq (Domain domain)  (Domain mem_req_domain)))))    ; mem_req_addr = db_dest_addr_reg_out @plab5-mcore-DMA-controller.v:336
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1)  (not(leq (Domain domain)  (Domain domain)))))    ; ack = 1 @plab5-mcore-DMA-controller.v:341
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1) (= domain mem_resp_domain)  (not(leq (Domain domain)  (Domain domain)))))    ; ack = 1 @plab5-mcore-DMA-controller.v:346
(check-sat)
(pop)


(push)
(assert (and (= mem_req_domain 1) (= domain mem_resp_domain)  (not(leq (join (Domain mem_resp_domain) (Domain domain))  (Domain domain)))))    ; debug_data = mem_resp_data_reg_out @plab5-mcore-DMA-controller.v:347
(check-sat)
(pop)

