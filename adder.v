module half_adder(
    input a,
    input b,
    output sum,
    output carry
);

assign sum = a ^ b;
assign carry = a & b;

endmodule

module full_adder(
    input a,
    input b,
    input carry_in,
    output sum,
    output carry_out
);

wire sum_1;
wire carry_out_1;
wire carry_out_2;

half_adder half_adder1(
    .a(a),
    .b(b),
    .sum(sum_1),
    .carry(carry_out_1)
);

half_adder half_adder2(
    .a(carry_in),
    .b(sum_1),
    .sum(sum),
    .carry(carry_out_2)
);

assign carry_out = carry_out_1 | carry_out_2;

endmodule

module adder4(
    input [3:0] a,
    input [3:0] b,
    input carry_in,
    output [3:0] sum,
    output carry_out
);
    wire sum_0;
    wire sum_1;
    wire sum_2;
    wire sum_3;

    wire carry_out_0;
    wire carry_out_1;
    wire carry_out_2;

    full_adder full_adder0(
        .a(a[0]),
        .b(b[0]),
        .carry_in(carry_in),
        .sum(sum_0),
        .carry_out(carry_out_0)
    );

    full_adder full_adder1(
        .a(a[1]),
        .b(b[1]),
        .carry_in(carry_out_0),
        .sum(sum_1),
        .carry_out(carry_out_1)
    );

    full_adder full_adder2(
        .a(a[2]),
        .b(b[2]),
        .carry_in(carry_out_1),
        .sum(sum_2),
        .carry_out(carry_out_2)
    );

    full_adder full_adder3(
        .a(a[3]),
        .b(b[3]),
        .carry_in(carry_out_2),
        .sum(sum_3),
        .carry_out(carry_out)
    );

    assign { sum_3, sum_2, sum_1, sum_0 } = sum;

endmodule

module adder8(
    input [7:0] a,
    input [7:0] b,
    input carry_in,
    output [7:0] sum,
    output carry_out
);

    wire [3:0] sum_0;
    wire [3:0] sum_1;

    wire carry_out_0;

    adder4 adder4_0(
        .a(a[3:0]),
        .b(b[3:0]),
        .carry_in(carry_in),
        .sum(sum_0),
        .carry_out(carry_out_0)
    );

    adder4 adder4_1(
        .a(a[7:4]),
        .b(b[7:4]),
        .carry_in(carry_out_0),
        .sum(sum_1),
        .carry_out(carry_out)
    );

    assign sum = { sum_1, sum_0 };

endmodule