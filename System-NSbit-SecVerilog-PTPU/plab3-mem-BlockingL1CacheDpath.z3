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
(declare-fun data_domain () Int)
(assert (<= 0  data_domain))
(assert (<= data_domain 1))
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(declare-fun tag_0_domain () Int)
(assert (<= 0  tag_0_domain))
(assert (<= tag_0_domain 1))
(declare-fun tag_1_domain () Int)
(assert (<= 0  tag_1_domain))
(assert (<= tag_1_domain 1))

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

; assertions to be verified

(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_write_data_replicated[((dbw)*((i)+(1)))-(1):(dbw)*(i)] = cachereq_write_data @plab3-mem-BlockingL1CacheDpath.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:88
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter msg in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:88
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter type in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:88
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter opaque in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:88
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter addr in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:88
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter len in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:88
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data in module vc_MemReqMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:88
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:108
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter msg in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:108
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter opaque in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:108
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter type in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:108
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter len in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:108
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data in module vc_MemRespMsgUnpack @plab3-mem-BlockingL1CacheDpath.v:108
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_type = cachereq_type_reg_out @plab3-mem-BlockingL1CacheDpath.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_addr = cachereq_addr_reg_out @plab3-mem-BlockingL1CacheDpath.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:190
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:190
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:190
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:190
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:190
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:190
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_tag = cachereq_addr_reg_out[(abw)-(1):4] @plab3-mem-BlockingL1CacheDpath.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_idx = cachereq_addr_reg_out[(4)+(p_idx_shamt)+:3] @plab3-mem-BlockingL1CacheDpath.v:237
(check-sat)
(pop)


(push)
(assert (and (= data_domain domain)  (not(leq (Domain domain)  (Domain domain)))))    ; data_array_read_out = data_array_read_out @plab3-mem-BlockingL1CacheDpath.v:281
(check-sat)
(pop)


(push)
(assert (and (not(= data_domain domain))  (not(leq LOW  (Domain domain)))))    ; data_array_read_out = 0 @plab3-mem-BlockingL1CacheDpath.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in_domain in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_addr in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:283
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter read_data in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out_domain in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_byte_en in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_addr in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_data in module vc_CombinationalSRAM_1rw @plab3-mem-BlockingL1CacheDpath.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:337
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:337
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:337
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:337
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:337
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:337
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:351
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:351
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:351
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:351
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:351
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab3-mem-BlockingL1CacheDpath.v:351
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign memreq_addr = {memreq_type_mux_out, 0} @plab3-mem-BlockingL1CacheDpath.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:382
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:382
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:382
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:382
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:382
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux4 @plab3-mem-BlockingL1CacheDpath.v:382
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter type in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter opaque in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter len in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter msg in module vc_MemRespMsgPack @plab3-mem-BlockingL1CacheDpath.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:405
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter type in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:405
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter opaque in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:405
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter addr in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:405
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter len in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:405
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:405
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter msg in module vc_MemReqMsgPack @plab3-mem-BlockingL1CacheDpath.v:405
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain tag_0_domain)  (Domain domain))))    ; tag_match_0 = 1 @plab3-mem-BlockingL1CacheDpath.v:307
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain tag_0_domain)  (Domain domain))))    ; tag_match_0 = 0 @plab3-mem-BlockingL1CacheDpath.v:309
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Domain domain) (Domain tag_1_domain))  (Domain domain))))    ; tag_match_1 = 1 @plab3-mem-BlockingL1CacheDpath.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Domain domain) (Domain tag_1_domain))  (Domain domain))))    ; tag_match_1 = 0 @plab3-mem-BlockingL1CacheDpath.v:318
(check-sat)
(pop)

