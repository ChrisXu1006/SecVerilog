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
PTask ignored

(push)
(assert  (not(leq (Domain cachereq_domain)  (Domain cachereq_domain))))    ; assign in_go = and (cachereq_val) (cachereq_rdy) @plab3-mem-BlockingL1CacheCtrl.v:133
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cacheresp_domain)  (Domain cacheresp_domain))))    ; assign out_go = and (cacheresp_val) (cacheresp_rdy) @plab3-mem-BlockingL1CacheCtrl.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign sec_0 = nsb_match_0 @plab3-mem-BlockingL1CacheCtrl.v:135
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign sec_1 = nsb_match_1 @plab3-mem-BlockingL1CacheCtrl.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign hit_0 = and (is_valid_0) (tag_match_0) @plab3-mem-BlockingL1CacheCtrl.v:137
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign hit_1 = and (is_valid_1) (tag_match_1) @plab3-mem-BlockingL1CacheCtrl.v:138
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign hit = or (and (hit_0) (sec_0)) (and (hit_1) (sec_1)) @plab3-mem-BlockingL1CacheCtrl.v:139
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign fake_hit_0 = and (hit_0) (!(sec_0)) @plab3-mem-BlockingL1CacheCtrl.v:140
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign fake_hit_1 = and (hit_1) (!(sec_1)) @plab3-mem-BlockingL1CacheCtrl.v:141
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign fake_hit = or (fake_hit_0) (fake_hit_1) @plab3-mem-BlockingL1CacheCtrl.v:142
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign is_read = = cachereq_type 0 @plab3-mem-BlockingL1CacheCtrl.v:143
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign is_write = = cachereq_type 1 @plab3-mem-BlockingL1CacheCtrl.v:144
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign is_init = = cachereq_type 7 @plab3-mem-BlockingL1CacheCtrl.v:145
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign is_amo = not( = amo_sel 0) @plab3-mem-BlockingL1CacheCtrl.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign read_hit = and (is_read) (hit) @plab3-mem-BlockingL1CacheCtrl.v:147
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign write_hit = and (is_write) (hit) @plab3-mem-BlockingL1CacheCtrl.v:148
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign amo_hit = and (is_amo) (hit) @plab3-mem-BlockingL1CacheCtrl.v:149
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign miss_0 = !(hit_0) @plab3-mem-BlockingL1CacheCtrl.v:150
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign miss_1 = !(hit_1) @plab3-mem-BlockingL1CacheCtrl.v:151
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain cachereq_nsbit) (Domain cachereq_nsbit)) (Domain cachereq_nsbit))  (Domain cachereq_nsbit))))    ; assign refill = or (and (and (miss_0) (!(is_dirty_0))) (!(lru_way))) (and (and (miss_1) (!(is_dirty_1))) (lru_way)) @plab3-mem-BlockingL1CacheCtrl.v:152
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Domain cachereq_nsbit) (Domain cachereq_nsbit)) (Domain cachereq_nsbit))  (Domain cachereq_nsbit))))    ; assign evict = or (and (and (miss_0) (is_dirty_0)) (!(lru_way))) (and (and (miss_1) (is_dirty_1)) (lru_way)) @plab3-mem-BlockingL1CacheCtrl.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign cachereq_idx = cachereq_addr[(4)+(p_idx_shamt)+:3] @plab3-mem-BlockingL1CacheCtrl.v:255
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign valid_bits_write_en_0 = and (valid_bits_write_en) (!(way_sel)) @plab3-mem-BlockingL1CacheCtrl.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign valid_bits_write_en_1 = and (valid_bits_write_en) (way_sel) @plab3-mem-BlockingL1CacheCtrl.v:259
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign dirty_bits_write_en_0 = and (dirty_bits_write_en) (!(way_sel)) @plab3-mem-BlockingL1CacheCtrl.v:287
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign dirty_bits_write_en_1 = and (dirty_bits_write_en) (way_sel) @plab3-mem-BlockingL1CacheCtrl.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign cachereq_offset = cachereq_addr[3:2] @plab3-mem-BlockingL1CacheCtrl.v:489
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab3_mem_DecoderWben @plab3-mem-BlockingL1CacheCtrl.v:492
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter in in module plab3_mem_DecoderWben @plab3-mem-BlockingL1CacheCtrl.v:492
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; Instantiate parameter out in module plab3_mem_DecoderWben @plab3-mem-BlockingL1CacheCtrl.v:492
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; assign read_byte_sel = cachereq_offset @plab3-mem-BlockingL1CacheCtrl.v:501
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain cachereq_nsbit))))    ; state_reg <= STATE_IDLE @plab3-mem-BlockingL1CacheCtrl.v:122
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_reg <= state_next @plab3-mem-BlockingL1CacheCtrl.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = state_reg @plab3-mem-BlockingL1CacheCtrl.v:160
(check-sat)
(pop)


