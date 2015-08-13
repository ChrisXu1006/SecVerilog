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
(assert  (not(leq (Domain domain)  (Control domain))))    ; assign mem_addr = mem_msg[(((md)-(1))+($clog2((md)/(8))))+(ma):(((md)-(1))+($clog2((md)/(8))))+(1)] @plab5-mcore-mem-net-req.v:92
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Control domain))))    ; net_dest = 0 @plab5-mcore-mem-net-req.v:95
(check-sat)
(pop)


(push)
(assert  (not(leq (Control domain)  (Control domain))))    ; net_dest = 0 @plab5-mcore-mem-net-req.v:96
(check-sat)
(pop)


(push)
(assert  (not(leq (Control domain)  (Control domain))))    ; net_dest = 1 @plab5-mcore-mem-net-req.v:96
(check-sat)
(pop)


(push)
(assert  (not(leq (Control domain)  (Control domain))))    ; net_dest = 0 @plab5-mcore-mem-net-req.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Control domain)  (Control domain))))    ; net_dest = 1 @plab5-mcore-mem-net-req.v:97
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Control domain))))    ; assign mem_msg_opaque = mem_msg[((((md)-(1))+($clog2((md)/(8))))+(ma))+(mo):((((md)-(1))+($clog2((md)/(8))))+(ma))+(1)] @plab5-mcore-mem-net-req.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Control domain)  (Control domain))))    ; assign mem_src_opaque = {p_net_src[(ns)-(1):0], mem_msg_opaque[((mo)-(ns))-(1):0]} @plab5-mcore-mem-net-req.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab5_mcore_MemReqCMsgPack @plab5-mcore-mem-net-req.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter type in module plab5_mcore_MemReqCMsgPack @plab5-mcore-mem-net-req.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Control domain)  (Domain domain))))    ; Instantiate parameter opaque in module plab5_mcore_MemReqCMsgPack @plab5-mcore-mem-net-req.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter addr in module plab5_mcore_MemReqCMsgPack @plab5-mcore-mem-net-req.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter len in module plab5_mcore_MemReqCMsgPack @plab5-mcore-mem-net-req.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Control domain))))    ; Instantiate parameter msg in module plab5_mcore_MemReqCMsgPack @plab5-mcore-mem-net-req.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign net_payload_data = mem_msg[(md)-(1):0] @plab5-mcore-mem-net-req.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; req_domain = 0 @plab5-mcore-mem-net-req.v:128
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; req_domain = 1 @plab5-mcore-mem-net-req.v:128
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain domain)  (Domain domain))))    ; assign net_msg_data = net_payload_data @plab5-mcore-mem-net-req.v:148
(check-sat)
(pop)

