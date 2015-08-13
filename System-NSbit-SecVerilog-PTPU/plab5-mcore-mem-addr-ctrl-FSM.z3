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
(declare-fun cur_domain () Int)
(assert (<= 0  cur_domain))
(assert (<= cur_domain 1))
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(declare-fun req_sec_level () Int)
(assert (<= 0  req_sec_level))
(assert (<= req_sec_level 1))
(declare-fun resp_sec_level () Int)
(assert (<= 0  resp_sec_level))
(assert (<= resp_sec_level 1))

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
(assert  (not(leq LOW  (Domain cur_domain))))    ; state_reg <= 0 @plab5-mcore-mem-addr-ctrl-FSM.v:90
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_reg <= state_next @plab5-mcore-mem-addr-ctrl-FSM.v:93
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = state_reg @plab5-mcore-mem-addr-ctrl-FSM.v:103
(check-sat)
(pop)


(push)
(assert (and (= req_sec_level cur_domain)  (not(leq (join (Domain req_sec_level) (Domain cur_domain))  (Domain cur_domain)))))    ; state_next = 1 @plab5-mcore-mem-addr-ctrl-FSM.v:108
(check-sat)
(pop)


(push)
(assert (and (= cur_domain 0)  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; state_next = 4 @plab5-mcore-mem-addr-ctrl-FSM.v:111
(check-sat)
(pop)


(push)
(assert (and (= cur_domain 1)  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; state_next = 5 @plab5-mcore-mem-addr-ctrl-FSM.v:113
(check-sat)
(pop)


(push)
(assert (and (= cur_domain 1)  (not(leq (Domain cur_domain)  (Domain cur_domain)))))    ; state_next = 2 @plab5-mcore-mem-addr-ctrl-FSM.v:115
(check-sat)
(pop)


(push)
(assert (and (not(= cur_domain 1)) (= cur_domain 0)  (not(leq (join (join (Domain cur_domain) D2) (Domain cur_domain))  (Domain cur_domain)))))    ; state_next = 2 @plab5-mcore-mem-addr-ctrl-FSM.v:117
(check-sat)
(pop)


(push)
(assert (and (not(= cur_domain 1)) (= cur_domain 0)  (not(leq (join (join (Domain cur_domain) D2) (join (join (Domain cur_domain) D2) (Domain cur_domain)))  (Domain cur_domain)))))    ; state_next = 4 @plab5-mcore-mem-addr-ctrl-FSM.v:119
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = 3 @plab5-mcore-mem-addr-ctrl-FSM.v:122
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:128
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain cur_domain)  (Domain cur_domain))))    ; state_next = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:131
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  D2)))    ; par_ctrl_reg <= initial_par @plab5-mcore-mem-addr-ctrl-FSM.v:151
(check-sat)
(pop)


(push)
(assert (and (= cur_domain req_sec_level)  (not(leq (join (Domain req_sec_level) (join (Domain cur_domain) (Domain req_sec_level)))  (Domain cur_domain)))))    ; req_addr <= cache2mem_req_control[(p_addr_nbits)+(4):4] @plab5-mcore-mem-addr-ctrl-FSM.v:158
(check-sat)
(pop)


(push)
(assert (and (= cur_domain req_sec_level)  (not(leq (join (Domain cur_domain) (Domain req_sec_level))  LOW))))    ; cur_domain <= req_sec_level @plab5-mcore-mem-addr-ctrl-FSM.v:159
(check-sat)
(pop)


(push)
(assert (and (= cur_domain req_sec_level)  (not(leq (join (Domain req_sec_level) (join (Domain cur_domain) (Domain req_sec_level)))  (Domain cur_domain)))))    ; req_control <= cache2mem_req_control @plab5-mcore-mem-addr-ctrl-FSM.v:160
(check-sat)
(pop)


(push)
(assert (and (= cur_domain req_sec_level)  (not(leq (join (Domain req_sec_level) (join (Domain cur_domain) (Domain req_sec_level)))  (Domain cur_domain)))))    ; req_data <= cache2mem_req_data @plab5-mcore-mem-addr-ctrl-FSM.v:161
(check-sat)
(pop)


(push)
(assert (and (= cur_domain req_sec_level)  (not(leq (join (Domain req_sec_level) (join (Domain cur_domain) (Domain req_sec_level)))  (Domain cur_domain)))))    ; mem2cache_resp_control_dump <= {cache2mem_req_control[45:42], cache2mem_req_control[41:34], cache2mem_req_control[1:0]} @plab5-mcore-mem-addr-ctrl-FSM.v:162
(check-sat)
(pop)


(push)
(assert (and (= cur_domain req_sec_level)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (Domain req_sec_level)))  (Domain cur_domain)))))    ; req_addr <= req_addr @plab5-mcore-mem-addr-ctrl-FSM.v:168
(check-sat)
(pop)


(push)
(assert (and (= cur_domain req_sec_level)  (not(leq (join (Domain cur_domain) (Domain req_sec_level))  LOW))))    ; cur_domain <= cur_domain @plab5-mcore-mem-addr-ctrl-FSM.v:169
(check-sat)
(pop)


(push)
(assert (and (= cur_domain req_sec_level)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (Domain req_sec_level)))  (Domain cur_domain)))))    ; req_control <= req_control @plab5-mcore-mem-addr-ctrl-FSM.v:170
(check-sat)
(pop)


