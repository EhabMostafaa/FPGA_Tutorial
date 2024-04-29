`timescale 1ns/1ps
module   FIR_TESTBENCH;

//parameters
    parameter     INTEGER_BITS=2,
                  FRACTION_BITS=6,
                  EXTEND       =4,
                  NUMBER_OF_STAGES=7,
                  CLOCK_TB=4;
    
//ports
    reg                                    clk_tb;
    reg                                    rst_tb;
    reg  [INTEGER_BITS+FRACTION_BITS-1:0]  in_tb ;
    wire [INTEGER_BITS+FRACTION_BITS-1:0]  FIR_tb;
    


initial 
   begin
       $dumpfile("FIR.vcd");
       $dumpvars;    

      initialize();
      reset();

   if( FRACTION_BITS=='d16 && INTEGER_BITS=='d2 )
     begin

       //test 2 bits integer + 16 bits fractions    
   repeat(30)
   begin
     repeat(5)
       begin
       
     in_tb='b00_000000_0000_0000_00;         //0;
     #CLOCK_TB;
     in_tb='b00_000110_0001_1111_10;         //0.3827;
     #CLOCK_TB;
     in_tb='b00_001011_0101_0000_00;         //0.7071;
     #CLOCK_TB;
     in_tb='b00_001110_1100_1000_01;         //.9239;
     #CLOCK_TB;
     in_tb='b00_010000_0000_0000_00;         //1;
     #CLOCK_TB;
     in_tb='b00_001110_1100_1000_01;         //.9239;
     #CLOCK_TB;
     in_tb='b00_001011_0101_0000_00;         //0.7071;
     #CLOCK_TB;
     in_tb='b00_000110_0001_1111_10;         //0.3827;
     #CLOCK_TB;
       end 
       
     repeat(10)
       begin
     in_tb='b0000_0000_0000_0000_00;         //0;
     #CLOCK_TB;
     in_tb='b1111_1001_1110_0000_01;         //-0.3827;
     #CLOCK_TB;
     in_tb='b11_110100_1010_1111_11;         //-0.7071;
     #CLOCK_TB;
     in_tb='b11_110001_0011_0111_11;         //-.9239;
     #CLOCK_TB;
     in_tb='b11_110000_0000_0000_00;         //-1;
     #CLOCK_TB;
     in_tb='b11_110001_0011_0111_11;         //-.9239;
     #CLOCK_TB;
     in_tb='b11_110100_1010_1111_11;         //-0.7071;
     #CLOCK_TB;
     in_tb='b11_111001_1110_0000_01;         //-0.3827;
     #CLOCK_TB;
       end
   end
end


   else if(FRACTION_BITS=='d10 && INTEGER_BITS=='d2)
     begin
      
    //test 2 bits integer + 10 bits fractions    
   repeat(30)
   begin
     repeat(5)
       begin
       
     in_tb='b00_000000_0000;         //0;
     #CLOCK_TB;
     in_tb='b00_000110_0001;         //0.3827;
     #CLOCK_TB;
     in_tb='b00_001011_0101;         //0.7071;
     #CLOCK_TB;
     in_tb='b00_001110_1100;         //.9239;
     #CLOCK_TB;
     in_tb='b00_010000_0000;         //1;
     #CLOCK_TB;
     in_tb='b00_001110_1100;         //.9239;
     #CLOCK_TB;
     in_tb='b00_001011_0101;         //0.7071;
     #CLOCK_TB;
     in_tb='b00_000110_0001;         //0.3827;
     #CLOCK_TB;
       end 
       
     repeat(10)
       begin
     in_tb='b0000_0000_0000;         //0;
     #CLOCK_TB;
     in_tb='b1111_1001_1110;         //-0.3827;
     #CLOCK_TB;
     in_tb='b11_110100_1010;         //-0.7071;
     #CLOCK_TB;
     in_tb='b11_110001_0011;         //-.9239;
     #CLOCK_TB;
     in_tb='b11_110000_0000;         //-1;
     #CLOCK_TB;
     in_tb='b11_110001_0011;         //-.9239;
     #CLOCK_TB;
     in_tb='b11_110100_1010;         //-0.7071;
     #CLOCK_TB;
     in_tb='b11_111001_1110;         //-0.3827;
     #CLOCK_TB;
       end
   end
  end

   else if(FRACTION_BITS=='d8 && INTEGER_BITS=='d2)
     begin


//test 2 bits integer + 8 bits fractions    
   repeat(30)
   begin
     repeat(5)
       begin
       
     in_tb='b00_000000_00;         //0;
     #CLOCK_TB;
     in_tb='b00_000110_00;         //0.3827;
     #CLOCK_TB;
     in_tb='b00_001011_01;         //0.7071;
     #CLOCK_TB;
     in_tb='b00_001110_11;         //.9239;
     #CLOCK_TB;
     in_tb='b00_010000_00;         //1;
     #CLOCK_TB;
     in_tb='b00_001110_11;         //.9239;
     #CLOCK_TB;
     in_tb='b00_001011_01;         //0.7071;
     #CLOCK_TB;
     in_tb='b00_000110_00;         //0.3827;
     #CLOCK_TB;
       end 
       
     repeat(10)
       begin
     in_tb='b0000_0000_00;         //0;
     #CLOCK_TB;
     in_tb='b1111_1001_11;         //-0.3827;
     #CLOCK_TB;
     in_tb='b11_110100_10;         //-0.7071;
     #CLOCK_TB;
     in_tb='b11_110001_00;         //-.9239;
     #CLOCK_TB;
     in_tb='b11_110000_00;         //-1;
     #CLOCK_TB;
     in_tb='b11_110001_00;         //-.9239;
     #CLOCK_TB;
     in_tb='b11_110100_10;         //-0.7071;
     #CLOCK_TB;
     in_tb='b11_111001_11;         //-0.3827;
     #CLOCK_TB;
       end
   end
 
end

   else if(FRACTION_BITS=='d6 && INTEGER_BITS=='d2)
     begin

 //test 2 bits integer + 6 bits fractions    
      repeat(30)
   begin
     repeat(5)
       begin
       
     in_tb='b0000_0000;         //0;
     #CLOCK_TB;
     in_tb='b00_000110;         //0.3827;
     #CLOCK_TB;
     in_tb='b00_001011;         //0.7071;
     #CLOCK_TB;
     in_tb='b00_001110;         //.9239;
     #CLOCK_TB;
     in_tb='b00_010000;         //1;
     #CLOCK_TB;
     in_tb='b00_001110;         //.9239;
     #CLOCK_TB;
     in_tb='b00_001011;         //0.7071;
     #CLOCK_TB;
     in_tb='b00_000110;         //0.3827;
     #CLOCK_TB;
       end 
       
     repeat(10)
       begin
     in_tb='b0000_0000;         //0;
     #CLOCK_TB;
     in_tb='b1111_1001;         //-0.3827;
     #CLOCK_TB;
     in_tb='b11_110100;         //-0.7071;
     #CLOCK_TB;
     in_tb='b11_110001;         //-.9239;
     #CLOCK_TB;
     in_tb='b11_110000;         //-1;
     #CLOCK_TB;
     in_tb='b11_110001;         //-.9239;
     #CLOCK_TB;
     in_tb='b11_110100;         //-0.7071;
     #CLOCK_TB;
     in_tb='b1111_1001;         //-0.3827;
     #CLOCK_TB;
       end
       repeat(5)
       begin
       
     in_tb='b0000_0000;         //0;
     #CLOCK_TB;
     in_tb='b00_000110;         //0.3827;
     #CLOCK_TB;
     in_tb='b00_001011;         //0.7071;
     #CLOCK_TB;
     in_tb='b00_001110;         //.9239;
     #CLOCK_TB;
     in_tb='b00_010000;         //1;
     #CLOCK_TB;
     in_tb='b00_001110;         //.9239;
     #CLOCK_TB;
     in_tb='b00_001011;         //0.7071;
     #CLOCK_TB;
     in_tb='b00_000110;         //0.3827;
     #CLOCK_TB;
       end 
     
   end
end

repeat (20)      #CLOCK_TB;

       $stop; 
   end

//task initialize
    task initialize();
     begin
        clk_tb='b0;
        in_tb='b0;
        rst_tb='b1;
     end
    endtask

//task reset
    task reset();
      begin
    rst_tb='b1;
    #CLOCK_TB;
    rst_tb='b0;
    #CLOCK_TB;
    rst_tb='b1;
    #CLOCK_TB;    
      end 
    endtask



//clock generator 
    always #(CLOCK_TB/2)  clk_tb= ~clk_tb;
    

//module instantation
    FIR_TOP 
    #(
        .INTEGER_BITS     (INTEGER_BITS     ),
        .FRACTION_BITS    (FRACTION_BITS    ),
        .NUMBER_OF_STAGES (NUMBER_OF_STAGES ),
        .EXTEND           (EXTEND           )
    )
    u_FIR_TOP(
        .clk_top (clk_tb ),
        .rst_top (rst_tb ),
        .in_top  (in_tb  ),
        .FIR_out (FIR_tb )
    );

endmodule