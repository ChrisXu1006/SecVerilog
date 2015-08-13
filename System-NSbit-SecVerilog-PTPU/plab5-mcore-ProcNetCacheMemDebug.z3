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
(declare-fun data_arb2memreq_domain () Int)
(assert (<= 0  data_arb2memreq_domain))
(assert (<= data_arb2memreq_domain 1))
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
(declare-fun data_dma2memreq_domain () Int)
(assert (<= 0  data_dma2memreq_domain))
(assert (<= data_dma2memreq_domain 1))
(declare-fun data_mem2arbresp_domain () Int)
(assert (<= 0  data_mem2arbresp_domain))
(assert (<= data_mem2arbresp_domain 1))
(declare-fun data_mem2cacheresp0_domain () Int)
(assert (<= 0  data_mem2cacheresp0_domain))
(assert (<= data_mem2cacheresp0_domain 1))
(declare-fun data_mem2dmaresp_domain () Int)
(assert (<= 0  data_mem2dmaresp_domain))
(assert (<= data_mem2dmaresp_domain 1))
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
(declare-fun db_domain () Int)
(assert (<= 0  db_domain))
(assert (<= db_domain 1))
(declare-fun db_resp_domain () Int)
(assert (<= 0  db_resp_domain))
(assert (<= db_resp_domain 1))
(declare-fun dmactrl_domain () Int)
(assert (<= 0  dmactrl_domain))
(assert (<= dmactrl_domain 1))
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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sec_domain in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_domain in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter imemreq_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter imemreq_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter imemreq_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter imemresp_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter imemresp_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter imemresp_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter dmemreq_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter dmemreq_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter dmemreq_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter dmemresp_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter dmemresp_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter dmemresp_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter debug_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter debug_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter debug_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter from_mngr_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter from_mngr_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter from_mngr_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter to_mngr_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter to_mngr_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter to_mngr_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter stats_en in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sec_domain in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_domain in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter imemreq_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter imemreq_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter imemreq_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter imemresp_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter imemresp_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter imemresp_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter dmemreq_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter dmemreq_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter dmemreq_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter dmemresp_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter dmemresp_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter dmemresp_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter debug_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter debug_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter debug_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter from_mngr_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter from_mngr_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter from_mngr_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter to_mngr_msg in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter to_mngr_val in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter to_mngr_rdy in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter stats_en in module plab2_proc_PipelinedProcBypass @plab5-mcore-ProcNetCacheMemDebug.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter cachereq_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter cachereq_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter cachereq_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter cacheresp_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter cacheresp_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter cacheresp_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter memreq_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter memreq_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter memreq_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter fail in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter memresp_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter memresp_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter memresp_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter cachereq_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter cachereq_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter cachereq_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter cacheresp_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter cacheresp_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter cacheresp_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter memreq_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter memreq_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter memreq_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter fail in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter memresp_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter memresp_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter memresp_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter cachereq_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter cachereq_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter cachereq_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter cacheresp_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter cacheresp_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter cacheresp_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter memreq_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter memreq_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter memreq_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter fail in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter memresp_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter memresp_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter memresp_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter cachereq_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter cachereq_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter cachereq_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter cacheresp_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter cacheresp_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter cacheresp_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter memreq_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter memreq_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter memreq_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter fail in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter memresp_msg in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter memresp_val in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter memresp_rdy in module plab3_mem_BlockingL1Cache @plab5-mcore-ProcNetCacheMemDebug.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter proc_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_net_resp_out_domain_d0)  (Control inst_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq (Control inst_net_resp_out_domain_d0)  (Domain inst_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_net_resp_out_domain_d0)  (Control inst_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter proc_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter proc_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter proc_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter proc_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_net_resp_out_domain_d1)  (Control inst_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq (Control inst_net_resp_out_domain_d1)  (Domain inst_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_net_resp_out_domain_d1)  (Control inst_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter proc_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter proc_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter proc_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter proc_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_net_resp_out_domain_d0)  (Control data_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq (Control data_net_resp_out_domain_d0)  (Domain data_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_net_resp_out_domain_d0)  (Control data_net_resp_out_domain_d0))))    ; Instantiate parameter net_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter proc_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Control 0))))    ; Instantiate parameter proc_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 0)  D1)))    ; Instantiate parameter proc_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:556
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:556
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter proc_sec_level in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:556
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_net_resp_out_domain_d1)  (Control data_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:556
(check-sat)
(pop)


(push)
(assert  (not(leq (Control data_net_resp_out_domain_d1)  (Domain data_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:556
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_net_resp_out_domain_d1)  (Control data_net_resp_out_domain_d1))))    ; Instantiate parameter net_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:556
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter proc_resp_val in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:556
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Control 1))))    ; Instantiate parameter proc_resp_rdy in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:556
(check-sat)
(pop)


