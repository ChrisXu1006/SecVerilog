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
(declare-fun cur_domain () Int)
(assert (<= 0  cur_domain))
(assert (<= cur_domain 1))
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(declare-fun procreq_domain () Int)
(assert (<= 0  procreq_domain))
(assert (<= procreq_domain 1))
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))

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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter found in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter procreq_msg in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter procreq_val in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter procreq_rdy in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter procresp_msg in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter procresp_val in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter procresp_rdy in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memreq_msg in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memreq_val in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memreq_rdy in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memresp_msg in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memresp_val in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memresp_rdy in module plab3_mem_PrefetchBuffer @plab3-mem-BlockingCacheSec-FSM1.v:106
(check-sat)
(pop)


(push)
(assert (and (= cur_domain memresp_domain)  (not(leq (Domain memresp_domain)  (Domain cur_domain)))))    ; cache_insecure = insecure @plab3-mem-BlockingCacheSec-FSM1.v:156
(check-sat)
(pop)


(push)
(assert (and (not(= cur_domain memresp_domain))  (not(leq LOW  (Domain cur_domain)))))    ; cache_insecure = 0 @plab3-mem-BlockingCacheSec-FSM1.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter cachereq_msg in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter cachereq_val in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter cachereq_rdy in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter cacheresp_msg in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter cacheresp_val in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter cacheresp_rdy in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memreq_msg in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memreq_val in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memreq_rdy in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter insecure in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memresp_msg in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memresp_val in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter memresp_rdy in module plab3_mem_BlockingL2Cache @plab3-mem-BlockingCacheSec-FSM1.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_GtComparator @plab3-mem-BlockingCacheSec-FSM1.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain cur_domain))))    ; Instantiate parameter in0 in module vc_GtComparator @plab3-mem-BlockingCacheSec-FSM1.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter in1 in module vc_GtComparator @plab3-mem-BlockingCacheSec-FSM1.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter out in module vc_GtComparator @plab3-mem-BlockingCacheSec-FSM1.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_domain in module plab5_mcore_proc2mem_trans @plab3-mem-BlockingCacheSec-FSM1.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_domain in module plab5_mcore_proc2mem_trans @plab3-mem-BlockingCacheSec-FSM1.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain procreq_domain)  (Domain procreq_domain))))    ; Instantiate parameter proc_req_msg in module plab5_mcore_proc2mem_trans @plab3-mem-BlockingCacheSec-FSM1.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain procreq_domain)  (Domain procreq_domain))))    ; Instantiate parameter mem_req_msg in module plab5_mcore_proc2mem_trans @plab3-mem-BlockingCacheSec-FSM1.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter mem_resp_msg in module plab5_mcore_proc2mem_trans @plab3-mem-BlockingCacheSec-FSM1.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; Instantiate parameter proc_resp_msg in module plab5_mcore_proc2mem_trans @plab3-mem-BlockingCacheSec-FSM1.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; assign req_type = req_msg[(((((dbw)-(1))+($clog2((dbw)/(8))))+(abw))+(o))+(3):(((((dbw)-(1))+($clog2((dbw)/(8))))+(abw))+(o))+(1)] @plab3-mem-BlockingCacheSec-FSM1.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain cur_domain))))    ; state_reg <= STATE_IDLE @plab3-mem-BlockingCacheSec-FSM1.v:259
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_reg <= state_next @plab3-mem-BlockingCacheSec-FSM1.v:262
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = state_reg @plab3-mem-BlockingCacheSec-FSM1.v:272
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain procreq_domain) (Domain cur_domain))  (Domain cur_domain)))))    ; state_next = STATE_REQ_TYPE @plab3-mem-BlockingCacheSec-FSM1.v:277
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_DIR_MEM_REQ @plab3-mem-BlockingCacheSec-FSM1.v:281
(check-sat)
(pop)


