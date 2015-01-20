module vc_mux3
#(
	parameter pnbits = 1
)
(
	input	[pnbits-1:0]	{Domain L0}	in0,
	input	[pnbits-1:0]  	{Domain L1}	in1,
	input	[pnbits-1:0]  	{Domain L2}	in2,
	input					{L}			L0,
	input					{L}			L1,
	input					{L}			L2,
	input	[1:0]			{L}			sel,
	output	[pnbits-1:0]	{SEL sel}	out
);
	
	reg		[pnbits-1:0]	{SEL sel}	out;

	always @(*) begin
		if ( sel == 2'b00 )
			out <= in0;
		
		else if ( sel == 2'b01 )
			out <= in1;
		
		else if ( sel == 2'b10 )
			out <= in2;

		else
			out <= 'hx;
	end

endmodule
