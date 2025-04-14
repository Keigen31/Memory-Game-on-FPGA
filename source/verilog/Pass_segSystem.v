
//DONE
module Pass_segSystem(PassIn, Dout);
	input PassIn; 
	output [6:0] Dout;
	
	reg[6:0] Dout;
	
	always@(PassIn)
	begin
		if(PassIn == 1'b1);
			Dout = 7'b0001100;
			
	end
endmodule