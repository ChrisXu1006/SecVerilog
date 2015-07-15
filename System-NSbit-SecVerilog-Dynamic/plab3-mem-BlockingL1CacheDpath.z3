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
(declare-fun data_array_domain () Int)
(assert (<= 0  data_array_domain))
(assert (<= data_array_domain 1))
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(declare-fun tag_array_0_domain () Int)
(assert (<= 0  tag_array_0_domain))
(assert (<= tag_array_0_domain 1))
(declare-fun tag_array_1_domain () Int)
(assert (<= 0  tag_array_1_domain))
(assert (<= tag_array_1_domain 1))

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

; assertions to be verified

(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign cachereq_write_data_replicated[((dbw)*((i)+(1)))-(1):(dbw)*(i)] = cachereq_write_data @plab3-mem-BlockingL1CacheDpath.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_domain)  (Domain cachereq_domain))))    ; Instantiate parameter msg in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_domain)  (Domain cachereq_domain))))    ; Instantiate parameter type in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_domain)  (Domain cachereq_domain))))    ; Instantiate parameter opaque in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_domain)  (Domain cachereq_domain))))    ; Instantiate parameter addr in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_domain)  (Domain cachereq_domain))))    ; Instantiate parameter len in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_domain)  (Domain cachereq_domain))))    ; Instantiate parameter data in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter msg in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter opaque in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter type in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter len in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter data in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign cachereq_type = cachereq_type_reg_out @plab3-mem-BlockingL1CacheDpath.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign cachereq_addr = cachereq_addr_reg_out @plab3-mem-BlockingL1CacheDpath.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign cachereq_nsbit = cachereq_domain_reg_out @plab3-mem-BlockingL1CacheDpath.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign cacheresp_domain = cachereq_domain_reg_out @plab3-mem-BlockingL1CacheDpath.v:184
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in0 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in1 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in2 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in3 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter sel in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter out in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign cachereq_tag = cachereq_addr_reg_out[(abw)-(1):4] @plab3-mem-BlockingL1CacheDpath.v:261
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign cachereq_idx = cachereq_addr_reg_out[(4)+(p_idx_shamt)+:3] @plab3-mem-BlockingL1CacheDpath.v:263
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in_domain in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_addr in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:269
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter read_data in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out_domain in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter write_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain cachereq_nsbit))))    ; Instantiate parameter write_byte_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter write_addr in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter write_data in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in_domain in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_addr in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:288
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter read_data in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out_domain in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter write_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain cachereq_nsbit))))    ; Instantiate parameter write_byte_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter write_addr in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter write_data in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in_domain in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_addr in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:335
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter read_data in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out_domain in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter write_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter read_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter write_byte_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter write_addr in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter write_data in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:335
(check-sat)
(pop)


(push)
(assert (and (= cachereq_nsbit tag_array_0_domain)  (not(leq (Domain tag_array_0_domain)  (Domain cachereq_nsbit)))))    ; tag_array_0_out = tag_array_0_read_out @plab3-mem-BlockingL1CacheDpath.v:355
(check-sat)
(pop)


(push)
(assert (and (not(= cachereq_nsbit tag_array_0_domain))  (not(leq LOW  (Domain cachereq_nsbit)))))    ; tag_array_0_out = 0 @plab3-mem-BlockingL1CacheDpath.v:355
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EqComparator @plab3-mem-BlockingL1CacheDpath.v:357
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in0 in module vc_EqComparator @plab3-mem-BlockingL1CacheDpath.v:357
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in1 in module vc_EqComparator @plab3-mem-BlockingL1CacheDpath.v:357
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter out in module vc_EqComparator @plab3-mem-BlockingL1CacheDpath.v:357
(check-sat)
(pop)


(push)
(assert (and (= cachereq_nsbit tag_array_1_domain)  (not(leq (Domain tag_array_1_domain)  (Domain cachereq_nsbit)))))    ; tag_array_1_out = tag_array_1_read_out @plab3-mem-BlockingL1CacheDpath.v:366
(check-sat)
(pop)


(push)
(assert (and (not(= cachereq_nsbit tag_array_1_domain))  (not(leq LOW  (Domain cachereq_nsbit)))))    ; tag_array_1_out = 0 @plab3-mem-BlockingL1CacheDpath.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EqComparator @plab3-mem-BlockingL1CacheDpath.v:368
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in0 in module vc_EqComparator @plab3-mem-BlockingL1CacheDpath.v:368
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in1 in module vc_EqComparator @plab3-mem-BlockingL1CacheDpath.v:368
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter out in module vc_EqComparator @plab3-mem-BlockingL1CacheDpath.v:368
(check-sat)
(pop)


(push)
(assert (and (= memreq_domain cachereq_nsbit)  (not(leq (Domain cachereq_nsbit)  (Domain memreq_domain)))))    ; memreq_addr = {memreq_type_mux_out, 0} @plab3-mem-BlockingL1CacheDpath.v:451
(check-sat)
(pop)


(push)
(assert (and (not(= memreq_domain cachereq_nsbit))  (not(leq LOW  (Domain memreq_domain)))))    ; memreq_addr = 0 @plab3-mem-BlockingL1CacheDpath.v:451
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:455
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in0 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:455
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in1 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:455
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in2 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:455
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in3 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:455
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter sel in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:455
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter out in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:455
(check-sat)
(pop)


(push)
(assert (and (= cacheresp_domain cachereq_nsbit)  (not(leq (Domain cachereq_nsbit)  (Domain cacheresp_domain)))))    ; cacheresp_opaque = cachereq_opaque_reg_out @plab3-mem-BlockingL1CacheDpath.v:481
(check-sat)
(pop)


(push)
(assert (and (not(= cacheresp_domain cachereq_nsbit))  (not(leq LOW  (Domain cacheresp_domain)))))    ; cacheresp_opaque = 0 @plab3-mem-BlockingL1CacheDpath.v:481
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:483
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cacheresp_domain)  (Domain cacheresp_domain))))    ; Instantiate parameter type in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:483
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cacheresp_domain)  (Domain cacheresp_domain))))    ; Instantiate parameter opaque in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:483
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain cacheresp_domain))))    ; Instantiate parameter len in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:483
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cacheresp_domain)  (Domain cacheresp_domain))))    ; Instantiate parameter data in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:483
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cacheresp_domain)  (Domain cacheresp_domain))))    ; Instantiate parameter msg in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:483
(check-sat)
(pop)


(push)
(assert (and (= memreq_domain cachereq_nsbit)  (not(leq (Domain cachereq_nsbit)  (Domain memreq_domain)))))    ; memreq_data = cachereq_write_data_replicated @plab3-mem-BlockingL1CacheDpath.v:494
(check-sat)
(pop)


(push)
(assert (and (not(= memreq_domain cachereq_nsbit))  (not(leq LOW  (Domain memreq_domain)))))    ; memreq_data = 0 @plab3-mem-BlockingL1CacheDpath.v:494
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:496
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter type in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:496
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain memreq_domain))))    ; Instantiate parameter opaque in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:496
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter addr in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:496
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain memreq_domain))))    ; Instantiate parameter len in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:496
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter data in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:496
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter msg in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:496
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign memreq_domain = cachereq_domain_reg_out @plab3-mem-BlockingL1CacheDpath.v:507
(check-sat)
(pop)

