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
(declare-fun req_domain () Int)
(assert (<= 0  req_domain))
(assert (<= req_domain 1))
(declare-fun resp_domain () Int)
(assert (<= 0  resp_domain))
(assert (<= resp_domain 1))

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
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; assign mem_req_msg[(((((md)-(1))+($clog2((md)/(8))))+(a))+(o))+(3):(((((md)-(1))+($clog2((md)/(8))))+(a))+(o))+(1)] = proc_req_msg[(((((pd)-(1))+($clog2((pd)/(8))))+(a))+(o))+(3):(((((pd)-(1))+($clog2((pd)/(8))))+(a))+(o))+(1)] @plab5-mcore-proc2mem-trans.v:46
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; assign mem_req_msg[((((md)-(1))+($clog2((md)/(8))))+(a))+(o):((((md)-(1))+($clog2((md)/(8))))+(a))+(1)] = proc_req_msg[((((pd)-(1))+($clog2((pd)/(8))))+(a))+(o):((((pd)-(1))+($clog2((pd)/(8))))+(a))+(1)] @plab5-mcore-proc2mem-trans.v:49
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; assign mem_req_msg[(((md)-(1))+($clog2((md)/(8))))+(a):(((md)-(1))+($clog2((md)/(8))))+(1)] = proc_req_msg[(((pd)-(1))+($clog2((pd)/(8))))+(a):(((pd)-(1))+($clog2((pd)/(8))))+(1)] @plab5-mcore-proc2mem-trans.v:52
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; assign mem_req_msg[((md)-(1))+($clog2((md)/(8))):((md)-(1))+(1)] = proc_req_msg[((pd)-(1))+($clog2((pd)/(8))):((pd)-(1))+(1)] @plab5-mcore-proc2mem-trans.v:55
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; mem_req_msg[(md)-(1):0] = 'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 @plab5-mcore-proc2mem-trans.v:59
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; mem_req_msg[(md)-(1):0] = {'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx, proc_req_msg[(pd)-(1):0]} @plab5-mcore-proc2mem-trans.v:59
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain resp_domain)  (Domain resp_domain))))    ; assign proc_resp_msg[((((pd)-(1))+($clog2((pd)/(8))))+(o))+(3):((((pd)-(1))+($clog2((pd)/(8))))+(o))+(1)] = mem_resp_msg[((((md)-(1))+($clog2((md)/(8))))+(o))+(3):((((md)-(1))+($clog2((md)/(8))))+(o))+(1)] @plab5-mcore-proc2mem-trans.v:63
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain resp_domain)  (Domain resp_domain))))    ; assign proc_resp_msg[(((pd)-(1))+($clog2((pd)/(8))))+(o):(((pd)-(1))+($clog2((pd)/(8))))+(1)] = mem_resp_msg[(((md)-(1))+($clog2((md)/(8))))+(o):(((md)-(1))+($clog2((md)/(8))))+(1)] @plab5-mcore-proc2mem-trans.v:66
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain resp_domain))))    ; assign proc_resp_msg[((pd)-(1))+($clog2((pd)/(8))):((pd)-(1))+(1)] = 0 @plab5-mcore-proc2mem-trans.v:69
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain resp_domain)  (Domain resp_domain))))    ; assign proc_resp_msg[(pd)-(1):0] = mem_resp_msg[(pd)-(1):0] @plab5-mcore-proc2mem-trans.v:71
(check-sat)
(pop)