(push)
(assert  (not(leq (Control 1)  D2)))    ; Instantiate parameter proc_resp_msg in module plab5_mcore_proc_resp_acc_insecure @plab5-mcore-ProcNetCacheMemDebug.v:556
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain inst_cachereq1_domain))))    ; assign inst_cachereq1_rdy = 1 @plab5-mcore-ProcNetCacheMemDebug.v:629
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain inst_cacheresp1_domain))))    ; assign inst_cacheresp1_val = 1 @plab5-mcore-ProcNetCacheMemDebug.v:630
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_msg_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_in_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_msg_control_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_msg_data_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_out_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp0_domain)  (Control inst_cacheresp0_domain))))    ; Instantiate parameter resp_in_msg_control_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp0_domain)  (Domain inst_cacheresp0_domain))))    ; Instantiate parameter resp_in_msg_data_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_in_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp0_domain)  (Control inst_cacheresp0_domain))))    ; Instantiate parameter resp_in_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq (Control inst_cacheresp0_domain)  (Domain inst_cacheresp0_domain))))    ; Instantiate parameter resp_in_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp0_domain)  (Domain inst_cacheresp0_domain))))    ; Instantiate parameter resp_in_fail_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_msg_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_out_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_fail_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_msg_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_in_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Control req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_msg_control_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Domain req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_msg_data_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_out_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Control req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Domain req_out_domain_p1)  (Control req_out_domain_p1))))    ; Instantiate parameter req_out_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp1_domain)  (Control inst_cacheresp1_domain))))    ; Instantiate parameter resp_in_msg_control_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp1_domain)  (Domain inst_cacheresp1_domain))))    ; Instantiate parameter resp_in_msg_data_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_in_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp1_domain)  (Control inst_cacheresp1_domain))))    ; Instantiate parameter resp_in_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq (Control inst_cacheresp1_domain)  (Domain inst_cacheresp1_domain))))    ; Instantiate parameter resp_in_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp1_domain)  (Domain inst_cacheresp1_domain))))    ; Instantiate parameter resp_in_fail_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Domain resp_out_domain_p1)  (Domain resp_out_domain_p1))))    ; Instantiate parameter resp_out_msg_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_out_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Control resp_out_domain_p1)  (Domain resp_out_domain_p1))))    ; Instantiate parameter resp_out_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Domain resp_out_domain_p1)  (Control resp_out_domain_p1))))    ; Instantiate parameter resp_out_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Domain resp_out_domain_p1)  (Domain resp_out_domain_p1))))    ; Instantiate parameter resp_out_fail_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:645
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_msg_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_in_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter req_in_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_msg_control_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_msg_data_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_out_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p0 () Int)
(assert (<= 0  req_out_domain_p0))
(assert (<= req_out_domain_p0 1))
(assert  (not(leq (Domain req_out_domain_p0)  (Domain req_out_domain_p0))))    ; Instantiate parameter req_out_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp0_domain)  (Control data_cacheresp0_domain))))    ; Instantiate parameter resp_in_msg_control_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp0_domain)  (Domain data_cacheresp0_domain))))    ; Instantiate parameter resp_in_msg_data_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_in_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp0_domain)  (Control data_cacheresp0_domain))))    ; Instantiate parameter resp_in_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq (Control data_cacheresp0_domain)  (Domain data_cacheresp0_domain))))    ; Instantiate parameter resp_in_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp0_domain)  (Domain data_cacheresp0_domain))))    ; Instantiate parameter resp_in_fail_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_msg_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_out_domain_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_val_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_rdy_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p0 () Int)
(assert (<= 0  resp_out_domain_p0))
(assert (<= resp_out_domain_p0 1))
(assert  (not(leq (Domain resp_out_domain_p0)  (Domain resp_out_domain_p0))))    ; Instantiate parameter resp_out_fail_p0 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_msg_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_in_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter req_in_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Control req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_msg_control_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Domain req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_msg_data_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_out_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Control req_out_domain_p1)  (Domain req_out_domain_p1))))    ; Instantiate parameter req_out_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun req_out_domain_p1 () Int)
(assert (<= 0  req_out_domain_p1))
(assert (<= req_out_domain_p1 1))
(assert  (not(leq (Domain req_out_domain_p1)  (Control req_out_domain_p1))))    ; Instantiate parameter req_out_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp1_domain)  (Control data_cacheresp1_domain))))    ; Instantiate parameter resp_in_msg_control_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp1_domain)  (Domain data_cacheresp1_domain))))    ; Instantiate parameter resp_in_msg_data_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_in_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp1_domain)  (Control data_cacheresp1_domain))))    ; Instantiate parameter resp_in_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq (Control data_cacheresp1_domain)  (Domain data_cacheresp1_domain))))    ; Instantiate parameter resp_in_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp1_domain)  (Domain data_cacheresp1_domain))))    ; Instantiate parameter resp_in_fail_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Domain resp_out_domain_p1)  (Domain resp_out_domain_p1))))    ; Instantiate parameter resp_out_msg_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_out_domain_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Control resp_out_domain_p1)  (Domain resp_out_domain_p1))))    ; Instantiate parameter resp_out_val_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Domain resp_out_domain_p1)  (Control resp_out_domain_p1))))    ; Instantiate parameter resp_out_rdy_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(declare-fun resp_out_domain_p1 () Int)
(assert (<= 0  resp_out_domain_p1))
(assert (<= resp_out_domain_p1 1))
(assert  (not(leq (Domain resp_out_domain_p1)  (Domain resp_out_domain_p1))))    ; Instantiate parameter resp_out_fail_p1 in module plab5_mcore_MemNet_Sep @plab5-mcore-ProcNetCacheMemDebug.v:712
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cachereq0_domain)  (Domain inst_cachereq0_domain))))    ; assign inst_cachereq0_msg = {inst_cachereq0_control, inst_cachereq0_data} @plab5-mcore-ProcNetCacheMemDebug.v:797
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq0_domain)  (Domain data_cachereq0_domain))))    ; assign data_cachereq0_msg = {data_cachereq0_control, data_cachereq0_data} @plab5-mcore-ProcNetCacheMemDebug.v:798
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cacheresp0_domain)  (Domain inst_cacheresp0_domain))))    ; assign {inst_cacheresp0_control, inst_cacheresp0_data} = inst_cacheresp0_msg @plab5-mcore-ProcNetCacheMemDebug.v:799
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp0_domain)  (Domain data_cacheresp0_domain))))    ; assign {data_cacheresp0_control, data_cacheresp0_data} = data_cacheresp0_msg @plab5-mcore-ProcNetCacheMemDebug.v:800
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cachereq0_domain)  (Domain inst_cachereq0_domain))))    ; Instantiate parameter procreq_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cachereq0_domain)  (Domain inst_cachereq0_domain))))    ; Instantiate parameter procreq_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter procreq_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cachereq0_domain)  (Domain inst_cachereq0_domain))))    ; Instantiate parameter procreq_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter fail in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter procresp_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memreq_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter insecure in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memresp_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:811
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq0_domain)  (Domain data_cachereq0_domain))))    ; Instantiate parameter procreq_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq0_domain)  (Domain data_cachereq0_domain))))    ; Instantiate parameter procreq_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter procreq_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq0_domain)  (Domain data_cachereq0_domain))))    ; Instantiate parameter procreq_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter fail in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter procresp_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(declare-fun procresp_domain () Int)
(assert (<= 0  procresp_domain))
(assert (<= procresp_domain 1))
(assert  (not(leq (Domain procresp_domain)  (Domain procresp_domain))))    ; Instantiate parameter procresp_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memreq_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(declare-fun memreq_domain () Int)
(assert (<= 0  memreq_domain))
(assert (<= memreq_domain 1))
(assert  (not(leq (Domain memreq_domain)  (Domain memreq_domain))))    ; Instantiate parameter memreq_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter insecure in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_msg in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memresp_domain in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_val in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; Instantiate parameter memresp_rdy in module plab3_mem_BlockingCacheSec_fsm1 @plab5-mcore-ProcNetCacheMemDebug.v:846
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq1_domain)  (Domain data_cachereq1_domain))))    ; assign dmache_noc_src_addr = data_cachereq1_control[4+:a] @plab5-mcore-ProcNetCacheMemDebug.v:881
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq1_domain)  (Domain data_cachereq1_domain))))    ; assign dmache_noc_dest_addr = data_cachereq1_data[(a)-(1):0] @plab5-mcore-ProcNetCacheMemDebug.v:882
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cacheresp1_domain)  (Domain data_cacheresp1_domain))))    ; assign data_cacheresp1_val = dmache_noc_ack @plab5-mcore-ProcNetCacheMemDebug.v:884
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain data_cacheresp1_domain))))    ; assign data_cacheresp1_data = 'bxxxx @plab5-mcore-ProcNetCacheMemDebug.v:885
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign data_cacheresp1_domain = 0 @plab5-mcore-ProcNetCacheMemDebug.v:886
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain data_cacheresp1_domain))))    ; assign data_cacheresp1_fail = 0 @plab5-mcore-ProcNetCacheMemDebug.v:887
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq1_domain)  (Domain data_cachereq1_domain))))    ; Instantiate parameter noc_val in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq1_domain)  (Domain data_cachereq1_domain))))    ; Instantiate parameter noc_rdy in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter noc_domain in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq1_domain)  (Domain data_cachereq1_domain))))    ; Instantiate parameter noc_src_addr in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq1_domain)  (Domain data_cachereq1_domain))))    ; Instantiate parameter noc_dest_addr in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cachereq1_domain)  (Domain data_cachereq1_domain))))    ; Instantiate parameter noc_req_control in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(declare-fun noc_resp_domain () Int)
(assert (<= 0  noc_resp_domain))
(assert (<= noc_resp_domain 1))
(assert  (not(leq (Domain noc_resp_domain)  (Domain noc_resp_domain))))    ; Instantiate parameter noc_resp_control in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Domain data_cachereq1_domain))))    ; Instantiate parameter noc_inst in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(declare-fun noc_resp_domain () Int)
(assert (<= 0  noc_resp_domain))
(assert (<= noc_resp_domain 1))
(assert  (not(leq (Domain noc_resp_domain)  (Domain noc_resp_domain))))    ; Instantiate parameter noc_ack in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter noc_resp_domain in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_val in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_rdy in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter dma_domain in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_src_addr in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_dest_addr in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_req_control in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_inst in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_ack in module plab5_mcore_DMA_checker @plab5-mcore-ProcNetCacheMemDebug.v:895
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter val in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter rdy in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter src_addr in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter dest_addr in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter req_control in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter inst in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter ack in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter db_val in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter db_src_addr in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter db_dest_addr in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter db_inst in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter debug_data in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_val in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_rdy in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_control in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_data in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_req_domain in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2dmaresp_domain)  (Domain data_mem2dmaresp_domain))))    ; Instantiate parameter mem_resp_val in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2dmaresp_domain)  (Domain data_mem2dmaresp_domain))))    ; Instantiate parameter mem_resp_rdy in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2dmaresp_domain)  (Domain data_mem2dmaresp_domain))))    ; Instantiate parameter mem_resp_control in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2dmaresp_domain)  (Domain data_mem2dmaresp_domain))))    ; Instantiate parameter mem_resp_data in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_resp_domain in module plab5_mcore_DMA_Controller @plab5-mcore-ProcNetCacheMemDebug.v:957
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; assign db_in_src_addr = debug_msg_p0[(((d)-(1))+($clog2((d)/(8))))+(a):(((d)-(1))+($clog2((d)/(8))))+(1)] @plab5-mcore-ProcNetCacheMemDebug.v:1011
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; assign db_in_dest_addr = debug_msg_p0[(d)-(1):0] @plab5-mcore-ProcNetCacheMemDebug.v:1012
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain db_domain)  (Domain db_domain))))    ; Instantiate parameter debug_val in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter debug_domain in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain db_domain)  (Domain db_domain))))    ; Instantiate parameter debug_src_addr in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain db_domain)  (Domain db_domain))))    ; Instantiate parameter debug_dest_addr in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain db_domain)  (Domain db_domain))))    ; Instantiate parameter debug_inst in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(declare-fun debug_resp_domain () Int)
(assert (<= 0  debug_resp_domain))
(assert (<= debug_resp_domain 1))
(assert  (not(leq (Domain debug_resp_domain)  (Domain debug_resp_domain))))    ; Instantiate parameter debug_ack in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(declare-fun debug_resp_domain () Int)
(assert (<= 0  debug_resp_domain))
(assert (<= debug_resp_domain 1))
(assert  (not(leq (Domain debug_resp_domain)  (Domain debug_resp_domain))))    ; Instantiate parameter debug_data in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter debug_resp_domain in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter dma_domain in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_ack in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_db_val in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_db_src_addr in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_db_dest_addr in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_db_inst in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain dmactrl_domain)  (Domain dmactrl_domain))))    ; Instantiate parameter dma_db_debug_data in module plab5_mcore_Debug_checker @plab5-mcore-ProcNetCacheMemDebug.v:1020
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter start in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter inst in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter src_addr in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter dest_addr in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter result_rdy in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))
(assert  (not(leq (Domain domain)  (Domain domain))))    ; Instantiate parameter db_result in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter val in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter db_src_addr in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter db_dest_addr in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter db_domain in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain db_resp_domain)  (Domain db_resp_domain))))    ; Instantiate parameter ack in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain db_resp_domain)  (Domain db_resp_domain))))    ; Instantiate parameter read_data in module plab5_mcore_Debug_Interface @plab5-mcore-ProcNetCacheMemDebug.v:1048
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cache2memreq0_domain)  (Domain inst_cache2memreq0_domain))))    ; assign {inst_cache2memreq0_control, inst_cache2memreq0_data} = inst_cache2memreq0_msg @plab5-mcore-ProcNetCacheMemDebug.v:1095
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cache2memreq0_domain)  (Domain data_cache2memreq0_domain))))    ; assign {data_cache2memreq0_control, data_cache2memreq0_data} = data_cache2memreq0_msg @plab5-mcore-ProcNetCacheMemDebug.v:1097
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; assign inst_mem2cacheresp0_msg = {inst_mem2cacheresp0_control, inst_mem2cacheresp0_data} @plab5-mcore-ProcNetCacheMemDebug.v:1099
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2cacheresp0_domain)  (Domain data_mem2cacheresp0_domain))))    ; assign data_mem2cacheresp0_msg = {data_mem2cacheresp0_control, data_mem2cacheresp0_data} @plab5-mcore-ProcNetCacheMemDebug.v:1101
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_sec_level in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter insecure in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cache2memreq0_domain)  (Domain inst_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cache2memreq0_domain)  (Domain inst_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cache2memreq0_domain)  (Domain inst_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_cache2memreq0_domain)  (Domain inst_cache2memreq0_domain))))    ; Instantiate parameter cache2mem_req_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_req_domain in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_mem2cacheresp0_domain)  (Domain inst_mem2cacheresp0_domain))))    ; Instantiate parameter mem2cache_resp_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_resp_domain in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1114
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cache2memreq0_domain)  (Domain data_cache2memreq0_domain))))    ; Instantiate parameter req0_val in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cache2memreq0_domain)  (Domain data_cache2memreq0_domain))))    ; Instantiate parameter req0_rdy in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cache2memreq0_domain)  (Domain data_cache2memreq0_domain))))    ; Instantiate parameter req0_control in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_cache2memreq0_domain)  (Domain data_cache2memreq0_domain))))    ; Instantiate parameter req0_data in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req0_domain in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_dma2memreq_domain)  (Domain data_dma2memreq_domain))))    ; Instantiate parameter req1_val in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_dma2memreq_domain)  (Domain data_dma2memreq_domain))))    ; Instantiate parameter req1_rdy in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_dma2memreq_domain)  (Domain data_dma2memreq_domain))))    ; Instantiate parameter req1_control in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_dma2memreq_domain)  (Domain data_dma2memreq_domain))))    ; Instantiate parameter req1_data in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req1_domain in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun req_domain () Int)
(assert (<= 0  req_domain))
(assert (<= req_domain 1))
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter req_val in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun req_domain () Int)
(assert (<= 0  req_domain))
(assert (<= req_domain 1))
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter req_rdy in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun req_domain () Int)
(assert (<= 0  req_domain))
(assert (<= req_domain 1))
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter req_control in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun req_domain () Int)
(assert (<= 0  req_domain))
(assert (<= req_domain 1))
(assert  (not(leq (Domain req_domain)  (Domain req_domain))))    ; Instantiate parameter req_data in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_domain in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun resp0_domain () Int)
(assert (<= 0  resp0_domain))
(assert (<= resp0_domain 1))
(assert  (not(leq (Domain resp0_domain)  (Domain resp0_domain))))    ; Instantiate parameter resp0_val in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun resp0_domain () Int)
(assert (<= 0  resp0_domain))
(assert (<= resp0_domain 1))
(assert  (not(leq (Domain resp0_domain)  (Domain resp0_domain))))    ; Instantiate parameter resp0_rdy in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun resp0_domain () Int)
(assert (<= 0  resp0_domain))
(assert (<= resp0_domain 1))
(assert  (not(leq (Domain resp0_domain)  (Domain resp0_domain))))    ; Instantiate parameter resp0_control in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun resp0_domain () Int)
(assert (<= 0  resp0_domain))
(assert (<= resp0_domain 1))
(assert  (not(leq (Domain resp0_domain)  (Domain resp0_domain))))    ; Instantiate parameter resp0_data in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun resp0_domain () Int)
(assert (<= 0  resp0_domain))
(assert (<= resp0_domain 1))
(assert  (not(leq (Domain resp0_domain)  (Domain resp0_domain))))    ; Instantiate parameter resp0_insecure in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp0_domain in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun resp1_domain () Int)
(assert (<= 0  resp1_domain))
(assert (<= resp1_domain 1))
(assert  (not(leq (Domain resp1_domain)  (Domain resp1_domain))))    ; Instantiate parameter resp1_val in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun resp1_domain () Int)
(assert (<= 0  resp1_domain))
(assert (<= resp1_domain 1))
(assert  (not(leq (Domain resp1_domain)  (Domain resp1_domain))))    ; Instantiate parameter resp1_rdy in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun resp1_domain () Int)
(assert (<= 0  resp1_domain))
(assert (<= resp1_domain 1))
(assert  (not(leq (Domain resp1_domain)  (Domain resp1_domain))))    ; Instantiate parameter resp1_control in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun resp1_domain () Int)
(assert (<= 0  resp1_domain))
(assert (<= resp1_domain 1))
(assert  (not(leq (Domain resp1_domain)  (Domain resp1_domain))))    ; Instantiate parameter resp1_data in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(declare-fun resp1_domain () Int)
(assert (<= 0  resp1_domain))
(assert (<= resp1_domain 1))
(assert  (not(leq (Domain resp1_domain)  (Domain resp1_domain))))    ; Instantiate parameter resp1_insecure in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp1_domain in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2arbresp_domain)  (Domain data_mem2arbresp_domain))))    ; Instantiate parameter resp_val in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2arbresp_domain)  (Domain data_mem2arbresp_domain))))    ; Instantiate parameter resp_rdy in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2arbresp_domain)  (Domain data_mem2arbresp_domain))))    ; Instantiate parameter resp_control in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2arbresp_domain)  (Domain data_mem2arbresp_domain))))    ; Instantiate parameter resp_data in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2arbresp_domain)  (Domain data_mem2arbresp_domain))))    ; Instantiate parameter resp_insecure in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_domain in module plab5_mcore_mem_arbiter @plab5-mcore-ProcNetCacheMemDebug.v:1167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter req_sec_level in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter resp_sec_level in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2arbresp_domain)  (Domain data_mem2arbresp_domain))))    ; Instantiate parameter insecure in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_arb2memreq_domain)  (Domain data_arb2memreq_domain))))    ; Instantiate parameter cache2mem_req_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_arb2memreq_domain)  (Domain data_arb2memreq_domain))))    ; Instantiate parameter cache2mem_req_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_arb2memreq_domain)  (Domain data_arb2memreq_domain))))    ; Instantiate parameter cache2mem_req_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_arb2memreq_domain)  (Domain data_arb2memreq_domain))))    ; Instantiate parameter cache2mem_req_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(declare-fun mem_req_domain () Int)
(assert (<= 0  mem_req_domain))
(assert (<= mem_req_domain 1))
(assert  (not(leq (Domain mem_req_domain)  (Domain mem_req_domain))))    ; Instantiate parameter mem_req_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_req_domain in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2arbresp_domain)  (Domain data_mem2arbresp_domain))))    ; Instantiate parameter mem2cache_resp_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2arbresp_domain)  (Domain data_mem2arbresp_domain))))    ; Instantiate parameter mem2cache_resp_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2arbresp_domain)  (Domain data_mem2arbresp_domain))))    ; Instantiate parameter mem2cache_resp_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_mem2arbresp_domain)  (Domain data_mem2arbresp_domain))))    ; Instantiate parameter mem2cache_resp_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_control in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_data in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_val in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(declare-fun mem_resp_domain () Int)
(assert (<= 0  mem_resp_domain))
(assert (<= mem_resp_domain 1))
(assert  (not(leq (Domain mem_resp_domain)  (Domain mem_resp_domain))))    ; Instantiate parameter mem_resp_rdy in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_resp_domain in module plab5_mcore_mem_addr_ctrl_fsm @plab5-mcore-ProcNetCacheMemDebug.v:1222
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_clear in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_memreq0_domain)  (Domain inst_memreq0_domain))))    ; Instantiate parameter memreq_val in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_memreq0_domain)  (Domain inst_memreq0_domain))))    ; Instantiate parameter memreq_rdy in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_memreq0_domain)  (Domain inst_memreq0_domain))))    ; Instantiate parameter memreq_control in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain inst_memreq0_domain)  (Domain inst_memreq0_domain))))    ; Instantiate parameter memreq_data in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memreq_domain in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_val in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_rdy in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_control in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_data in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memresp_domain in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter reset in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mode in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter mem_clear in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_memreq0_domain)  (Domain data_memreq0_domain))))    ; Instantiate parameter memreq_val in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_memreq0_domain)  (Domain data_memreq0_domain))))    ; Instantiate parameter memreq_rdy in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_memreq0_domain)  (Domain data_memreq0_domain))))    ; Instantiate parameter memreq_control in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain data_memreq0_domain)  (Domain data_memreq0_domain))))    ; Instantiate parameter memreq_data in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memreq_domain in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_val in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_rdy in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_control in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(declare-fun memresp_domain () Int)
(assert (<= 0  memresp_domain))
(assert (<= memresp_domain 1))
(assert  (not(leq (Domain memresp_domain)  (Domain memresp_domain))))    ; Instantiate parameter memresp_data in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter memresp_domain in module plab5_mcore_TestMem_Uni @plab5-mcore-ProcNetCacheMemDebug.v:1319
(check-sat)
(pop)