(push)
(assert (and (= cur_domain 1)  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; state_next = STATE_CH_CTRLREG @plab3-mem-BlockingCacheSec-FSM1.v:283
(check-sat)
(pop)


(push)
(assert (and (= cur_domain 0)  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; state_next = STATE_EMPTY_RESP @plab3-mem-BlockingCacheSec-FSM1.v:285
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_PREFETCH_REQ @plab3-mem-BlockingCacheSec-FSM1.v:286
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_PREFETCH_WAIT @plab3-mem-BlockingCacheSec-FSM1.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_PREFETCH_RESP @plab3-mem-BlockingCacheSec-FSM1.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_SEC_CHECK @plab3-mem-BlockingCacheSec-FSM1.v:295
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_CACHE_MEM_REQ @plab3-mem-BlockingCacheSec-FSM1.v:297
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_IDLE @plab3-mem-BlockingCacheSec-FSM1.v:300
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_CACHE_REQ @plab3-mem-BlockingCacheSec-FSM1.v:303
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_DIR_MEM_REQ @plab3-mem-BlockingCacheSec-FSM1.v:304
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_DIR_MEM_WAIT @plab3-mem-BlockingCacheSec-FSM1.v:307
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cur_domain)  (not(leq (join (Domain memresp_domain) (Domain cur_domain))  (Domain cur_domain)))))    ; state_next = STATE_DIR_MEM_RESP @plab3-mem-BlockingCacheSec-FSM1.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_IDLE @plab3-mem-BlockingCacheSec-FSM1.v:314
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_CACHE_WAIT @plab3-mem-BlockingCacheSec-FSM1.v:317
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_CACHE_RESP @plab3-mem-BlockingCacheSec-FSM1.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_CACHE_MEM_REQ @plab3-mem-BlockingCacheSec-FSM1.v:323
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_IDLE @plab3-mem-BlockingCacheSec-FSM1.v:326
(check-sat)
(pop)


(push)
(assert (and (= memreq_domain cur_domain)  (not(leq (join (Domain memreq_domain) (Domain cur_domain))  (Domain cur_domain)))))    ; state_next = STATE_CACHE_MEM_WAIT @plab3-mem-BlockingCacheSec-FSM1.v:330
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cur_domain)  (not(leq (join (join (Domain memresp_domain) (Domain cur_domain)) (Domain cur_domain))  (Domain cur_domain)))))    ; state_next = STATE_PREFETCH_MEM_RESP @plab3-mem-BlockingCacheSec-FSM1.v:335
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cur_domain)  (not(leq (join (Domain memresp_domain) (join (join (Domain memresp_domain) (Domain cur_domain)) (Domain cur_domain)))  (Domain cur_domain)))))    ; state_next = STATE_CACHE_WAIT @plab3-mem-BlockingCacheSec-FSM1.v:337
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cur_domain)  (not(leq (join (join (Domain memresp_domain) (Domain cur_domain)) (join (Domain memresp_domain) (join (join (Domain memresp_domain) (Domain cur_domain)) (Domain cur_domain))))  (Domain cur_domain)))))    ; state_next = STATE_PREFETCH_MEM_RESP @plab3-mem-BlockingCacheSec-FSM1.v:340
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cur_domain)  (not(leq (join (Domain memresp_domain) (join (join (Domain memresp_domain) (Domain cur_domain)) (join (Domain memresp_domain) (join (join (Domain memresp_domain) (Domain cur_domain)) (Domain cur_domain)))))  (Domain cur_domain)))))    ; state_next = STATE_CACHE_MEM_RESP @plab3-mem-BlockingCacheSec-FSM1.v:342
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_CACHE_WAIT @plab3-mem-BlockingCacheSec-FSM1.v:345
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_PREFETCH_WAIT @plab3-mem-BlockingCacheSec-FSM1.v:348
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_IDLE @plab3-mem-BlockingCacheSec-FSM1.v:351
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = STATE_IDLE @plab3-mem-BlockingCacheSec-FSM1.v:354
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain procreq_domain) (join (Domain cur_domain) (Domain procreq_domain)))  (Domain cur_domain)))))    ; req_msg_extend <= procreq_msg_extend @plab3-mem-BlockingCacheSec-FSM1.v:385
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain procreq_domain) (join (Domain cur_domain) (Domain procreq_domain)))  (Domain cur_domain)))))    ; req_msg <= procreq_msg @plab3-mem-BlockingCacheSec-FSM1.v:386
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain procreq_domain) (join (Domain cur_domain) (Domain procreq_domain)))  (Domain cur_domain)))))    ; req_addr <= procreq_msg[(((dbw)-(1))+($clog2((dbw)/(8))))+(abw):(((dbw)-(1))+($clog2((dbw)/(8))))+(1)] @plab3-mem-BlockingCacheSec-FSM1.v:387
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain procreq_domain) (join (Domain cur_domain) (Domain procreq_domain)))  (Domain cur_domain)))))    ; req_data <= procreq_msg[(dbw)-(1):0] @plab3-mem-BlockingCacheSec-FSM1.v:388
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain cur_domain) (Domain procreq_domain))  LOW))))    ; cur_domain <= procreq_domain @plab3-mem-BlockingCacheSec-FSM1.v:389
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (join (Domain cur_domain) (Domain procreq_domain))))  (Domain cur_domain)))))    ; req_msg_extend <= cache2memreq_msg @plab3-mem-BlockingCacheSec-FSM1.v:393
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (join (Domain cur_domain) (Domain procreq_domain))))  (Domain cur_domain)))))    ; req_msg <= req_msg @plab3-mem-BlockingCacheSec-FSM1.v:394
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (join (Domain cur_domain) (Domain procreq_domain))))  (Domain cur_domain)))))    ; req_addr <= req_addr @plab3-mem-BlockingCacheSec-FSM1.v:395
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (join (Domain cur_domain) (Domain procreq_domain))))  (Domain cur_domain)))))    ; req_data <= req_data @plab3-mem-BlockingCacheSec-FSM1.v:396
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (Domain procreq_domain)))  LOW))))    ; cur_domain <= cur_domain @plab3-mem-BlockingCacheSec-FSM1.v:397
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (join (Domain cur_domain) (Domain procreq_domain))))  (Domain cur_domain)))))    ; req_msg_extend <= req_msg_extend @plab3-mem-BlockingCacheSec-FSM1.v:401
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (join (Domain cur_domain) (Domain procreq_domain))))  (Domain cur_domain)))))    ; req_msg <= req_msg @plab3-mem-BlockingCacheSec-FSM1.v:402
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (join (Domain cur_domain) (Domain procreq_domain))))  (Domain cur_domain)))))    ; req_addr <= req_addr @plab3-mem-BlockingCacheSec-FSM1.v:403
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (join (Domain cur_domain) (Domain procreq_domain))))  (Domain cur_domain)))))    ; req_data <= req_data @plab3-mem-BlockingCacheSec-FSM1.v:404
(check-sat)
(pop)


