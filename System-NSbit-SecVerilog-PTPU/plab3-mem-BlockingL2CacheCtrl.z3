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
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign in_go = and (cachereq_val) (cachereq_rdy) @plab3-mem-BlockingL2CacheCtrl.v:118
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign out_go = and (cacheresp_val) (cacheresp_rdy) @plab3-mem-BlockingL2CacheCtrl.v:119
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign hit_0 = and (is_valid_0) (tag_match_0) @plab3-mem-BlockingL2CacheCtrl.v:120
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign hit_1 = and (is_valid_1) (tag_match_1) @plab3-mem-BlockingL2CacheCtrl.v:121
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign hit = or (hit_0) (hit_1) @plab3-mem-BlockingL2CacheCtrl.v:122
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_read = or (= cachereq_type 0) (= cachereq_type 6) @plab3-mem-BlockingL2CacheCtrl.v:123
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_write = = cachereq_type 1 @plab3-mem-BlockingL2CacheCtrl.v:124
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_init = = cachereq_type 7 @plab3-mem-BlockingL2CacheCtrl.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_amo = not( = amo_sel 0) @plab3-mem-BlockingL2CacheCtrl.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign read_hit = and (is_read) (hit) @plab3-mem-BlockingL2CacheCtrl.v:127
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign write_hit = and (is_write) (hit) @plab3-mem-BlockingL2CacheCtrl.v:128
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign amo_hit = and (is_amo) (hit) @plab3-mem-BlockingL2CacheCtrl.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign miss_0 = !(hit_0) @plab3-mem-BlockingL2CacheCtrl.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign miss_1 = !(hit_1) @plab3-mem-BlockingL2CacheCtrl.v:131
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain domain) (Domain domain)) (Domain domain))  (Domain domain))))    ; assign refill = or (and (and (miss_0) (!(is_dirty_0))) (!(lru_way))) (and (and (miss_1) (!(is_dirty_1))) (lru_way)) @plab3-mem-BlockingL2CacheCtrl.v:132
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain domain) (Domain domain)) (Domain domain))  (Domain domain))))    ; assign evict = or (and (and (miss_0) (is_dirty_0)) (!(lru_way))) (and (and (miss_1) (is_dirty_1)) (lru_way)) @plab3-mem-BlockingL2CacheCtrl.v:133
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_idx = cachereq_addr[(4)+(p_idx_shamt)+:5] @plab3-mem-BlockingL2CacheCtrl.v:204
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign valid_bits_write_en_0 = and (valid_bits_write_en) (!(way_sel)) @plab3-mem-BlockingL2CacheCtrl.v:207
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign valid_bits_write_en_1 = and (valid_bits_write_en) (way_sel) @plab3-mem-BlockingL2CacheCtrl.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dirty_bits_write_en_0 = and (dirty_bits_write_en) (!(way_sel)) @plab3-mem-BlockingL2CacheCtrl.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dirty_bits_write_en_1 = and (dirty_bits_write_en) (way_sel) @plab3-mem-BlockingL2CacheCtrl.v:237
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_offset = cachereq_addr[3:2] @plab3-mem-BlockingL2CacheCtrl.v:417
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab3_mem_DecoderWben @plab3-mem-BlockingL2CacheCtrl.v:420
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module plab3_mem_DecoderWben @plab3-mem-BlockingL2CacheCtrl.v:420
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module plab3_mem_DecoderWben @plab3-mem-BlockingL2CacheCtrl.v:420
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign read_byte_sel = cachereq_offset @plab3-mem-BlockingL2CacheCtrl.v:429
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; state_reg <= STATE_IDLE @plab3-mem-BlockingL2CacheCtrl.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_reg <= state_next @plab3-mem-BlockingL2CacheCtrl.v:110
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = state_reg @plab3-mem-BlockingL2CacheCtrl.v:140
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_TAG_CHECK @plab3-mem-BlockingL2CacheCtrl.v:144
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_INIT_DATA_ACCESS @plab3-mem-BlockingL2CacheCtrl.v:147
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_READ_DATA_ACCESS @plab3-mem-BlockingL2CacheCtrl.v:148
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WRITE_DATA_ACCESS @plab3-mem-BlockingL2CacheCtrl.v:149
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_AMO_READ_DATA_ACCESS @plab3-mem-BlockingL2CacheCtrl.v:150
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_REFILL_REQUEST @plab3-mem-BlockingL2CacheCtrl.v:151
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EVICT_PREPARE @plab3-mem-BlockingL2CacheCtrl.v:152
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL2CacheCtrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL2CacheCtrl.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL2CacheCtrl.v:161
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_AMO_WRITE_DATA_ACCESS @plab3-mem-BlockingL2CacheCtrl.v:164
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL2CacheCtrl.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_REFILL_WAIT @plab3-mem-BlockingL2CacheCtrl.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_REFILL_REQUEST @plab3-mem-BlockingL2CacheCtrl.v:171
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_REFILL_UPDATE @plab3-mem-BlockingL2CacheCtrl.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_REFILL_WAIT @plab3-mem-BlockingL2CacheCtrl.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_READ_DATA_ACCESS @plab3-mem-BlockingL2CacheCtrl.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WRITE_DATA_ACCESS @plab3-mem-BlockingL2CacheCtrl.v:179
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_AMO_READ_DATA_ACCESS @plab3-mem-BlockingL2CacheCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EVICT_REQUEST @plab3-mem-BlockingL2CacheCtrl.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EVICT_WAIT @plab3-mem-BlockingL2CacheCtrl.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EVICT_REQUEST @plab3-mem-BlockingL2CacheCtrl.v:187
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_REFILL_REQUEST @plab3-mem-BlockingL2CacheCtrl.v:190
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EVICT_WAIT @plab3-mem-BlockingL2CacheCtrl.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_IDLE @plab3-mem-BlockingL2CacheCtrl.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = 0 @plab3-mem-BlockingL2CacheCtrl.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = 1 @plab3-mem-BlockingL2CacheCtrl.v:290
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = 'bx @plab3-mem-BlockingL2CacheCtrl.v:290
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = lru_way @plab3-mem-BlockingL2CacheCtrl.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; lru_bit_in = !(way_sel) @plab3-mem-BlockingL2CacheCtrl.v:401
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_0_wen = and (tag_array_wen) (!(way_sel)) @plab3-mem-BlockingL2CacheCtrl.v:407
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_0_ren = tag_array_ren @plab3-mem-BlockingL2CacheCtrl.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_1_wen = and (tag_array_wen) (way_sel) @plab3-mem-BlockingL2CacheCtrl.v:409
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_1_ren = tag_array_ren @plab3-mem-BlockingL2CacheCtrl.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; amo_sel = 1 @plab3-mem-BlockingL2CacheCtrl.v:435
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; amo_sel = 2 @plab3-mem-BlockingL2CacheCtrl.v:436
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; amo_sel = 3 @plab3-mem-BlockingL2CacheCtrl.v:437
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; amo_sel = 0 @plab3-mem-BlockingL2CacheCtrl.v:438
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; data_array_wben = 65535 @plab3-mem-BlockingL2CacheCtrl.v:448
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; data_array_wben = wben_decoder_out @plab3-mem-BlockingL2CacheCtrl.v:450
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; cacheresp_type = cachereq_type @plab3-mem-BlockingL2CacheCtrl.v:454
(check-sat)
(pop)

