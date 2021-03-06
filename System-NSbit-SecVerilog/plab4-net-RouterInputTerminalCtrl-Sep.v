//========================================================================
// Router Input Terminal Ctrl
//========================================================================

`ifndef PLAB4_NET_ROUTER_INPUT_TERMINAL_CTRL_SEP_V
`define PLAB4_NET_ROUTER_INPUT_TERMINAL_CTRL_SEP_V

//+++ gen-harness : begin cut ++++++++++++++++++++++++++++++++++++++++++++
`include "plab4-net-GreedyRouteCompute.v"
//+++ gen-harness : end cut ++++++++++++++++++++++++++++++++++++++++++++++

module plab4_net_RouterInputTerminalCtrl_Sep
#(
  parameter p_router_id      = 0,
  parameter p_num_routers    = 8,
  parameter p_num_free_nbits = 2,

  // parameter not meant to be set outside this module

  parameter c_dest_nbits = $clog2( p_num_routers )

)
(
  input                        {L} domain,

  input  [c_dest_nbits-1:0]    {Domain domain} dest,

  input                        {Domain domain} in_val,
  output                       {Domain domain} in_rdy,

  input [p_num_free_nbits-1:0] {Domain domain} num_free_west,
  input [p_num_free_nbits-1:0] {Domain domain} num_free_east,

  output					   {Domain domain} reqs_p0,
  output					   {Domain domain} reqs_p1,
  output					   {Domain domain} reqs_p2,

  input		                   {Domain domain} grants_p0,
  input						   {Domain domain} grants_p1,
  input						   {Domain domain} grants_p2
);

  //+++ gen-harness : begin insert +++++++++++++++++++++++++++++++++++++++
// 
//   // add logic here
// 
//   assign in_rdy = 0;
//   assign reqs = 0;
// 
  //+++ gen-harness : end insert +++++++++++++++++++++++++++++++++++++++++

  //+++ gen-harness : begin cut ++++++++++++++++++++++++++++++++++++++++++

  wire [1:0] {Domain domain} route;

  //----------------------------------------------------------------------
  // Greedy Route Compute
  //----------------------------------------------------------------------

  plab4_net_GreedyRouteCompute
  #(
    .p_router_id    (p_router_id),
    .p_num_routers  (p_num_routers)
  )
  route_compute
  (
    .domain         (domain),
    .dest           (dest),
    .route          (route)
  );

  //----------------------------------------------------------------------
  // Combinational logic
  //----------------------------------------------------------------------

  // rdy is just a reductive OR of the AND of reqs and grants

  assign in_rdy = | (reqs & grants);

  wire [2:0] {Domain domain} reqs;
  wire [2:0] {Domain domain} grants;

  assign {reqs_p2, reqs_p1, reqs_p0} = reqs;
  assign grants = {grants_p2, grants_p1, grants_p0};

  always @(*) begin
    if (in_val) begin

      case (route)
        // the following implements bubble flow control:
        `ROUTE_PREV:  reqs = (num_free_east > 1) ? 3'b001 : 3'b000;
        `ROUTE_TERM:  reqs = 3'b010;
        `ROUTE_NEXT:  reqs = (num_free_west > 1) ? 3'b100 : 3'b000;

        // the following doesn't implement bubble flow control:
        // `ROUTE_PREV:  reqs = 3'b001;
        // `ROUTE_TERM:  reqs = 3'b010;
        // `ROUTE_NEXT:  reqs = 3'b100;
      endcase

    end else begin
      // if !val, we don't request any output ports
      reqs = 3'b000;
    end
  end

  //+++ gen-harness : end cut ++++++++++++++++++++++++++++++++++++++++++++

endmodule

`endif  /* PLAB4_NET_ROUTER_INPUT_TERMINAL_CTRL_SEP_V */

