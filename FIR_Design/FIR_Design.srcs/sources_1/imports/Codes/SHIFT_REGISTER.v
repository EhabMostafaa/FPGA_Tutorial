
module shift_Register #(parameter INTEGER_BITS=2 , FRACTION_BITS=6 , NUMBER_OF_STAGES=7)
          ( input    wire                                           clk,
            input    wire                                           rst,   
            input    wire        [INTEGER_BITS+FRACTION_BITS-1:0]   in,
 
            output  reg          [INTEGER_BITS+FRACTION_BITS-1:0]   reg0, 
            output  reg          [INTEGER_BITS+FRACTION_BITS-1:0]   reg1, 
            output  reg          [INTEGER_BITS+FRACTION_BITS-1:0]   reg2, 
            output  reg          [INTEGER_BITS+FRACTION_BITS-1:0]   reg3, 
            output  reg          [INTEGER_BITS+FRACTION_BITS-1:0]   reg4, 
            output  reg          [INTEGER_BITS+FRACTION_BITS-1:0]   reg5, 
            output  reg          [INTEGER_BITS+FRACTION_BITS-1:0]   reg6,
            output  reg          [INTEGER_BITS+FRACTION_BITS-1:0]   reg7         
              );


reg     [INTEGER_BITS+FRACTION_BITS-1:0]  reg_file  [NUMBER_OF_STAGES-1:0];
integer i;

always@(posedge clk or negedge rst)
     begin
         if(!rst)
            begin
               for(i=0 ; i<NUMBER_OF_STAGES ; i=i+1)
                  begin
                    reg_file[i]<='b0;
                  end
            end
          
         else
             begin
                 for (i=0 ; i<(NUMBER_OF_STAGES-1) ; i=i+1)
                  begin
                    reg_file[0]  <=in;
                    reg_file[i+1]<=reg_file[i];
                  end
             end 
     end


always @(*) 
   begin
       reg0=in;
       reg1=reg_file[0];
       reg2=reg_file[1];
       reg3=reg_file[2];
       reg4=reg_file[3];
       reg5=reg_file[4];
       reg6=reg_file[5];
       reg7=reg_file[6];
    end
endmodule

