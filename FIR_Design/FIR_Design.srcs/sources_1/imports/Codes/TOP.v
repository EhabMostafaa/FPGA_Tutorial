module FIR_TOP #(
    parameter INTEGER_BITS=2 , FRACTION_BITS=6 ,EXTEND=4, NUMBER_OF_STAGES=7)
 ( 
    input      wire                                                    clk_top,
    input      wire                                                    rst_top,
    input      wire  signed        [INTEGER_BITS+FRACTION_BITS-1:0]    in_top,
    
    output     wire  signed        [INTEGER_BITS+FRACTION_BITS-1:0]    FIR_out       

);
    

wire  signed     [INTEGER_BITS+FRACTION_BITS+EXTEND-1:0]    multipliers_results [5:0];
wire  signed     [INTEGER_BITS+FRACTION_BITS+EXTEND-1:0]    adder_results[5:0]; 

wire  signed     [INTEGER_BITS+FRACTION_BITS-1:0]    reg0 ,reg1 ,reg2  ,reg3  ,reg4  ,reg5  ,reg6  ,reg7 ; 
  
wire  signed     [INTEGER_BITS+FRACTION_BITS+EXTEND-1:0]    immediate;  
  
    shift_Register 
    #(
        .INTEGER_BITS     (INTEGER_BITS     ),
        .FRACTION_BITS    (FRACTION_BITS    ),
        .NUMBER_OF_STAGES (NUMBER_OF_STAGES )
    )
    u_shift_Register(
    	.clk   (clk_top   ),
        .rst   (rst_top   ),
        .in    (in_top    ),
        .reg0  (reg0      ),
        .reg1  (reg1      ),
        .reg2  (reg2      ),
        .reg3  (reg3      ),
        .reg4  (reg4      ),
        .reg5  (reg5      ),
        .reg6  (reg6      ),
        .reg7  (reg7      )
            );
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//multiply by 0.3827
multiplier1 
#(
    .INTEGER_BITS  (INTEGER_BITS  ),
    .EXTEND        (EXTEND        ),
    .FRACTION_BITS (FRACTION_BITS )
    )
first_multiplier1(
    .in1   (reg1   ),
    .mult1 (multipliers_results[0] )
);

multiplier1 
#(
    .INTEGER_BITS  (INTEGER_BITS  ),
    .EXTEND        (EXTEND        ),
    .FRACTION_BITS (FRACTION_BITS )
)
second_multiplier1(
    .in1   (reg7   ),
    .mult1 (multipliers_results[1] )
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//multiply by 0.7071
multiplier2 
#(
    .INTEGER_BITS  (INTEGER_BITS  ),
    .EXTEND        (EXTEND        ),
    .FRACTION_BITS (FRACTION_BITS )
    )
first_multiplier2(
    .in2   (reg2   ),
    .mult2 (multipliers_results[2] )
);

multiplier2 
#(
    .INTEGER_BITS  (INTEGER_BITS  ),
    .EXTEND        (EXTEND        ),
    .FRACTION_BITS (FRACTION_BITS )
    )
second_multiplier2(
    .in2   (reg6   ),
    .mult2 (multipliers_results[3] )
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//multiply by 0.9239
multiplier3 
#(
    .INTEGER_BITS  (INTEGER_BITS  ),
    .EXTEND        (EXTEND        ),
    .FRACTION_BITS (FRACTION_BITS )
    )
first_multiplier3(
    .in3   (reg3   ),
    .mult3 (multipliers_results[4] )
);

multiplier3 
#(
    .INTEGER_BITS  (INTEGER_BITS  ),
    .EXTEND        (EXTEND        ),
    .FRACTION_BITS (FRACTION_BITS )
    )
second_multiplier3(
    .in3   (reg5   ),
    .mult3 (multipliers_results[5] )
);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//adder result
adder 
#(
    .INTEGER_BITS  (INTEGER_BITS  ),
    .FRACTION_BITS (FRACTION_BITS ),
    .EXTEND        (EXTEND        )
)
u_adder1(
    .in1    ({reg4,4'b0}),                        //WARNING it is multiplied by 1 so we not used multiplier and it must be extended 
    .in2    (multipliers_results[0]    ),
    .sel    (1'b1                  ),

    .result (adder_results[0] )
);

genvar j;
generate
    for (j=1  ;j<6 ; j=j+1) 
      begin
        adder 
       #(
        .INTEGER_BITS  (INTEGER_BITS  ),
        .FRACTION_BITS (FRACTION_BITS ),
        .EXTEND        (EXTEND        )
       )
       u_adder(
       	.in1    (adder_results[j-1]    ),
        .in2    (multipliers_results[j]),
        .sel    (1'b1                  ),
        .result (adder_results[j] )
       );

      end
endgenerate
assign immediate=adder_results[5];
assign FIR_out=immediate[INTEGER_BITS+FRACTION_BITS+EXTEND-1:EXTEND];

endmodule
