module quant_binary_vqe();
//-----------------------------------------------------------------------------
// const + const
//-----------------------------------------------------------------------------
wire [1:0] {L} a;
wire [1:0] {|i| Par 0 + 0} b;
//unsat
assign a[0] = b[0];

wire [1:0] {L} c;
wire [1:0] {|i| Par 0 + 1} d;
//sat
assign c[0] = d[0];

wire [1:0] {L} e;
wire [1:0] {|i| Par 0 + 1 + 0} f;
//sat
assign e[0] = f[0];

//-----------------------------------------------------------------------------
// const - const
//-----------------------------------------------------------------------------
wire [1:0] {L} h;
wire [1:0] {|i| Par 0 - 0} i;
//unsat
assign h[0] = i[0];

wire [1:0] {L} j;
wire [1:0] {|i| Par 1 - 0} k;
//sat
assign j[0] = k[0];

wire [1:0] {L} l;
wire [1:0] {|i| Par 1 - 1 + 1} m;
//sat
assign l[0] = m[0];

endmodule