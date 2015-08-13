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
(declare-fun data_cache2memreq0_domain () Int)
(assert (<= 0  data_cache2memreq0_domain))
(assert (<= data_cache2memreq0_domain 1))
(declare-fun data_cachereq0_domain () Int)
(assert (<= 0  data_cachereq0_domain))
(assert (<= data_cachereq0_domain 1))
(declare-fun data_cachereq1_domain () Int)
(assert (<= 0  data_cachereq1_domain))
(assert (<= data_cachereq1_domain 1))
(declare-fun data_cacheresp0_domain () Int)
(assert (<= 0  data_cacheresp0_domain))
(assert (<= data_cacheresp0_domain 1))
(declare-fun data_cacheresp1_domain () Int)
(assert (<= 0  data_cacheresp1_domain))
(assert (<= data_cacheresp1_domain 1))
(declare-fun data_mem2cacheresp0_domain () Int)
(assert (<= 0  data_mem2cacheresp0_domain))
(assert (<= data_mem2cacheresp0_domain 1))
(declare-fun data_memreq0_domain () Int)
(assert (<= 0  data_memreq0_domain))
(assert (<= data_memreq0_domain 1))
(declare-fun data_memresp0_domain () Int)
(assert (<= 0  data_memresp0_domain))
(assert (<= data_memresp0_domain 1))
(declare-fun data_net_resp_out_domain_d0 () Int)
(assert (<= 0  data_net_resp_out_domain_d0))
(assert (<= data_net_resp_out_domain_d0 1))
(declare-fun data_net_resp_out_domain_d1 () Int)
(assert (<= 0  data_net_resp_out_domain_d1))
(assert (<= data_net_resp_out_domain_d1 1))
(declare-fun inst_cache2memreq0_domain () Int)
(assert (<= 0  inst_cache2memreq0_domain))
(assert (<= inst_cache2memreq0_domain 1))
(declare-fun inst_cachereq0_domain () Int)
(assert (<= 0  inst_cachereq0_domain))
(assert (<= inst_cachereq0_domain 1))
(declare-fun inst_cachereq1_domain () Int)
(assert (<= 0  inst_cachereq1_domain))
(assert (<= inst_cachereq1_domain 1))
(declare-fun inst_cacheresp0_domain () Int)
(assert (<= 0  inst_cacheresp0_domain))
(assert (<= inst_cacheresp0_domain 1))
(declare-fun inst_cacheresp1_domain () Int)
(assert (<= 0  inst_cacheresp1_domain))
(assert (<= inst_cacheresp1_domain 1))
(declare-fun inst_mem2cacheresp0_domain () Int)
(assert (<= 0  inst_mem2cacheresp0_domain))
(assert (<= inst_mem2cacheresp0_domain 1))
(declare-fun inst_memreq0_domain () Int)
(assert (<= 0  inst_memreq0_domain))
(assert (<= inst_memreq0_domain 1))
(declare-fun inst_memresp0_domain () Int)
(assert (<= 0  inst_memresp0_domain))
(assert (<= inst_memresp0_domain 1))
(declare-fun inst_net_resp_out_domain_d0 () Int)
(assert (<= 0  inst_net_resp_out_domain_d0))
(assert (<= inst_net_resp_out_domain_d0 1))
(declare-fun inst_net_resp_out_domain_d1 () Int)
(assert (<= 0  inst_net_resp_out_domain_d1))
(assert (<= inst_net_resp_out_domain_d1 1))

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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sec_domain in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_domain in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter imemreq_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter imemreq_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter imemreq_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter imemresp_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter imemresp_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter imemresp_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter dmemreq_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter dmemreq_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter dmemreq_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter dmemresp_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter dmemresp_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter dmemresp_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter from_mngr_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter from_mngr_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter from_mngr_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter to_mngr_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter to_mngr_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter to_mngr_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter stats_en in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sec_domain in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_domain in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter imemreq_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter imemreq_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter imemreq_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter imemresp_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter imemresp_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter imemresp_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter dmemreq_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter dmemreq_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter dmemreq_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter dmemresp_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter dmemresp_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter dmemresp_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter from_mngr_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter from_mngr_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter from_mngr_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter to_mngr_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter to_mngr_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter to_mngr_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter stats_en in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMem.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter proc_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_net_resp_out_domain_d0)  (Control inst_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq (Control inst_net_resp_out_domain_d0)  (Domain inst_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_net_resp_out_domain_d0)  (Control inst_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter proc_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter proc_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter proc_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:347
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:347
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter proc_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:347
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_net_resp_out_domain_d1)  (Control inst_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:347
(check-sat)
(pop)


(push)
(assert  (not(leq (Control inst_net_resp_out_domain_d1)  (Domain inst_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:347
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_net_resp_out_domain_d1)  (Control inst_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:347
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter proc_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:347
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter proc_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:347
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter proc_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:347
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter proc_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_net_resp_out_domain_d0)  (Control data_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Control data_net_resp_out_domain_d0)  (Domain data_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_net_resp_out_domain_d0)  (Control data_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter proc_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter proc_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter proc_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:399
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:399
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter proc_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:399
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_net_resp_out_domain_d1)  (Control data_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:399
(check-sat)
(pop)


(push)
(assert  (not(leq (Control data_net_resp_out_domain_d1)  (Domain data_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:399
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_net_resp_out_domain_d1)  (Control data_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:399
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter proc_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:399
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter proc_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:399
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter proc_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMem.v:399
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain inst_cachereq1_domain))))    ; assign inst_cachereq1_rdy = 1 @plab5-mcore-ProcNetCacheMem.v:468
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain inst_cacheresp1_domain))))    ; assign inst_cacheresp1_val = 1 @plab5-mcore-ProcNetCacheMem.v:469
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain data_cachereq1_domain))))    ; assign data_cachereq1_rdy = 1 @plab5-mcore-ProcNetCacheMem.v:470
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain data_cacheresp1_domain))))    ; assign data_cacheresp1_val = 1 @plab5-mcore-ProcNetCacheMem.v:471
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_msg_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_in_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Control req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_msg_control_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_msg_data_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_out_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Control req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Control req_out_domain_p0))))    ; Instantiate parameter req_out_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp0_domain)  (Control inst_cacheresp0_domain))))    ; Instantiate parameter resp_in_msg_control_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp0_domain)  (Domain inst_cacheresp0_domain))))    ; Instantiate parameter resp_in_msg_data_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_in_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp0_domain)  (Control inst_cacheresp0_domain))))    ; Instantiate parameter resp_in_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Control inst_cacheresp0_domain)  (Domain inst_cacheresp0_domain))))    ; Instantiate parameter resp_in_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_msg_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_out_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Control resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Control resp_out_domain_p0))))    ; Instantiate parameter resp_out_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_msg_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_in_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Control req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_msg_control_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Domain req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_msg_data_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_out_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Control req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Domain req_out_domain_p1)  (Control req_out_domain_p1))))    ; Instantiate parameter req_out_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp1_domain)  (Control inst_cacheresp1_domain))))    ; Instantiate parameter resp_in_msg_control_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp1_domain)  (Domain inst_cacheresp1_domain))))    ; Instantiate parameter resp_in_msg_data_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_in_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp1_domain)  (Control inst_cacheresp1_domain))))    ; Instantiate parameter resp_in_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Control inst_cacheresp1_domain)  (Domain inst_cacheresp1_domain))))    ; Instantiate parameter resp_in_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Domain resp_out_domain_p1)  (Domain resp_out_domain_p1))))    ; Instantiate parameter resp_out_msg_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_out_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Control resp_out_domain_p1)  (Domain resp_out_domain_p1))))    ; Instantiate parameter resp_out_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Domain resp_out_domain_p1)  (Control resp_out_domain_p1))))    ; Instantiate parameter resp_out_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_msg_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_in_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Control req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_msg_control_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_msg_data_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_out_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Control req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Control req_out_domain_p0))))    ; Instantiate parameter req_out_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp0_domain)  (Control data_cacheresp0_domain))))    ; Instantiate parameter resp_in_msg_control_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp0_domain)  (Domain data_cacheresp0_domain))))    ; Instantiate parameter resp_in_msg_data_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_in_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp0_domain)  (Control data_cacheresp0_domain))))    ; Instantiate parameter resp_in_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq (Control data_cacheresp0_domain)  (Domain data_cacheresp0_domain))))    ; Instantiate parameter resp_in_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_msg_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_out_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Control resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Control resp_out_domain_p0))))    ; Instantiate parameter resp_out_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_msg_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_in_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Control req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_msg_control_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Domain req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_msg_data_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_out_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Control req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Domain req_out_domain_p1)  (Control req_out_domain_p1))))    ; Instantiate parameter req_out_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp1_domain)  (Control data_cacheresp1_domain))))    ; Instantiate parameter resp_in_msg_control_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp1_domain)  (Domain data_cacheresp1_domain))))    ; Instantiate parameter resp_in_msg_data_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_in_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp1_domain)  (Control data_cacheresp1_domain))))    ; Instantiate parameter resp_in_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq (Control data_cacheresp1_domain)  (Domain data_cacheresp1_domain))))    ; Instantiate parameter resp_in_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Domain resp_out_domain_p1)  (Domain resp_out_domain_p1))))    ; Instantiate parameter resp_out_msg_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_out_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Control resp_out_domain_p1)  (Domain resp_out_domain_p1))))    ; Instantiate parameter resp_out_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Domain resp_out_domain_p1)  (Control resp_out_domain_p1))))    ; Instantiate parameter resp_out_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMem.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cachereq0_domain)  (Domain inst_cachereq0_domain))))    ; assign inst_cachereq0_msg = {inst_cachereq0_control, inst_cachereq0_data} @plab5-mcore-ProcNetCacheMem.v:626
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq0_domain)  (Domain data_cachereq0_domain))))    ; assign data_cachereq0_msg = {data_cachereq0_control, data_cachereq0_data} @plab5-mcore-ProcNetCacheMem.v:627
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp0_domain)  (Domain inst_cacheresp0_domain))))    ; assign {inst_cacheresp0_control, inst_cacheresp0_data} = inst_cacheresp0_msg @plab5-mcore-ProcNetCacheMem.v:628
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp0_domain)  (Domain data_cacheresp0_domain))))    ; assign {data_cacheresp0_control, data_cacheresp0_data} = data_cacheresp0_msg @plab5-mcore-ProcNetCacheMem.v:629
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cachereq0_domain)  (Domain inst_cachereq0_domain))))    ; Instantiate parameter procreq_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cachereq0_domain)  (Domain inst_cachereq0_domain))))    ; Instantiate parameter procreq_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter procreq_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cachereq0_domain)  (Domain inst_cachereq0_domain))))    ; Instantiate parameter procreq_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter procresp_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memreq_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter insecure in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memresp_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:640
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq0_domain)  (Domain data_cachereq0_domain))))    ; Instantiate parameter procreq_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq0_domain)  (Domain data_cachereq0_domain))))    ; Instantiate parameter procreq_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter procreq_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq0_domain)  (Domain data_cachereq0_domain))))    ; Instantiate parameter procreq_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter procresp_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memreq_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter insecure in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memresp_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMem.v:715
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cache2memreq0_domain)  (Domain inst_cache2memreq0_domain))))    ; assign {inst_cache2memreq0_control, inst_cache2memreq0_data} = inst_cache2memreq0_msg @plab5-mcore-ProcNetCacheMem.v:802
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cache2memreq0_domain)  (Domain data_cache2memreq0_domain))))    ; assign {data_cache2memreq0_control, data_cache2memreq0_data} = data_cache2memreq0_msg @plab5-mcore-ProcNetCacheMem.v:804
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; assign inst_mem2cacheresp0_msg = {inst_mem2cacheresp0_control, inst_mem2cacheresp0_data} @plab5-mcore-ProcNetCacheMem.v:806
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; assign data_mem2cacheresp0_msg = {data_mem2cacheresp0_control, data_mem2cacheresp0_data} @plab5-mcore-ProcNetCacheMem.v:808
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_sec_level in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter insecure in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cache2memreq0_domain)  (Domain inst_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cache2memreq0_domain)  (Domain inst_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cache2memreq0_domain)  (Domain inst_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cache2memreq0_domain)  (Domain inst_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_req_domain in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_resp_domain in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:821
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_sec_level in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter insecure in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cache2memreq0_domain)  (Domain data_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cache2memreq0_domain)  (Domain data_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cache2memreq0_domain)  (Domain data_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cache2memreq0_domain)  (Domain data_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_req_domain in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_resp_domain in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMem.v:863
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_clear in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_memreq0_domain)  (Domain inst_memreq0_domain))))    ; Instantiate parameter memreq_val in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_memreq0_domain)  (Domain inst_memreq0_domain))))    ; Instantiate parameter memreq_rdy in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_memreq0_domain)  (Domain inst_memreq0_domain))))    ; Instantiate parameter memreq_control in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_memreq0_domain)  (Domain inst_memreq0_domain))))    ; Instantiate parameter memreq_data in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memreq_domain in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_val in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_rdy in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_control in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_data in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memresp_domain in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:930
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_clear in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_memreq0_domain)  (Domain data_memreq0_domain))))    ; Instantiate parameter memreq_val in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_memreq0_domain)  (Domain data_memreq0_domain))))    ; Instantiate parameter memreq_rdy in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_memreq0_domain)  (Domain data_memreq0_domain))))    ; Instantiate parameter memreq_control in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_memreq0_domain)  (Domain data_memreq0_domain))))    ; Instantiate parameter memreq_data in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memreq_domain in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_val in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_rdy in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_control in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_data in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memresp_domain in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMem.v:960
(check-sat)
(pop)

