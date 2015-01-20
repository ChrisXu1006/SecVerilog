//========================================================================
// Verilog Components: Muxes
//========================================================================

`ifndef VC_MUX2_V
`define VC_MUX2_V

//------------------------------------------------------------------------
// 2 Input Mux
//------------------------------------------------------------------------

module vc_Mux2
#(
  parameter p_nbits = 1
)(
  input      [p_nbits-1:0] {Domain in0_domain}	in0, 
  input		 [p_nbits-1:0] {Domain in1_domain}	in1,
  input		 [1:0]		   {L}					in0_domain,
  input		 [1:0]		   {L}					in1_domain,
  input                    {L}					sel,
  output reg [p_nbits-1:0] {Domain out_domain}	out
  //output	 [1:0]		   {L}					out_domain
);

  reg [1:0] {L}	out_domain;
  always @(*)
  begin
    case ( sel )
	  1'd0 : begin
			   out_domain = in0_domain;
			   out = in0;
		     end

	  1'd1 : begin
			   out_domain = in1_domain;
			   out = in1;
			 end

      default : out = {p_nbits{1'bx}};
    endcase
  end

endmodule

`endif /* VC_MUX2_V */

