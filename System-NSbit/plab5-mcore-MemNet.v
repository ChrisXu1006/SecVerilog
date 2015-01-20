//========================================================================
// Memory Request/Response Network
//========================================================================

`ifndef PLAB5_MCORE_MEM_NET_V
`define PLAB5_MCORE_MEM_NET_V

`include "vc-mem-msgs.v"
`include "vc-net-msgs.v"
`include "plab5-mcore-mem-net-adapters.v"
`include "plab4-net-RingNetAlt.v"

module plab5_mcore_MemNet
#(
  parameter p_mem_opaque_nbits  = 8,
  parameter p_mem_addr_nbits    = 32,
  parameter p_mem_data_nbits    = 32,

  parameter p_num_ports         = 4,

  parameter p_single_bank       = 0,

  parameter o = p_mem_opaque_nbits,
  parameter a = p_mem_addr_nbits,
  parameter d = p_mem_data_nbits,

  parameter c_net_srcdest_nbits = $clog2(p_num_ports),
  parameter c_net_opaque_nbits  = 4,

  parameter ns = c_net_srcdest_nbits,
  parameter no = c_net_opaque_nbits,

  parameter c_req_nbits   = `VC_MEM_REQ_MSG_NBITS(o,a,d),
  parameter c_req_cnbits  = c_req_nbits - d,
  parameter c_req_dnbits  = d,
  parameter c_resp_nbits  = `VC_MEM_RESP_MSG_NBITS(o,d),
  parameter c_resp_cnbits = c_resp_nbits - d,
  parameter c_resp_dnbits = d,

  parameter rq  = c_req_nbits,
  parameter rqc = c_req_cnbits,
  parameter rqd = c_req_dnbits, 
  parameter rs	= c_resp_nbits,
  parameter rsc = c_resp_cnbits,
  parameter rsd = c_resp_dnbits,

  parameter c_req_net_msg_cnbits  = `VC_NET_MSG_NBITS(rqc,no,ns),
  parameter c_req_net_msg_dnbits  = rqd,
  parameter c_resp_net_msg_cnbits = `VC_NET_MSG_NBITS(rsc,no,ns),
  parameter c_resp_net_msg_dnbits = rsd,

  parameter nrqc = c_req_net_msg_cnbits,
  parameter nrqd = c_req_net_msg_dnbits,
  parameter nrsc = c_resp_net_msg_cnbits,
  parameter nrsd = c_resp_net_msg_dnbits

)
(

  input                        clk,
  input                        reset,

  // determine the mode for inst/data
  // 0:inst 1:data
  input						   mode,

  input   [rq*p_num_ports-1:0] req_in_msg,
  input   [p_num_ports-1:0]    req_in_val,
  output  [p_num_ports-1:0]    req_in_rdy,

  output  [rs*p_num_ports-1:0] resp_out_msg,
  output  [p_num_ports-1:0]    resp_out_val,
  input   [p_num_ports-1:0]    resp_out_rdy,

  output  [rqc*p_num_ports-1:0]req_out_msg_control,
  output  [rqd*p_num_ports-1:0]req_out_msg_data,
  output  [p_num_ports-1:0]	   req_out_domain,
  output  [p_num_ports-1:0]    req_out_val,
  input   [p_num_ports-1:0]    req_out_rdy,

  input   [rsc*p_num_ports-1:0]resp_in_msg_control,
  input   [rsd*p_num_ports-1:0]resp_in_msg_data,
  input   [p_num_ports-1:0]    resp_in_val,
  output  [p_num_ports-1:0]    resp_in_rdy

);

  wire [(nrqc+1)*p_num_ports-1:0]req_net_in_msg_control;
  wire [nrqd*p_num_ports-1:0] req_net_in_msg_data;
  wire [(nrqc+1)*p_num_ports-1:0]req_net_out_msg_control;
  wire [nrqd*p_num_ports-1:0] req_net_out_msg_data;
  wire [nrsc*p_num_ports-1:0] resp_net_in_msg_control;
  wire [nrsd*p_num_ports-1:0] resp_net_in_msg_data;
  wire [nrsc*p_num_ports-1:0] resp_net_out_msg_control;
  wire [nrsd*p_num_ports-1:0] resp_net_out_msg_data;

  wire [(rqc+1)*p_num_ports-1:0]req_out_msg_control_M;
  wire [rsc*p_num_ports-1:0]  resp_out_msg_control;
  wire [rsd*p_num_ports-1:0]  resp_out_msg_data;

  genvar i;

  generate
    for ( i = 0; i < p_num_ports; i = i + 1 ) begin: ADAPTERS

      // proc req mem msg to net msg adapter

      plab5_mcore_MemReqMsgToNetMsg
      #(
        .p_net_src            (i),
        .p_num_ports          (p_num_ports),

        .p_mem_opaque_nbits   (p_mem_opaque_nbits),
        .p_mem_addr_nbits     (p_mem_addr_nbits),
        .p_mem_data_nbits     (p_mem_data_nbits),

        .p_net_opaque_nbits   (c_net_opaque_nbits),
        .p_net_srcdest_nbits  (c_net_srcdest_nbits),

        .p_single_bank        (p_single_bank)
      )
      proc_mem_msg_to_net_msg
      (
		.mode				(mode),
        .mem_msg			(req_in_msg[`VC_PORT_PICK_FIELD(rq,i)]),
        .net_msg_control	(req_net_in_msg_control[`VC_PORT_PICK_FIELD((nrqc+1),i)]),
        .net_msg_data		(req_net_in_msg_data[`VC_PORT_PICK_FIELD(nrqd,i)])
      );

      // extract the cache req mem msg from net msg payload

      vc_NetMsgUnpack #(rqc+1,no,ns) req_net_msg_control_unpack
      (
        .msg      (req_net_out_msg_control[`VC_PORT_PICK_FIELD((nrqc+1),i)]),
        .payload  (req_out_msg_control_M[`VC_PORT_PICK_FIELD((rqc+1),i)])
      );

	  assign {req_out_domain[`VC_PORT_PICK_FIELD(1,i)],req_out_msg_control[`VC_PORT_PICK_FIELD(rqc,i)]} 
			= req_out_msg_control_M[`VC_PORT_PICK_FIELD((rqc+1),i)];
	  // extract the cache req mem msg from net msg payload

	  assign req_out_msg_data[`VC_PORT_PICK_FIELD(rqd,i)]
				= req_net_out_msg_data[`VC_PORT_PICK_FIELD(nrqd,i)];

      // cache resp mem msg to net msg adapter

      plab5_mcore_MemRespMsgToNetMsg
      #(
        .p_net_src            (i),
        .p_num_ports          (p_num_ports),

        .p_mem_opaque_nbits   (p_mem_opaque_nbits),
        .p_mem_data_nbits     (p_mem_data_nbits),

        .p_net_opaque_nbits   (c_net_opaque_nbits),
        .p_net_srcdest_nbits  (c_net_srcdest_nbits)
      )
      cache_mem_msg_to_net_msg
      (
	    .mem_msg_control(resp_in_msg_control[`VC_PORT_PICK_FIELD(rsc,i)]),
		.mem_msg_data	(resp_in_msg_data[`VC_PORT_PICK_FIELD(rsd,i)]),
        .net_msg_control(resp_net_in_msg_control[`VC_PORT_PICK_FIELD(nrsc,i)]),
		.net_msg_data	(resp_net_in_msg_data[`VC_PORT_PICK_FIELD(nrsd,i)])
      );

      // extract the proc resp mem msg from net msg payload

      vc_NetMsgUnpack #(rsc,no,ns) resp_net_msg_control_unpack
      (
        .msg      (resp_net_out_msg_control[`VC_PORT_PICK_FIELD(nrsc,i)]),
        .payload  (resp_out_msg_control[`VC_PORT_PICK_FIELD(rsc,i)])
      );

	  assign resp_out_msg_data[`VC_PORT_PICK_FIELD(rsd,i)]
				= resp_net_out_msg_data[`VC_PORT_PICK_FIELD(nrsd,i)];

	  assign resp_out_msg[`VC_PORT_PICK_FIELD(rs,i)] = 
		{resp_out_msg_control[`VC_PORT_PICK_FIELD(rsc,i)],resp_out_msg_data[`VC_PORT_PICK_FIELD(rsd,i)]}; 

    end
  endgenerate

  // request network

  `define PLAB4_NET_NUM_PORTS_4

  wire [p_num_ports-1:0] req_net_in_val;
  wire [p_num_ports-1:0] req_net_out_rdy;
  wire [p_num_ports-1:0] resp_net_in_val;
  wire [p_num_ports-1:0] resp_net_out_rdy;

  // for single bank mode, the cache side of things are padded to 0 other
  // than cache/mem 0

  assign req_net_in_val   = req_in_val;
  assign req_net_out_rdy  = p_single_bank ? { 32'h0, req_out_rdy[0] } :
                                            req_out_rdy;

  assign resp_net_in_val  = p_single_bank ? { 32'h0, resp_in_val[0] } :
                                            resp_in_val;
  assign resp_net_out_rdy = resp_out_rdy;

  plab4_net_RingNetAlt #(rqc+1,rqd,no,ns,2) req_net
  (
    .clk			(clk),
    .reset			(reset),

    .in_val			(req_net_in_val),
    .in_rdy			(req_in_rdy),
    .in_msg_control (req_net_in_msg_control),
	.in_msg_data	(req_net_in_msg_data),

    .out_val		(req_out_val),
    .out_rdy		(req_net_out_rdy),
    .out_msg_control(req_net_out_msg_control),
	.out_msg_data	(req_net_out_msg_data)
  );

  // response network

  plab4_net_RingNetAlt #(rsc,rsd,no,ns,2) resp_net
  (
    .clk			(clk),
    .reset			(reset),

    .in_val			(resp_net_in_val),
    .in_rdy			(resp_in_rdy),
    .in_msg_control (resp_net_in_msg_control),
	.in_msg_data	(resp_net_in_msg_data),

    .out_val		(resp_out_val),
    .out_rdy		(resp_net_out_rdy),
    .out_msg_control(resp_net_out_msg_control),
	.out_msg_data	(resp_net_out_msg_data)
  );



endmodule

`endif /* PLAB5_MCORE_MEM_NET_V */
