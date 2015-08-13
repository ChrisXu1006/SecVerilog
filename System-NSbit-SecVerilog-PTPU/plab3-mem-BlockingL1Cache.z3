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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cachereq_val in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cachereq_rdy in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cacheresp_val in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cacheresp_rdy in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter memreq_val in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter memreq_rdy in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter fail in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter memresp_val in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter memresp_rdy in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter amo_sel in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cachereq_en in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter memresp_en in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter is_refill in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_array_0_wen in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_array_0_ren in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_array_1_wen in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_array_1_ren in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter way_sel in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data_array_wen in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data_array_ren in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data_array_wben in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_data_reg_en in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_tag_reg_en in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_byte_sel in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter memreq_type in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cacheresp_type in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cachereq_type in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cachereq_addr in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_match_0 in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_match_1 in module plab3_mem_BlockingL1CacheCtrl @plab3-mem-BlockingL1Cache.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cachereq_msg in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cacheresp_msg in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter memreq_msg in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter memresp_msg in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter amo_sel in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cachereq_en in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter memresp_en in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter is_refill in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_array_0_wen in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_array_0_ren in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_array_1_wen in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_array_1_ren in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter way_sel in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data_array_wen in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data_array_ren in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data_array_wben in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_data_reg_en in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_tag_reg_en in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_byte_sel in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter memreq_type in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cacheresp_type in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cachereq_type in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter cachereq_addr in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_match_0 in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter tag_match_1 in module plab3_mem_BlockingL1CacheDpath @plab3-mem-BlockingL1Cache.v:170
(check-sat)
(pop)

