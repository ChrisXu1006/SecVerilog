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
PTask ignored

(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign in_go = and (cachereq_val) (cachereq_rdy) @plab3-mem-PrefetchBufferCtrl.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign out_go = and (cacheresp_val) (cacheresp_rdy) @plab3-mem-PrefetchBufferCtrl.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign hit_0 = and (is_valid_0) (tag_match_0) @plab3-mem-PrefetchBufferCtrl.v:117
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign hit_1 = and (is_valid_1) (tag_match_1) @plab3-mem-PrefetchBufferCtrl.v:118
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign hit = or (hit_0) (hit_1) @plab3-mem-PrefetchBufferCtrl.v:119
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_read = = cachereq_type 0 @plab3-mem-PrefetchBufferCtrl.v:120
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_write = = cachereq_type 1 @plab3-mem-PrefetchBufferCtrl.v:121
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_init = = cachereq_type 7 @plab3-mem-PrefetchBufferCtrl.v:122
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_amo = not( = amo_sel 0) @plab3-mem-PrefetchBufferCtrl.v:123
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign read_hit = and (is_read) (hit) @plab3-mem-PrefetchBufferCtrl.v:124
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign write_hit = and (is_write) (hit) @plab3-mem-PrefetchBufferCtrl.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign amo_hit = and (is_amo) (hit) @plab3-mem-PrefetchBufferCtrl.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign miss_0 = !(hit_0) @plab3-mem-PrefetchBufferCtrl.v:127
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign miss_1 = !(hit_1) @plab3-mem-PrefetchBufferCtrl.v:128
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign refill = = cachereq_type 6 @plab3-mem-PrefetchBufferCtrl.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain domain) (Domain domain)) (Domain domain))  (Domain domain))))    ; assign evict = or (and (and (miss_0) (is_dirty_0)) (!(lru_way))) (and (and (miss_1) (is_dirty_1)) (lru_way)) @plab3-mem-PrefetchBufferCtrl.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_idx = cachereq_addr[(4)+(p_idx_shamt)+:3] @plab3-mem-PrefetchBufferCtrl.v:179
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign valid_bits_write_en_0 = and (valid_bits_write_en) (!(way_sel)) @plab3-mem-PrefetchBufferCtrl.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign valid_bits_write_en_1 = and (valid_bits_write_en) (way_sel) @plab3-mem-PrefetchBufferCtrl.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dirty_bits_write_en_0 = and (dirty_bits_write_en) (!(way_sel)) @plab3-mem-PrefetchBufferCtrl.v:211
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dirty_bits_write_en_1 = and (dirty_bits_write_en) (way_sel) @plab3-mem-PrefetchBufferCtrl.v:212
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_offset = cachereq_addr[3:2] @plab3-mem-PrefetchBufferCtrl.v:388
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module plab3_mem_DecoderWben @plab3-mem-PrefetchBufferCtrl.v:391
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module plab3_mem_DecoderWben @plab3-mem-PrefetchBufferCtrl.v:391
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign read_byte_sel = cachereq_offset @plab3-mem-PrefetchBufferCtrl.v:399
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; state_reg <= 0 @plab3-mem-PrefetchBufferCtrl.v:104
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_reg <= state_next @plab3-mem-PrefetchBufferCtrl.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = state_reg @plab3-mem-PrefetchBufferCtrl.v:137
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 1 @plab3-mem-PrefetchBufferCtrl.v:141
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 2 @plab3-mem-PrefetchBufferCtrl.v:144
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 5 @plab3-mem-PrefetchBufferCtrl.v:145
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 0 @plab3-mem-PrefetchBufferCtrl.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 4 @plab3-mem-PrefetchBufferCtrl.v:149
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 4 @plab3-mem-PrefetchBufferCtrl.v:152
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 4 @plab3-mem-PrefetchBufferCtrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 6 @plab3-mem-PrefetchBufferCtrl.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 5 @plab3-mem-PrefetchBufferCtrl.v:159
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 7 @plab3-mem-PrefetchBufferCtrl.v:162
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 6 @plab3-mem-PrefetchBufferCtrl.v:163
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 4 @plab3-mem-PrefetchBufferCtrl.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = 0 @plab3-mem-PrefetchBufferCtrl.v:169
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = 0 @plab3-mem-PrefetchBufferCtrl.v:264
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = 1 @plab3-mem-PrefetchBufferCtrl.v:265
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = 'bx @plab3-mem-PrefetchBufferCtrl.v:265
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = lru_way @plab3-mem-PrefetchBufferCtrl.v:268
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; lru_bit_in = !(way_sel) @plab3-mem-PrefetchBufferCtrl.v:372
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_0_wen = and (tag_array_wen) (!(way_sel)) @plab3-mem-PrefetchBufferCtrl.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_0_ren = tag_array_ren @plab3-mem-PrefetchBufferCtrl.v:379
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_1_wen = and (tag_array_wen) (way_sel) @plab3-mem-PrefetchBufferCtrl.v:380
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_1_ren = tag_array_ren @plab3-mem-PrefetchBufferCtrl.v:381
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; data_array_wben = 65535 @plab3-mem-PrefetchBufferCtrl.v:407
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; data_array_wben = wben_decoder_out @plab3-mem-PrefetchBufferCtrl.v:409
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; cacheresp_type = cachereq_type @plab3-mem-PrefetchBufferCtrl.v:413
(check-sat)
(pop)

