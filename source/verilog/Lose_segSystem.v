//DONE

module Lose_segSystem(LoseIn, Dout);
	input LoseIn; 
	output [6:0] Dout;
	
	reg[6:0] Dout;
	

	always@(LoseIn)
	begin
		if(LoseIn == 1'b1);
			Dout = 7'b1110001;
			
	end
endmodule