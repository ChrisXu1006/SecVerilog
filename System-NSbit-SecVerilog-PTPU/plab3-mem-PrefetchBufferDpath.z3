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
(declare-fun data_array_out_domain () Int)
(assert (<= 0  data_array_out_domain))
(assert (<= data_array_out_domain 1))
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(declare-fun tag_array_0_out_domain () Int)
(assert (<= 0  tag_array_0_out_domain))
(assert (<= tag_array_0_out_domain 1))
(declare-fun tag_array_1_out_domain () Int)
(assert (<= 0  tag_array_1_out_domain))
(assert (<= tag_array_1_out_domain 1))

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
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_write_data_replicated[((dbw)*((i)+(1)))-(1):(dbw)*(i)] = cachereq_write_data @plab3-mem-PrefetchBufferDpath.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemReqMsgUnpack @plab3-mem-PrefetchBufferDpath.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter msg in module vc_MemReqMsgUnpack @plab3-mem-PrefetchBufferDpath.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter type in module vc_MemReqMsgUnpack @plab3-mem-PrefetchBufferDpath.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter opaque in module vc_MemReqMsgUnpack @plab3-mem-PrefetchBufferDpath.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter addr in module vc_MemReqMsgUnpack @plab3-mem-PrefetchBufferDpath.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter len in module vc_MemReqMsgUnpack @plab3-mem-PrefetchBufferDpath.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data in module vc_MemReqMsgUnpack @plab3-mem-PrefetchBufferDpath.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemRespMsgUnpack @plab3-mem-PrefetchBufferDpath.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter msg in module vc_MemRespMsgUnpack @plab3-mem-PrefetchBufferDpath.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter opaque in module vc_MemRespMsgUnpack @plab3-mem-PrefetchBufferDpath.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter type in module vc_MemRespMsgUnpack @plab3-mem-PrefetchBufferDpath.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter len in module vc_MemRespMsgUnpack @plab3-mem-PrefetchBufferDpath.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data in module vc_MemRespMsgUnpack @plab3-mem-PrefetchBufferDpath.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_type = cachereq_type_reg_out @plab3-mem-PrefetchBufferDpath.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_addr = cachereq_addr_reg_out @plab3-mem-PrefetchBufferDpath.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:173
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:173
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:173
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:173
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:173
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:173
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:189
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:189
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:189
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:189
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:189
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:189
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:189
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_tag = cachereq_addr_reg_out[(abw)-(1):4] @plab3-mem-PrefetchBufferDpath.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_idx = cachereq_addr_reg_out[(4)+(p_idx_shamt)+:3] @plab3-mem-PrefetchBufferDpath.v:236
(check-sat)
(pop)


(push)
(assert (and (= tag_array_0_out_domain domain)  (not(leq (Domain tag_array_0_out_domain)  (Domain domain)))))    ; tag_array_0_read_out = tag_array_0_out @plab3-mem-PrefetchBufferDpath.v:243
(check-sat)
(pop)


(push)
(assert (and (not(= tag_array_0_out_domain domain))  (not(leq LOW  (Domain domain)))))    ; tag_array_0_read_out = 0 @plab3-mem-PrefetchBufferDpath.v:243
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in_domain in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_addr in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:245
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter read_data in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out_domain in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_en in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_en in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter write_byte_en in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_addr in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_data in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:245
(check-sat)
(pop)


(push)
(assert (and (= tag_array_1_out_domain domain)  (not(leq (Domain tag_array_1_out_domain)  (Domain domain)))))    ; tag_array_1_read_out = tag_array_1_out @plab3-mem-PrefetchBufferDpath.v:265
(check-sat)
(pop)


(push)
(assert (and (not(= tag_array_1_out_domain domain))  (not(leq LOW  (Domain domain)))))    ; tag_array_1_read_out = 0 @plab3-mem-PrefetchBufferDpath.v:265
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in_domain in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_addr in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:267
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter read_data in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out_domain in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_en in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_en in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter write_byte_en in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_addr in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_data in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:267
(check-sat)
(pop)


(push)
(assert (and (= data_array_out_domain domain)  (not(leq (Domain data_array_out_domain)  (Domain domain)))))    ; data_array_read_out = data_array_out @plab3-mem-PrefetchBufferDpath.v:286
(check-sat)
(pop)


(push)
(assert (and (not(= data_array_out_domain domain))  (not(leq LOW  (Domain domain)))))    ; data_array_read_out = 0 @plab3-mem-PrefetchBufferDpath.v:286
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter in_domain in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_addr in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:289
(check-sat)
(pop)


(push)
(declare-fun out_domain () Int)
(assert (<= 0  out_domain))
(assert (<= out_domain 1))
(assert  (not(leq (Domain out_domain)  (Domain out_domain))))    ; Instantiate parameter read_data in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_en in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter read_en in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter out_domain in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_byte_en in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_addr in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter write_data in module vc_CombinationalSRAM_1rw @plab3-mem-PrefetchBufferDpath.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EqComparator @plab3-mem-PrefetchBufferDpath.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_EqComparator @plab3-mem-PrefetchBufferDpath.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_EqComparator @plab3-mem-PrefetchBufferDpath.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_EqComparator @plab3-mem-PrefetchBufferDpath.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EqComparator @plab3-mem-PrefetchBufferDpath.v:317
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_EqComparator @plab3-mem-PrefetchBufferDpath.v:317
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_EqComparator @plab3-mem-PrefetchBufferDpath.v:317
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_EqComparator @plab3-mem-PrefetchBufferDpath.v:317
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter en in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter d in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter q in module vc_EnResetReg @plab3-mem-PrefetchBufferDpath.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign memreq_addr = {memreq_type_mux_out, 0} @plab3-mem-PrefetchBufferDpath.v:380
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in0 in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in1 in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in2 in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in3 in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter sel in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module vc_Mux4 @plab3-mem-PrefetchBufferDpath.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemRespMsgPack @plab3-mem-PrefetchBufferDpath.v:406
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter type in module vc_MemRespMsgPack @plab3-mem-PrefetchBufferDpath.v:406
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter opaque in module vc_MemRespMsgPack @plab3-mem-PrefetchBufferDpath.v:406
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter len in module vc_MemRespMsgPack @plab3-mem-PrefetchBufferDpath.v:406
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data in module vc_MemRespMsgPack @plab3-mem-PrefetchBufferDpath.v:406
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter msg in module vc_MemRespMsgPack @plab3-mem-PrefetchBufferDpath.v:406
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module vc_MemReqMsgPack @plab3-mem-PrefetchBufferDpath.v:417
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter type in module vc_MemReqMsgPack @plab3-mem-PrefetchBufferDpath.v:417
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter opaque in module vc_MemReqMsgPack @plab3-mem-PrefetchBufferDpath.v:417
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter addr in module vc_MemReqMsgPack @plab3-mem-PrefetchBufferDpath.v:417
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; Instantiate parameter len in module vc_MemReqMsgPack @plab3-mem-PrefetchBufferDpath.v:417
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter data in module vc_MemReqMsgPack @plab3-mem-PrefetchBufferDpath.v:417
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter msg in module vc_MemReqMsgPack @plab3-mem-PrefetchBufferDpath.v:417
(check-sat)
(pop)