(push)
(assert (and (= procreq_domain cur_domain)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (Domain procreq_domain)))  LOW))))    ; cur_domain <= cur_domain @plab3-mem-BlockingCacheSec-FSM1.v:405
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cur_domain)  (not(leq (join (Domain memresp_domain) (join (Domain cur_domain) (Domain memresp_domain)))  (Domain cur_domain)))))    ; resp_msg <= memresp_msg @plab3-mem-BlockingCacheSec-FSM1.v:411
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cur_domain)  (not(leq (join (Domain cur_domain) (Domain memresp_domain))  LOW))))    ; resp_domain <= memresp_domain @plab3-mem-BlockingCacheSec-FSM1.v:412
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cur_domain)  (not(leq (join (Domain memresp_domain) (join (Domain cur_domain) (Domain memresp_domain)))  (Domain cur_domain)))))    ; resp_msg <= memresp_msg @plab3-mem-BlockingCacheSec-FSM1.v:416
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cur_domain)  (not(leq (join (Domain cur_domain) (Domain memresp_domain))  LOW))))    ; resp_domain <= memresp_domain @plab3-mem-BlockingCacheSec-FSM1.v:417
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cur_domain)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (Domain memresp_domain)))  (Domain cur_domain)))))    ; resp_msg <= resp_msg @plab3-mem-BlockingCacheSec-FSM1.v:421
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cur_domain)  (not(leq (join (Domain cur_domain) (Domain memresp_domain))  LOW))))    ; resp_domain <= resp_domain @plab3-mem-BlockingCacheSec-FSM1.v:422
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain procreq_domain))))    ; procreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:429
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain procresp_domain))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:430
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain procresp_domain))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:431
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; procresp_domain = cur_domain @plab3-mem-BlockingCacheSec-FSM1.v:432
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain)  (not(leq LOW  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:433
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain)  (not(leq LOW  LOW))))    ; memreq_domain = cur_domain @plab3-mem-BlockingCacheSec-FSM1.v:434
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain)  (not(leq LOW  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:435
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain)  (not(leq LOW  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:436
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:442
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:443
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:444
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:445
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:446
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:447
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:448
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:449
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:450
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:451
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:452
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:453
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:454
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:455
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:461
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:462
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:463
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:464
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:465
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:466
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:467
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:468
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:469
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:470
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:471
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:472
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:473
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:474
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:480
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:481
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:482
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:483
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:484
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:485
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_msg = req_msg @plab3-mem-BlockingCacheSec-FSM1.v:486
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 1 @plab3-mem-BlockingCacheSec-FSM1.v:487
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:488
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:489
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:490
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:491
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:492
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:493
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:494
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:500
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:501
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:502
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:503
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:504
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:505
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:506
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:507
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:508
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:509
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:510
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:511
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:512
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:513
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:519
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = prebuf2procresp_msg @plab3-mem-BlockingCacheSec-FSM1.v:520
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 1 @plab3-mem-BlockingCacheSec-FSM1.v:521
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:522
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:523
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:524
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:525
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:526
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:527
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:528
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:529
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:530
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:531
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:532
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:538
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:539
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:540
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:541
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:542
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:543
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:544
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:545
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:546
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:547
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:548
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:549
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:550
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:551
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:557
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:558
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:559
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = req_msg_extend @plab3-mem-BlockingCacheSec-FSM1.v:560
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 1 @plab3-mem-BlockingCacheSec-FSM1.v:561
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:562
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:563
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:564
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:565
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:566
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:567
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:568
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:569
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:570
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:576
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:577
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:578
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:579
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:580
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:581
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:582
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:583
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:584
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:585
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:586
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:587
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:588
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:589
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:595
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = memresp_msg_simple @plab3-mem-BlockingCacheSec-FSM1.v:596
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 1 @plab3-mem-BlockingCacheSec-FSM1.v:597
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:598
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:599
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:600
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:601
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:602
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:603
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:604
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:605
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:606
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:607
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:608
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:614
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:615
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:616
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_msg = req_msg @plab3-mem-BlockingCacheSec-FSM1.v:617
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  LOW))))    ; proc2cachereq_domain = procreq_domain @plab3-mem-BlockingCacheSec-FSM1.v:618
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:619
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:620
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:621
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:622
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:623
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:624
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:625
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 1 @plab3-mem-BlockingCacheSec-FSM1.v:626
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:627
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:628
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:629
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:635
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:636
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:637
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:638
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:639
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:640
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:641
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:642
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:643
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:644
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:645
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:646
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:647
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:648
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:649
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:655
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = cache2procresp_msg @plab3-mem-BlockingCacheSec-FSM1.v:656
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 1 @plab3-mem-BlockingCacheSec-FSM1.v:657
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:658
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:659
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:660
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:661
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:662
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:663
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:664
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:665
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:666
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:667
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:668
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:674
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:675
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:676
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = req_msg_extend @plab3-mem-BlockingCacheSec-FSM1.v:677
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 1 @plab3-mem-BlockingCacheSec-FSM1.v:678
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:679
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:680
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:681
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:682
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:683
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:684
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:685
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:686
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:687
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:693
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:694
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:695
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:696
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:697
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:698
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:699
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:700
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:701
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:702
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:703
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:704
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:705
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:706
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:712
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:713
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:714
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:715
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:716
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:717
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_msg = resp_msg @plab3-mem-BlockingCacheSec-FSM1.v:718
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 1 @plab3-mem-BlockingCacheSec-FSM1.v:719
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  LOW))))    ; mem2cacheresp_domain = resp_domain @plab3-mem-BlockingCacheSec-FSM1.v:720
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:721
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:722
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:723
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:724
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:725
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:726
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:727
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:733
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:734
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:735
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:736
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:737
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:738
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_msg = resp_msg @plab3-mem-BlockingCacheSec-FSM1.v:739
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 1 @plab3-mem-BlockingCacheSec-FSM1.v:740
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:741
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:742
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:743
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:744
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:745
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:746
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:752
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = fake_resp_msg @plab3-mem-BlockingCacheSec-FSM1.v:753
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 1 @plab3-mem-BlockingCacheSec-FSM1.v:754
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:755
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:756
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:757
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:758
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:759
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:760
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:761
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:762
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:763
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:764
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:765
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain)) (= cur_domain 1))  (not(leq (Domain cur_domain)  D2))))    ; cache_control_reg = req_data @plab3-mem-BlockingCacheSec-FSM1.v:766
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procreq_domain)))))    ; procreq_rdy = 0 @plab3-mem-BlockingCacheSec-FSM1.v:772
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_msg = fake_resp_msg @plab3-mem-BlockingCacheSec-FSM1.v:773
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain procresp_domain)))))    ; procresp_val = 1 @plab3-mem-BlockingCacheSec-FSM1.v:774
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_msg = 'bxxxx @plab3-mem-BlockingCacheSec-FSM1.v:775
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memreq_domain)))))    ; memreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:776
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain memresp_domain)))))    ; memresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:777
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2prebufreq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:778
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:779
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; prebuf2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:780
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2prebufresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:781
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; proc2cachereq_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:782
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2procresp_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:783
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; cache2memreq_rdy = 1 @plab3-mem-BlockingCacheSec-FSM1.v:784
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain cur_domain) (= memreq_domain cur_domain) (and (and (and (= cur_domain procreq_domain) (= cur_domain procresp_domain)) (= cur_domain memreq_domain)) (= cur_domain memresp_domain))  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; mem2cacheresp_val = 0 @plab3-mem-BlockingCacheSec-FSM1.v:785
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain memresp_domain)  (not(leq (Domain memresp_domain)  (Domain procresp_domain)))))    ; fail = 1 @plab3-mem-BlockingCacheSec-FSM1.v:795
(check-sat)
(pop)


(push)
(assert (and (= procresp_domain memresp_domain)  (not(leq (join (Domain cur_domain) (Domain memresp_domain))  (Domain procresp_domain)))))    ; fail = 0 @plab3-mem-BlockingCacheSec-FSM1.v:797
(check-sat)
(pop)

