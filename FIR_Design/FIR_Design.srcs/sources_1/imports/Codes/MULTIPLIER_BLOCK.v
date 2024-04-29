// multiply by 0.3827
module multiplier1 #(parameter INTEGER_BITS=2, FRACTION_BITS=6 , EXTEND=4)
(
    input wire signed [INTEGER_BITS+FRACTION_BITS-1:0] in1,
    output wire signed [INTEGER_BITS+FRACTION_BITS+EXTEND-1:0] mult1 
);


wire signed [INTEGER_BITS+FRACTION_BITS+3-1:0] stage0;
wire signed [INTEGER_BITS+FRACTION_BITS+7-1:0] stage1;


adder #(.INTEGER_BITS(INTEGER_BITS), .FRACTION_BITS(FRACTION_BITS), .EXTEND(3))
    u0 (
        .in1( {in1[INTEGER_BITS+FRACTION_BITS-1] , in1 , 2'b0} ),   //in_extend>>>1
        .in2( {{3{in1[INTEGER_BITS+FRACTION_BITS-1]}} , in1}),    //in_extend>>>3
        .sel('b0),                                              //subtract
        .result(stage0)
        );

adder #(.INTEGER_BITS(INTEGER_BITS), .FRACTION_BITS(FRACTION_BITS), .EXTEND(7))
    u1 (
        .in1({stage0, 4'b0}),
        .in2({{7{in1[INTEGER_BITS+FRACTION_BITS-1]}}, in1}),  //in_extend>>>7  
        .sel('b1),                                            //addition
        .result(stage1)
        );

assign mult1=stage1[INTEGER_BITS+FRACTION_BITS+7-1:3] ;        // output is 12 bits  [14:3]
endmodule

////////////////////******************************************/////////////
// multiply by 0.7071
module multiplier2 #(parameter INTEGER_BITS=2, FRACTION_BITS=6, EXTEND=4)
(
    input  wire signed [INTEGER_BITS+FRACTION_BITS-1  :0]  in2,
    output wire signed [INTEGER_BITS+FRACTION_BITS+EXTEND-1:0]  mult2 
);

wire signed [INTEGER_BITS+FRACTION_BITS+2-1:0] stage0;
wire signed [INTEGER_BITS+FRACTION_BITS+4-1:0] stage1;
wire signed [INTEGER_BITS+FRACTION_BITS+6-1:0] stage2;
wire signed [INTEGER_BITS+FRACTION_BITS+8-1:0] stage3;

adder #(.INTEGER_BITS(INTEGER_BITS), .FRACTION_BITS(FRACTION_BITS), .EXTEND(2))
u0 (
    .in1( {in2 , 2'b0} ), //in_extend
    .in2( {{2{in2[INTEGER_BITS+FRACTION_BITS-1]}}, in2} ),   //in_extend>>>2
    .sel('b0),                                               //subtract
    .result(stage0)
);

adder #(.INTEGER_BITS(INTEGER_BITS), .FRACTION_BITS(FRACTION_BITS), .EXTEND(4))
u1 (
    .in1( {stage0, 2'b0} ),
    .in2( {{4{in2[INTEGER_BITS+FRACTION_BITS-1]}}, in2} ),  //in_extend>>>4  
    .sel('b0),                                            //subtraction
    .result(stage1)
);

adder #(.INTEGER_BITS(INTEGER_BITS), .FRACTION_BITS(FRACTION_BITS), .EXTEND(6))
u2 (
    .in1( {stage1, 2'b0} ),
    .in2( {{6{in2[INTEGER_BITS+FRACTION_BITS-1]}}, in2} ),  //in_extend>>>6  
    .sel('b1),                                            //addition
    .result(stage2)
);

adder #(.INTEGER_BITS(INTEGER_BITS), .FRACTION_BITS(FRACTION_BITS), .EXTEND(8))
u3 (
    .in1( {stage2, 2'b0} ),
    .in2( {{8{in2[INTEGER_BITS+FRACTION_BITS-1]}}, in2} ),  //in_extend>>>8  
    .sel('b1),                                            //Addition
    .result(stage3)
);

assign mult2 = stage3[INTEGER_BITS+FRACTION_BITS+8-1:4];           // output 12 bits [15:4]

endmodule




// multiply by 0.9239
module multiplier3 #(parameter INTEGER_BITS=2, FRACTION_BITS=6, EXTEND=4)
(
    input  wire signed [INTEGER_BITS+FRACTION_BITS-1:0]   in3,
    output wire signed [INTEGER_BITS+FRACTION_BITS+EXTEND-1:0] mult3 
);

wire signed [INTEGER_BITS+FRACTION_BITS+4-1:0] stage0;
wire signed [INTEGER_BITS+FRACTION_BITS+6-1:0] stage1;
wire signed [INTEGER_BITS+FRACTION_BITS+9-1:0] stage2;

adder #(.INTEGER_BITS(INTEGER_BITS), .FRACTION_BITS(FRACTION_BITS), .EXTEND(4))
u0 (
    .in1( {in3 , 4'b0} ), //in_extend
    .in2( {{4{in3[INTEGER_BITS+FRACTION_BITS-1]}}, in3} ),   //in_extend>>>4
    .sel('b0),                                             //subtract
    .result(stage0)
);

adder #(.INTEGER_BITS(INTEGER_BITS), .FRACTION_BITS(FRACTION_BITS), .EXTEND(6))
u1 (
    .in1( {stage0, 2'b0} ),
    .in2( {{6{in3[INTEGER_BITS+FRACTION_BITS-1]}}, in3} ),  //in_extend>>>6  
    .sel('b0),                                            //subtraction
    .result(stage1)
);

adder #(.INTEGER_BITS(INTEGER_BITS), .FRACTION_BITS(FRACTION_BITS), .EXTEND(9))
u2 (
    .in1( {stage1, 3'b0} ),
    .in2( {{9{in3[INTEGER_BITS+FRACTION_BITS-1]}}, in3} ),  //in_extend>>>9  
    .sel('b1),                                            //subtraction
    .result(stage2)
);

assign mult3 =stage2[INTEGER_BITS+FRACTION_BITS+9-1:5];   //output [16:5]
endmodule
