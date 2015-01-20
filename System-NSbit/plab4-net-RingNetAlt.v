//========================================================================
// plab4-net-RingNetAlt
//========================================================================

`ifndef PLAB4_NET_RING_NET_ALT
`define PLAB4_NET_RING_NET_ALT

`include "vc-net-msgs.v"
`include "vc-param-utils.v"
`include "vc-queues.v"
`include "plab4-net-RouterAlt.v"
`include "plab4-net-demux.v"

// macros to calculate previous and next router ids

`define PREV(i_)  ( ( i_ + p_num_ports - 1 ) % p_num_ports )
`define NEXT(i_)  ( ( i_ + 1 ) % p_num_ports )

module plab4_net_RingNetAlt
#(
  parameter p_payload_cnbits = 32,
  parameter p_payload_dnbits = 32,
  parameter p_opaque_nbits   = 3,
  parameter p_srcdest_nbits  = 3,

  parameter p_num_ports = 8,

  // Shorter names, not to be set from outside the module
  parameter pc = p_payload_cnbits,
  parameter pd = p_payload_dnbits,
  parameter o  = p_opaque_nbits,
  parameter s  = p_srcdest_nbits,

  parameter c_net_msg_cnbits = `VC_NET_MSG_NBITS(pc,o,s),
  parameter c_net_msg_dnbits = `VC_NET_MSG_NBITS(pd,o,s),

  parameter m  = c_net_msg_cnbits
  
)
(
  input clk,
  input reset,

  input  [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] in_val,
  output [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] in_rdy,
  input  [`VC_PORT_PICK_NBITS(m,p_num_ports)-1:0] in_msg_control,
  input  [`VC_PORT_PICK_NBITS(pd,p_num_ports)-1:0]in_msg_data,

  output [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] out_val,
  input  [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] out_rdy,
  output [`VC_PORT_PICK_NBITS(m,p_num_ports)-1:0] out_msg_control,
  output [`VC_PORT_PICK_NBITS(pd,p_num_ports)-1:0]out_msg_data
);

  //----------------------------------------------------------------------
  // Router-router connection wires
  //----------------------------------------------------------------------

  // forward (increasing router id) wires

  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] forw_out_val;
  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] forw_out_rdy;
  wire [`VC_PORT_PICK_NBITS(m,p_num_ports)-1:0] forw_out_msg_control;
  wire [`VC_PORT_PICK_NBITS(pd,p_num_ports)-1:0]forw_out_msg_data;

  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] forw_in_val_d1;
  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] forw_in_rdy_d1;
  wire [`VC_PORT_PICK_NBITS(m,p_num_ports)-1:0] forw_in_msg_control_d1;
  wire [`VC_PORT_PICK_NBITS(pd,p_num_ports)-1:0]forw_in_msg_data_d1;

  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] forw_in_val_d2;
  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] forw_in_rdy_d2;
  wire [`VC_PORT_PICK_NBITS(m,p_num_ports)-1:0] forw_in_msg_control_d2;
  wire [`VC_PORT_PICK_NBITS(pd,p_num_ports)-1:0]forw_in_msg_data_d2;

  // backward (decreasing router id) wires

  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] backw_out_val;
  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] backw_out_rdy;
  wire [`VC_PORT_PICK_NBITS(m,p_num_ports)-1:0] backw_out_msg_control;
  wire [`VC_PORT_PICK_NBITS(pd,p_num_ports)-1:0]backw_out_msg_data;

  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] backw_in_val_d1;
  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] backw_in_rdy_d1;
  wire [`VC_PORT_PICK_NBITS(m,p_num_ports)-1:0] backw_in_msg_control_d1;
  wire [`VC_PORT_PICK_NBITS(pd,p_num_ports)-1:0]backw_in_msg_data_d1;
 
  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] backw_in_val_d2;
  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] backw_in_rdy_d2;
  wire [`VC_PORT_PICK_NBITS(m,p_num_ports)-1:0] backw_in_msg_control_d2;
  wire [`VC_PORT_PICK_NBITS(pd,p_num_ports)-1:0]backw_in_msg_data_d2;

  // domain output signal in each router

  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] out0_domain;
  wire [`VC_PORT_PICK_NBITS(1,p_num_ports)-1:0] out2_domain;

  // num free wires for adaptive routing

  wire [`VC_PORT_PICK_NBITS(2,p_num_ports)-1:0] num_free_prev;
  wire [`VC_PORT_PICK_NBITS(2,p_num_ports)-1:0] num_free_next;

  //----------------------------------------------------------------------
  // Router generation
  //----------------------------------------------------------------------

  genvar i;

  generate
    for ( i = 0; i < p_num_ports; i = i + 1 ) begin: ROUTER

      plab4_net_RouterAlt
      #(
        .p_payload_cnbits	(p_payload_cnbits),
		.p_payload_dnbits	(p_payload_dnbits),
        .p_opaque_nbits		(p_opaque_nbits),
        .p_srcdest_nbits	(p_srcdest_nbits),

        .p_router_id		(i),
        .p_num_routers		(p_num_ports)
      )
      router
      (
        .clk				(clk),
        .reset				(reset),

        .in0_val_d1			(forw_in_val_d1[`VC_PORT_PICK_FIELD(1,i)]),
        .in0_rdy_d1			(forw_in_rdy_d1[`VC_PORT_PICK_FIELD(1,i)]),
        .in0_msg_control_d1 (forw_in_msg_control_d1[`VC_PORT_PICK_FIELD(m,i)]),
        .in0_msg_data_d1	(forw_in_msg_data_d1[`VC_PORT_PICK_FIELD(pd,i)]),

        .in0_val_d2			(forw_in_val_d2[`VC_PORT_PICK_FIELD(1,i)]),
        .in0_rdy_d2			(forw_in_rdy_d2[`VC_PORT_PICK_FIELD(1,i)]),
        .in0_msg_control_d2 (forw_in_msg_control_d2[`VC_PORT_PICK_FIELD(m,i)]),
        .in0_msg_data_d2	(forw_in_msg_data_d2[`VC_PORT_PICK_FIELD(pd,i)]),
		
        .in1_val			(in_val[`VC_PORT_PICK_FIELD(1,i)]),
        .in1_rdy			(in_rdy[`VC_PORT_PICK_FIELD(1,i)]),
        .in1_msg_control    (in_msg_control[`VC_PORT_PICK_FIELD(m,i)]),
        .in1_msg_data	    (in_msg_data[`VC_PORT_PICK_FIELD(pd,i)]),

        .in2_val_d1			(backw_in_val_d1[`VC_PORT_PICK_FIELD(1,i)]),
        .in2_rdy_d1			(backw_in_rdy_d1[`VC_PORT_PICK_FIELD(1,i)]),
        .in2_msg_control_d1 (backw_in_msg_control_d1[`VC_PORT_PICK_FIELD(m,i)]),
        .in2_msg_data_d1	(backw_in_msg_data_d1[`VC_PORT_PICK_FIELD(pd,i)]),

        .in2_val_d2			(backw_in_val_d2[`VC_PORT_PICK_FIELD(1,i)]),
        .in2_rdy_d2			(backw_in_rdy_d2[`VC_PORT_PICK_FIELD(1,i)]),
        .in2_msg_control_d2	(backw_in_msg_control_d2[`VC_PORT_PICK_FIELD(m,i)]),
        .in2_msg_data_d2	(backw_in_msg_data_d2[`VC_PORT_PICK_FIELD(pd,i)]),

        .out0_val			(backw_out_val[`VC_PORT_PICK_FIELD(1,i)]),
        .out0_rdy			(backw_out_rdy[`VC_PORT_PICK_FIELD(1,i)]),
        .out0_msg_control	(backw_out_msg_control[`VC_PORT_PICK_FIELD(m,i)]),
        .out0_msg_data		(backw_out_msg_data[`VC_PORT_PICK_FIELD(pd,i)]),
		.out0_domain		(out0_domain[`VC_PORT_PICK_FIELD(1,i)]),

        .out1_val			(out_val[`VC_PORT_PICK_FIELD(1,i)]),
        .out1_rdy			(out_rdy[`VC_PORT_PICK_FIELD(1,i)]),
        .out1_msg_control	(out_msg_control[`VC_PORT_PICK_FIELD(m,i)]),
        .out1_msg_data		(out_msg_data[`VC_PORT_PICK_FIELD(pd,i)]),

        .out2_val			(forw_out_val[`VC_PORT_PICK_FIELD(1,i)]),
        .out2_rdy			(forw_out_rdy[`VC_PORT_PICK_FIELD(1,i)]),
        .out2_msg_control	(forw_out_msg_control[`VC_PORT_PICK_FIELD(m,i)]),
        .out2_msg_data		(forw_out_msg_data[`VC_PORT_PICK_FIELD(pd,i)]),
		.out2_domain		(out2_domain[`VC_PORT_PICK_FIELD(1,i)]),

        .num_free_prev (1),
        .num_free_next (1)

      );


    end
  endgenerate

  //----------------------------------------------------------------------
  // Demux generation
  //----------------------------------------------------------------------

  generate
    for ( i = 0; i < p_num_ports; i = i + 1 ) begin: CHANNEL

	  plab4_net_demux
      #(
		.p_msg_cnbits  (c_net_msg_cnbits),
		.p_msg_dnbits  (pd)
	  )
	  forw_demux
	  (
		.domain		  (out2_domain[`VC_PORT_PICK_FIELD(1,`PREV(i))]),

		.out_val	  (forw_out_val[`VC_PORT_PICK_FIELD(1,`PREV(i))]),
		.in_val_d1	  (forw_in_val_d1[`VC_PORT_PICK_FIELD(1, i)]),
		.in_val_d2	  (forw_in_val_d2[`VC_PORT_PICK_FIELD(1, i)]),

		.in_rdy_d1	  (forw_in_rdy_d1[`VC_PORT_PICK_FIELD(1, i)]),
		.in_rdy_d2	  (forw_in_rdy_d2[`VC_PORT_PICK_FIELD(1, i)]),
		.out_rdy	  (forw_out_rdy[`VC_PORT_PICK_FIELD(1,`PREV(i))]),

		.out_msg_control	(forw_out_msg_control[`VC_PORT_PICK_FIELD(m,`PREV(i))]),
		.in_msg_control_d1	(forw_in_msg_control_d1[`VC_PORT_PICK_FIELD(m, i)]),
		.in_msg_control_d2	(forw_in_msg_control_d2[`VC_PORT_PICK_FIELD(m, i)]),

		.out_msg_data		(forw_out_msg_data[`VC_PORT_PICK_FIELD(pd,`PREV(i))]),
		.in_msg_data_d1		(forw_in_msg_data_d1[`VC_PORT_PICK_FIELD(pd, i)]),
		.in_msg_data_d2		(forw_in_msg_data_d2[`VC_PORT_PICK_FIELD(pd, i)])
	  );

	  plab4_net_demux
	  #(
		.p_msg_cnbits  (c_net_msg_cnbits),
		.p_msg_dnbits  (pd)
	  )
	  backw_demux
	  (
		.domain		  (out0_domain[`VC_PORT_PICK_FIELD(1,`NEXT(i))]),

		.out_val	  (backw_out_val[`VC_PORT_PICK_FIELD(1,`NEXT(i))]),
		.in_val_d1	  (backw_in_val_d1[`VC_PORT_PICK_FIELD(1, i)]),
		.in_val_d2	  (backw_in_val_d2[`VC_PORT_PICK_FIELD(1, i)]),

		.in_rdy_d1	  (backw_in_rdy_d1[`VC_PORT_PICK_FIELD(1, i)]),
		.in_rdy_d2	  (backw_in_rdy_d2[`VC_PORT_PICK_FIELD(1, i)]),
		.out_rdy	  (backw_out_rdy[`VC_PORT_PICK_FIELD(1, `NEXT(i))]),

		.out_msg_control	(backw_out_msg_control[`VC_PORT_PICK_FIELD(m,`NEXT(i))]),
		.in_msg_control_d1	(backw_in_msg_control_d1[`VC_PORT_PICK_FIELD(m, i)]),
		.in_msg_control_d2	(backw_in_msg_control_d2[`VC_PORT_PICK_FIELD(m, i)]),

		.out_msg_data		(backw_out_msg_data[`VC_PORT_PICK_FIELD(pd,`NEXT(i))]),
		.in_msg_data_d1		(backw_in_msg_data_d1[`VC_PORT_PICK_FIELD(pd, i)]),
		.in_msg_data_d2		(backw_in_msg_data_d2[`VC_PORT_PICK_FIELD(pd, i)])

	  );

    end
  endgenerate

endmodule

`endif /* PLAB4_NET_RING_NET_ALT */
