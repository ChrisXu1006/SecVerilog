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
PTask ignored

(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign in_go = and (cachereq_val) (cachereq_rdy) @plab3-mem-BlockingL1CacheCtrl.v:122
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign out_go = and (cacheresp_val) (cacheresp_rdy) @plab3-mem-BlockingL1CacheCtrl.v:123
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign hit_0 = and (is_valid_0) (tag_match_0) @plab3-mem-BlockingL1CacheCtrl.v:124
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign hit_1 = and (is_valid_1) (tag_match_1) @plab3-mem-BlockingL1CacheCtrl.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign hit = or (hit_0) (hit_1) @plab3-mem-BlockingL1CacheCtrl.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_read = = cachereq_type 0 @plab3-mem-BlockingL1CacheCtrl.v:127
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_write = = cachereq_type 1 @plab3-mem-BlockingL1CacheCtrl.v:128
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_init = = cachereq_type 7 @plab3-mem-BlockingL1CacheCtrl.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign is_amo = not( = amo_sel 0) @plab3-mem-BlockingL1CacheCtrl.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign read_hit = and (is_read) (hit) @plab3-mem-BlockingL1CacheCtrl.v:131
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign write_hit = and (is_write) (hit) @plab3-mem-BlockingL1CacheCtrl.v:132
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign amo_hit = and (is_amo) (hit) @plab3-mem-BlockingL1CacheCtrl.v:133
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign miss_0 = !(hit_0) @plab3-mem-BlockingL1CacheCtrl.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign miss_1 = !(hit_1) @plab3-mem-BlockingL1CacheCtrl.v:135
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain domain) (Domain domain)) (Domain domain))  (Domain domain))))    ; assign refill = or (and (and (miss_0) (!(is_dirty_0))) (!(lru_way))) (and (and (miss_1) (!(is_dirty_1))) (lru_way)) @plab3-mem-BlockingL1CacheCtrl.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain domain) (Domain domain)) (Domain domain))  (Domain domain))))    ; assign evict = or (and (and (miss_0) (is_dirty_0)) (!(lru_way))) (and (and (miss_1) (is_dirty_1)) (lru_way)) @plab3-mem-BlockingL1CacheCtrl.v:137
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_idx = cachereq_addr[(4)+(p_idx_shamt)+:3] @plab3-mem-BlockingL1CacheCtrl.v:230
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign valid_bits_write_en_0 = and (valid_bits_write_en) (!(way_sel)) @plab3-mem-BlockingL1CacheCtrl.v:233
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign valid_bits_write_en_1 = and (valid_bits_write_en) (way_sel) @plab3-mem-BlockingL1CacheCtrl.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dirty_bits_write_en_0 = and (dirty_bits_write_en) (!(way_sel)) @plab3-mem-BlockingL1CacheCtrl.v:262
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign dirty_bits_write_en_1 = and (dirty_bits_write_en) (way_sel) @plab3-mem-BlockingL1CacheCtrl.v:263
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign cachereq_offset = cachereq_addr[3:2] @plab3-mem-BlockingL1CacheCtrl.v:452
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab3_mem_DecoderWben @plab3-mem-BlockingL1CacheCtrl.v:455
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter in in module plab3_mem_DecoderWben @plab3-mem-BlockingL1CacheCtrl.v:455
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter out in module plab3_mem_DecoderWben @plab3-mem-BlockingL1CacheCtrl.v:455
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign read_byte_sel = cachereq_offset @plab3-mem-BlockingL1CacheCtrl.v:464
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain domain))))    ; state_reg <= STATE_IDLE @plab3-mem-BlockingL1CacheCtrl.v:111
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_reg <= state_next @plab3-mem-BlockingL1CacheCtrl.v:114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = state_reg @plab3-mem-BlockingL1CacheCtrl.v:144
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_TAG_CHECK @plab3-mem-BlockingL1CacheCtrl.v:148
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_SPEC_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:152
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_PRELW_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:154
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_DIRMEM_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_INIT_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_READ_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:159
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WRITE_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_AMO_READ_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:161
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_REFILL_REQUEST @plab3-mem-BlockingL1CacheCtrl.v:162
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EVICT_PREPARE @plab3-mem-BlockingL1CacheCtrl.v:163
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL1CacheCtrl.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL1CacheCtrl.v:169
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL1CacheCtrl.v:172
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_AMO_WRITE_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL1CacheCtrl.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_REFILL_WAIT @plab3-mem-BlockingL1CacheCtrl.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_REFILL_REQUEST @plab3-mem-BlockingL1CacheCtrl.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain domain) (Domain domain)) (Domain domain))  (Domain domain))))    ; state_next = STATE_EMPTY_RESP @plab3-mem-BlockingL1CacheCtrl.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Domain domain) (join (join (Domain domain) (Domain domain)) (Domain domain)))  (Domain domain))))    ; state_next = STATE_REFILL_UPDATE @plab3-mem-BlockingL1CacheCtrl.v:187
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Domain domain) (join (Domain domain) (join (join (Domain domain) (Domain domain)) (Domain domain))))  (Domain domain))))    ; state_next = STATE_REFILL_WAIT @plab3-mem-BlockingL1CacheCtrl.v:188
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_READ_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WRITE_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:192
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_AMO_READ_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:193
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EVICT_REQUEST @plab3-mem-BlockingL1CacheCtrl.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EVICT_WAIT @plab3-mem-BlockingL1CacheCtrl.v:199
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EVICT_REQUEST @plab3-mem-BlockingL1CacheCtrl.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_REFILL_REQUEST @plab3-mem-BlockingL1CacheCtrl.v:203
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EVICT_WAIT @plab3-mem-BlockingL1CacheCtrl.v:204
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EMPTY_RESP @plab3-mem-BlockingL1CacheCtrl.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL1CacheCtrl.v:211
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EMPTY_RESP @plab3-mem-BlockingL1CacheCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_EMPTY_RESP @plab3-mem-BlockingL1CacheCtrl.v:217
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; state_next = STATE_IDLE @plab3-mem-BlockingL1CacheCtrl.v:220
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = 0 @plab3-mem-BlockingL1CacheCtrl.v:318
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = 1 @plab3-mem-BlockingL1CacheCtrl.v:319
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = 'bx @plab3-mem-BlockingL1CacheCtrl.v:319
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; way_record_in = lru_way @plab3-mem-BlockingL1CacheCtrl.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; lru_bit_in = !(way_sel) @plab3-mem-BlockingL1CacheCtrl.v:436
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_0_wen = and (tag_array_wen) (!(way_sel)) @plab3-mem-BlockingL1CacheCtrl.v:442
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_0_ren = tag_array_ren @plab3-mem-BlockingL1CacheCtrl.v:443
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_1_wen = and (tag_array_wen) (way_sel) @plab3-mem-BlockingL1CacheCtrl.v:444
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; tag_array_1_ren = tag_array_ren @plab3-mem-BlockingL1CacheCtrl.v:445
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; amo_sel = 1 @plab3-mem-BlockingL1CacheCtrl.v:470
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; amo_sel = 2 @plab3-mem-BlockingL1CacheCtrl.v:471
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; amo_sel = 3 @plab3-mem-BlockingL1CacheCtrl.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; amo_sel = 0 @plab3-mem-BlockingL1CacheCtrl.v:473
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; data_array_wben = 65535 @plab3-mem-BlockingL1CacheCtrl.v:483
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; data_array_wben = wben_decoder_out @plab3-mem-BlockingL1CacheCtrl.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; cacheresp_type = cachereq_type @plab3-mem-BlockingL1CacheCtrl.v:489
(check-sat)
(pop)

