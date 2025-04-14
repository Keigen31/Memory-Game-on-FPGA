
//DONE
module Difficulty_Selector(clk, rst, Easy_LED, Medium_LED, Hard_LED, Difficulty_In, Difficulty, LogIn,NumberTens);

	input clk, rst, LogIn, Difficulty_In;
	output reg Easy_LED, Medium_LED, Hard_LED;
	output reg[3:0] Difficulty,NumberTens;
	reg[2:0] State;
	parameter INIT = 0, MEDIUM = 1, HARD = 2,EASY = 3;
	
	always @(posedge clk) begin
		if(rst == 1'b0) begin
			Easy_LED <= 1'b0;
			Medium_LED <= 1'b0;
			Hard_LED <= 1'b0;
			Difficulty <= 4'b0000;
			NumberTens <= 4'b0000;
			State <= INIT;
		end
		else begin
			case(State)
				INIT: begin
				if(LogIn == 1'b1) begin
					State<= EASY;
					end
					else
						State <= INIT;
				end
				EASY:begin 					
					Easy_LED <= 1'b1;
					Medium_LED <= 1'b0;
					Hard_LED <= 1'b0;
					Difficulty <= 4'b0011;
					NumberTens <= 4'b0100;
					if(Difficulty_In == 1'b1)
						State <= MEDIUM;
					else
						State <= EASY;end
				MEDIUM: begin
					Easy_LED <= 1'b0;
					Medium_LED <= 1'b1;
					Hard_LED <= 1'b0;
					Difficulty <= 4'b0101;
					NumberTens <= 4'b0011;
					if(Difficulty_In == 1'b1)
						State <= HARD;
					else
						State <= MEDIUM;
				end
				HARD: begin
					Easy_LED <= 1'b0;
					Medium_LED <= 1'b0;
					Hard_LED <= 1'b1;
					Difficulty <= 4'b0111;
					NumberTens <= 4'b0011;
					if(Difficulty_In == 1'b1)
						State <= INIT;
					else
						State <= HARD;
				end
				default: begin
					Easy_LED <= 1'b0;
					Medium_LED <= 1'b0;
					Hard_LED <= 1'b0;
					Difficulty <= 4'b0000;
					NumberTens <= 4'b1001;
					State <= INIT;
			
				end
			endcase
		end
	end 	
endmodule
		
	