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
(declare-fun cachereq_domain () Int)
(assert (<= 0  cachereq_domain))
(assert (<= cachereq_domain 1))
(declare-fun cachereq_nsbit () Int)
(assert (<= 0  cachereq_nsbit))
(assert (<= cachereq_nsbit 1))
(declare-fun cacheresp_domain () Int)
(assert (<= 0  cacheresp_domain))
(assert (<= cacheresp_domain 1))
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))

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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_domain)  (Domain cachereq_domain))))    ; Instantiate parameter cachereq_val in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_domain)  (Domain cachereq_domain))))    ; Instantiate parameter cachereq_rdy in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter cachereq_domain in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cacheresp_domain)  (Domain cacheresp_domain))))    ; Instantiate parameter cacheresp_val in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cacheresp_domain)  (Domain cacheresp_domain))))    ; Instantiate parameter cacheresp_rdy in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter cacheresp_domain in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_val in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_rdy in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memreq_domain in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter fail in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_val in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_rdy in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memresp_domain in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter amo_sel in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter cachereq_en in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter memresp_en in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter is_refill in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_array_0_wen in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_array_0_ren in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_array_1_wen in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_array_1_ren in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter nsb_array_0_wen in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter nsb_array_0_ren in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter nsb_array_1_wen in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter nsb_array_1_ren in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter way_sel in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter data_array_wen in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter data_array_ren in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter data_array_wben in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_data_reg_en in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_tag_reg_en in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_byte_sel in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_type in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cacheresp_domain)  (Domain cacheresp_domain))))    ; Instantiate parameter cacheresp_type in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter secure_mask in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter cachereq_type in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter cachereq_addr in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter cachereq_nsbit in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_match_0 in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_match_1 in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter nsb_match_0 in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter nsb_match_1 in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_domain)  (Domain cachereq_domain))))    ; Instantiate parameter cachereq_msg in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter cachereq_domain in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cacheresp_domain)  (Domain cacheresp_domain))))    ; Instantiate parameter cacheresp_msg in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter cacheresp_domain in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_msg in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memreq_domain in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_msg in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memresp_domain in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter amo_sel in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter cachereq_en in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter memresp_en in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter is_refill in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_array_0_wen in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_array_0_ren in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_array_1_wen in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_array_1_ren in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter nsb_array_0_wen in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter nsb_array_0_ren in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter nsb_array_1_wen in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter nsb_array_1_ren in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter way_sel in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter data_array_wen in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter data_array_ren in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter data_array_wben in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_data_reg_en in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_tag_reg_en in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_byte_sel in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_type in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cacheresp_domain)  (Domain cacheresp_domain))))    ; Instantiate parameter cacheresp_type in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter secure_mask in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter cachereq_type in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter cachereq_addr in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter cachereq_nsbit in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_match_0 in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter tag_match_1 in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter nsb_match_0 in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter nsb_match_1 in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:191
(check-sat)
(pop)

