module dep_sub
(
    input   {Domain in_level} in,
    input   {L}               in_level,
    output  {Domain in_level} out,
    output  {L}               out_level
);

    reg {Domain in_level} out;
    reg {L}               out_level;

    always @(*) begin
        out = in;
        out_level = in_level;
    end
endmodule