(push)
(assert (and (= cachereq_nsbit cachereq_domain)  (not(leq (join (Domain cachereq_domain) (Domain cachereq_nsbit))  (Domain cachereq_nsbit)))))    ; state_next = STATE_TAG_CHECK @plab3-mem-BlockingL1CacheCtrl.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_SPEC_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:169
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_PRELW_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:171
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_DIRMEM_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:173
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_INIT_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_EMPTY_RESP @plab3-mem-BlockingL1CacheCtrl.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_READ_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_WRITE_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_AMO_READ_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_REFILL_REQUEST @plab3-mem-BlockingL1CacheCtrl.v:179
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_EVICT_PREPARE @plab3-mem-BlockingL1CacheCtrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL1CacheCtrl.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL1CacheCtrl.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL1CacheCtrl.v:189
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_AMO_WRITE_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:192
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL1CacheCtrl.v:195
(check-sat)
(pop)


(push)
(assert (and (= memreq_domain cachereq_nsbit)  (not(leq (join (Domain memreq_domain) (Domain cachereq_nsbit))  (Domain cachereq_nsbit)))))    ; state_next = STATE_REFILL_WAIT @plab3-mem-BlockingL1CacheCtrl.v:199
(check-sat)
(pop)


(push)
(assert (and (= memreq_domain cachereq_nsbit)  (not(leq (join (Domain memreq_domain) (join (Domain memreq_domain) (Domain cachereq_nsbit)))  (Domain cachereq_nsbit)))))    ; state_next = STATE_REFILL_REQUEST @plab3-mem-BlockingL1CacheCtrl.v:201
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cachereq_nsbit)  (not(leq (join (Domain memresp_domain) (Domain cachereq_nsbit))  (Domain cachereq_nsbit)))))    ; state_next = STATE_EMPTY_RESP @plab3-mem-BlockingL1CacheCtrl.v:205
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cachereq_nsbit)  (not(leq (join (Domain memresp_domain) (join (Domain memresp_domain) (Domain cachereq_nsbit)))  (Domain cachereq_nsbit)))))    ; state_next = STATE_REFILL_UPDATE @plab3-mem-BlockingL1CacheCtrl.v:207
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cachereq_nsbit)  (not(leq (join (Domain memresp_domain) (join (Domain memresp_domain) (join (Domain memresp_domain) (Domain cachereq_nsbit))))  (Domain cachereq_nsbit)))))    ; state_next = STATE_REFILL_WAIT @plab3-mem-BlockingL1CacheCtrl.v:209
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_READ_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:212
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_WRITE_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:213
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_AMO_READ_DATA_ACCESS @plab3-mem-BlockingL1CacheCtrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_EVICT_REQUEST @plab3-mem-BlockingL1CacheCtrl.v:217
(check-sat)
(pop)


(push)
(assert (and (= memreq_domain cachereq_nsbit)  (not(leq (join (Domain memreq_domain) (Domain cachereq_nsbit))  (Domain cachereq_nsbit)))))    ; state_next = STATE_EVICT_WAIT @plab3-mem-BlockingL1CacheCtrl.v:221
(check-sat)
(pop)


