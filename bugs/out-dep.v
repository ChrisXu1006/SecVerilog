`include "sub.v"
module top();

reg {Domain in_domain}  in;
reg {L}                 in_domain;
reg {Domain out_domain} out;
reg {L}                 out_domain;

dep_sub sub
(
    .in         (in),
    .in_level   (in_domain),
    .out        (out),
    .out_level  (out_domain)
);

endmodule

