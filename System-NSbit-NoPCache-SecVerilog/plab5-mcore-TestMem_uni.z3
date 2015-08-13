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
(assert  (not(leq LOW  LOW)))    ; assign c_read = 0 @plab5-mcore-TestMem_uni.v:92
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign c_write = 1 @plab5-mcore-TestMem_uni.v:93
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign c_write_init = 2 @plab5-mcore-TestMem_uni.v:94
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign c_amo_add = 3 @plab5-mcore-TestMem_uni.v:95
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign c_amo_and = 4 @plab5-mcore-TestMem_uni.v:96
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign c_amo_or = 5 @plab5-mcore-TestMem_uni.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab5-mcore-TestMem_uni.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab5-mcore-TestMem_uni.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Control memreq_domain))))    ; Instantiate parameter domain in module vc_Queue @plab5-mcore-TestMem_uni.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Control memreq_domain))))    ; Instantiate parameter enq_val in module vc_Queue @plab5-mcore-TestMem_uni.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq (Control memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter enq_rdy in module vc_Queue @plab5-mcore-TestMem_uni.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter enq_msg in module vc_Queue @plab5-mcore-TestMem_uni.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq (Control memreq_domain)  (Domain memresp_domain))))    ; Instantiate parameter deq_val in module vc_Queue @plab5-mcore-TestMem_uni.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Control memreq_domain))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab5-mcore-TestMem_uni.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memresp_domain))))    ; Instantiate parameter deq_msg in module vc_Queue @plab5-mcore-TestMem_uni.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab5-mcore-TestMem_uni.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab5-mcore-TestMem_uni.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Control memreq_domain))))    ; Instantiate parameter domain in module vc_Queue @plab5-mcore-TestMem_uni.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Control memreq_domain))))    ; Instantiate parameter enq_val in module vc_Queue @plab5-mcore-TestMem_uni.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (Control memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter enq_rdy in module vc_Queue @plab5-mcore-TestMem_uni.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter enq_msg in module vc_Queue @plab5-mcore-TestMem_uni.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (Control memreq_domain)  (Domain memresp_domain))))    ; Instantiate parameter deq_val in module vc_Queue @plab5-mcore-TestMem_uni.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Control memreq_domain))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab5-mcore-TestMem_uni.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memreq_domain)  (Domain memresp_domain))))    ; Instantiate parameter deq_msg in module vc_Queue @plab5-mcore-TestMem_uni.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; memreq_msg_len_modified_M = (128)/(8) @plab5-mcore-TestMem_uni.v:205
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; memreq_msg_len_modified_M = memreq_msg_len_M @plab5-mcore-TestMem_uni.v:205
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; assign physical_byte_addr_M = memreq_msg_addr_M[(c_physical_addr_nbits)-(1):0] @plab5-mcore-TestMem_uni.v:211
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; assign part = memreq_msg_addr_M[15:14] @plab5-mcore-TestMem_uni.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; assign physical_block_addr_M = ((physical_byte_addr_M)/(16))-((((1)<<(16))/(64))*(part)) @plab5-mcore-TestMem_uni.v:219
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; assign block_offset_M = physical_byte_addr_M[(c_block_offset_nbits)-(1):0] @plab5-mcore-TestMem_uni.v:222
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; assign read_data_M = (read_block_M)>>((block_offset_M)*(8)) @plab5-mcore-TestMem_uni.v:242
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; assign write_en_M = and (memreq_val_M) (or (= memreq_msg_type_M c_write) (= memreq_msg_type_M c_write_init)) @plab5-mcore-TestMem_uni.v:248
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain memresp_domain) (Domain memresp_domain)) (Domain memresp_domain))  (Domain memresp_domain))))    ; assign amo_en_M = and (and (memreq_val_M) (memreq_rdy_M)) (or (or (= memreq_msg_type_M c_amo_and) (= memreq_msg_type_M c_amo_add)) (= memreq_msg_type_M c_amo_or)) @plab5-mcore-TestMem_uni.v:254
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; assign memresp_data_M = read_data_M @plab5-mcore-TestMem_uni.v:338
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab5-mcore-TestMem_uni.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab5-mcore-TestMem_uni.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Control memresp_domain))))    ; Instantiate parameter domain in module vc_Queue @plab5-mcore-TestMem_uni.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Control memresp_domain))))    ; Instantiate parameter enq_val in module vc_Queue @plab5-mcore-TestMem_uni.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq (Control memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter enq_rdy in module vc_Queue @plab5-mcore-TestMem_uni.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter enq_msg in module vc_Queue @plab5-mcore-TestMem_uni.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq (Control memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter deq_val in module vc_Queue @plab5-mcore-TestMem_uni.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Control memresp_domain))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab5-mcore-TestMem_uni.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter deq_msg in module vc_Queue @plab5-mcore-TestMem_uni.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module vc_Queue @plab5-mcore-TestMem_uni.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module vc_Queue @plab5-mcore-TestMem_uni.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Control memresp_domain))))    ; Instantiate parameter domain in module vc_Queue @plab5-mcore-TestMem_uni.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Control memresp_domain))))    ; Instantiate parameter enq_val in module vc_Queue @plab5-mcore-TestMem_uni.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Control memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter enq_rdy in module vc_Queue @plab5-mcore-TestMem_uni.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter enq_msg in module vc_Queue @plab5-mcore-TestMem_uni.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Control memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter deq_val in module vc_Queue @plab5-mcore-TestMem_uni.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Control memresp_domain))))    ; Instantiate parameter deq_rdy in module vc_Queue @plab5-mcore-TestMem_uni.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter deq_msg in module vc_Queue @plab5-mcore-TestMem_uni.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; memresp_domain <= memreq_domain @plab5-mcore-TestMem_uni.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (join D1 (Domain memresp_domain))  (Domain memresp_domain))))    ; read_block_M = m_pub[physical_block_addr_M] @plab5-mcore-TestMem_uni.v:230
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain 1)  (not(leq (join D2 (Domain memresp_domain))  (Domain memresp_domain)))))    ; read_block_M = m_sec[physical_block_addr_M] @plab5-mcore-TestMem_uni.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; read_block_M = 'bxxxx @plab5-mcore-TestMem_uni.v:238
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; memory_cleared = 1 @plab5-mcore-TestMem_uni.v:280
(check-sat)
(pop)

