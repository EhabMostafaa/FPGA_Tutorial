
module adder #(parameter INTEGER_BITS=2, FRACTION_BITS=6, EXTEND=8)
(
    input  wire signed [INTEGER_BITS+FRACTION_BITS+EXTEND-1:0] in1,
    input  wire signed [INTEGER_BITS+FRACTION_BITS+EXTEND-1:0] in2,
    input  wire sel,                                                 // sel=0 (subtraction) sel=1 (addition)
    output reg signed [INTEGER_BITS+FRACTION_BITS+EXTEND-1:0] result 
);


always @(*)
begin
    if(sel)
        result = in1 + in2;
    else
        result = in1 - in2;        
end

endmodule