(push)
(assert (and (= memreq_domain cachereq_nsbit)  (not(leq (join (Domain memreq_domain) (join (Domain memreq_domain) (Domain cachereq_nsbit)))  (Domain cachereq_nsbit)))))    ; state_next = STATE_EVICT_REQUEST @plab3-mem-BlockingL1CacheCtrl.v:223
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cachereq_nsbit)  (not(leq (join (Domain memresp_domain) (Domain cachereq_nsbit))  (Domain cachereq_nsbit)))))    ; state_next = STATE_REFILL_REQUEST @plab3-mem-BlockingL1CacheCtrl.v:227
(check-sat)
(pop)


(push)
(assert (and (= memresp_domain cachereq_nsbit)  (not(leq (join (Domain memresp_domain) (join (Domain memresp_domain) (Domain cachereq_nsbit)))  (Domain cachereq_nsbit)))))    ; state_next = STATE_EVICT_WAIT @plab3-mem-BlockingL1CacheCtrl.v:229
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_EMPTY_RESP @plab3-mem-BlockingL1CacheCtrl.v:232
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_WAIT @plab3-mem-BlockingL1CacheCtrl.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_EMPTY_RESP @plab3-mem-BlockingL1CacheCtrl.v:238
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; state_next = STATE_EMPTY_RESP @plab3-mem-BlockingL1CacheCtrl.v:241
(check-sat)
(pop)


(push)
(assert (and (= cacheresp_domain cachereq_nsbit)  (not(leq (join (Domain cacheresp_domain) (Domain cachereq_nsbit))  (Domain cachereq_nsbit)))))    ; state_next = STATE_IDLE @plab3-mem-BlockingL1CacheCtrl.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; way_record_in = 0 @plab3-mem-BlockingL1CacheCtrl.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; way_record_in = 1 @plab3-mem-BlockingL1CacheCtrl.v:341
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; way_record_in = 'bx @plab3-mem-BlockingL1CacheCtrl.v:341
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; way_record_in = lru_way @plab3-mem-BlockingL1CacheCtrl.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; lru_bit_in = !(way_sel) @plab3-mem-BlockingL1CacheCtrl.v:458
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; secure_mask = 0 @plab3-mem-BlockingL1CacheCtrl.v:466
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; secure_mask = 1 @plab3-mem-BlockingL1CacheCtrl.v:468
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; tag_array_0_wen = and (tag_array_wen) (!(way_sel)) @plab3-mem-BlockingL1CacheCtrl.v:474
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; tag_array_0_ren = tag_array_ren @plab3-mem-BlockingL1CacheCtrl.v:475
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; tag_array_1_wen = and (tag_array_wen) (way_sel) @plab3-mem-BlockingL1CacheCtrl.v:476
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; tag_array_1_ren = tag_array_ren @plab3-mem-BlockingL1CacheCtrl.v:477
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; nsb_array_0_wen = and (tag_array_wen) (!(way_sel)) @plab3-mem-BlockingL1CacheCtrl.v:478
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; nsb_array_0_ren = tag_array_ren @plab3-mem-BlockingL1CacheCtrl.v:479
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; nsb_array_1_wen = and (tag_array_wen) (way_sel) @plab3-mem-BlockingL1CacheCtrl.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; nsb_array_1_ren = tag_array_ren @plab3-mem-BlockingL1CacheCtrl.v:481
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; amo_sel = 1 @plab3-mem-BlockingL1CacheCtrl.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; amo_sel = 2 @plab3-mem-BlockingL1CacheCtrl.v:508
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; amo_sel = 3 @plab3-mem-BlockingL1CacheCtrl.v:509
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; amo_sel = 0 @plab3-mem-BlockingL1CacheCtrl.v:510
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; data_array_wben = 65535 @plab3-mem-BlockingL1CacheCtrl.v:520
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cachereq_nsbit)  (Domain cachereq_nsbit))))    ; data_array_wben = wben_decoder_out @plab3-mem-BlockingL1CacheCtrl.v:522
(check-sat)
(pop)


(push)
(assert (and (= cacheresp_domain cachereq_nsbit)  (not(leq (Domain cachereq_nsbit)  (Domain cacheresp_domain)))))    ; cacheresp_type = cachereq_type @plab3-mem-BlockingL1CacheCtrl.v:527
(check-sat)
(pop)