(push)
(assert (and (= cur_domain req_sec_level)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (Domain req_sec_level)))  (Domain cur_domain)))))    ; req_data <= req_data @plab5-mcore-mem-addr-ctrl-FSM.v:171
(check-sat)
(pop)


(push)
(assert (and (= cur_domain req_sec_level)  (not(leq (join (Domain cur_domain) (join (Domain cur_domain) (Domain req_sec_level)))  (Domain cur_domain)))))    ; mem2cache_resp_control_dump <= mem2cache_resp_control_dump @plab5-mcore-mem-addr-ctrl-FSM.v:172
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; resp_sec_level = cur_domain @plab5-mcore-mem-addr-ctrl-FSM.v:178
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain)  (not(leq LOW  (Domain resp_sec_level)))))    ; insecure = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:179
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain)  (not(leq LOW  (Domain req_sec_level)))))    ; cache2mem_req_rdy = 1 @plab5-mcore-mem-addr-ctrl-FSM.v:180
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain)  (not(leq LOW  (Domain mem_req_domain)))))    ; mem_req_control = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:181
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain)  (not(leq LOW  (Domain mem_req_domain)))))    ; mem_req_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:182
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain)  (not(leq LOW  (Domain mem_req_domain)))))    ; mem_req_val = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:183
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain)  (not(leq LOW  (Domain resp_sec_level)))))    ; mem2cache_resp_control = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:184
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain)  (not(leq LOW  (Domain resp_sec_level)))))    ; mem2cache_resp_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:185
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain)  (not(leq LOW  (Domain resp_sec_level)))))    ; mem2cache_resp_val = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:186
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain)  (not(leq LOW  (Domain mem_resp_domain)))))    ; mem_resp_rdy = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:187
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain req_sec_level)))))    ; cache2mem_req_rdy = 1 @plab5-mcore-mem-addr-ctrl-FSM.v:193
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_control = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:194
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:195
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_val = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:196
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_control = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:197
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:198
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_val = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:199
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_resp_domain)))))    ; mem_resp_rdy = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:200
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain req_sec_level)))))    ; cache2mem_req_rdy = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:206
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_control = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:207
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:208
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_val = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:209
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_control = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:210
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:211
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_val = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:212
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_resp_domain)))))    ; mem_resp_rdy = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:213
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain req_sec_level)))))    ; cache2mem_req_rdy = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:219
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_control = req_control @plab5-mcore-mem-addr-ctrl-FSM.v:220
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_data = req_data @plab5-mcore-mem-addr-ctrl-FSM.v:221
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_val = 1 @plab5-mcore-mem-addr-ctrl-FSM.v:222
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_control = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:223
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:224
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_val = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:225
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_resp_domain)))))    ; mem_resp_rdy = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:226
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; insecure = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:232
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain req_sec_level)))))    ; cache2mem_req_rdy = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:233
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_control = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:234
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:235
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_val = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:236
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (join (Domain mem_resp_domain) (Domain cur_domain))  (Domain resp_sec_level)))))    ; mem2cache_resp_control = mem_resp_control @plab5-mcore-mem-addr-ctrl-FSM.v:237
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (join (Domain mem_resp_domain) (Domain cur_domain))  (Domain resp_sec_level)))))    ; mem2cache_resp_data = mem_resp_data @plab5-mcore-mem-addr-ctrl-FSM.v:238
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (join (Domain mem_resp_domain) (Domain cur_domain))  (Domain resp_sec_level)))))    ; mem2cache_resp_val = mem_resp_val @plab5-mcore-mem-addr-ctrl-FSM.v:239
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (join (Domain resp_sec_level) (Domain cur_domain))  (Domain mem_resp_domain)))))    ; mem_resp_rdy = mem2cache_resp_rdy @plab5-mcore-mem-addr-ctrl-FSM.v:240
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; insecure = 1 @plab5-mcore-mem-addr-ctrl-FSM.v:246
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain req_sec_level)))))    ; cache2mem_req_rdy = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:247
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_control = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:248
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:249
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_val = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:250
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_control = mem2cache_resp_control_dump @plab5-mcore-mem-addr-ctrl-FSM.v:251
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:252
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_val = 1 @plab5-mcore-mem-addr-ctrl-FSM.v:253
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_resp_domain)))))    ; mem_resp_rdy = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:254
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain req_sec_level)))))    ; cache2mem_req_rdy = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:260
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_control = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:261
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:262
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_req_domain)))))    ; mem_req_val = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:263
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_control = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:264
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_data = 'bxxxx @plab5-mcore-mem-addr-ctrl-FSM.v:265
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain resp_sec_level)))))    ; mem2cache_resp_val = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:266
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  (Domain mem_resp_domain)))))    ; mem_resp_rdy = 0 @plab5-mcore-mem-addr-ctrl-FSM.v:267
(check-sat)
(pop)


(push)
(assert (and (= resp_sec_level cur_domain) (and (and (and (= req_sec_level cur_domain) (= resp_sec_level cur_domain)) (= mem_req_domain cur_domain)) (= mem_resp_domain cur_domain))  (not(leq (Domain cur_domain)  D2))))    ; par_ctrl_reg = req_data @plab5-mcore-mem-addr-ctrl-FSM.v:268
(check-sat)
(pop)

