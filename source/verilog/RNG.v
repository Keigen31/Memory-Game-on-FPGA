
//RNG MODULE 
module RNG(clk, rst, RNG_Out, Data_In);
	input clk, rst, RNG_Out;
	output [3:0] Data_In;
	
	counter counter_instant(clk, rst, RNG_Out, Data_In);
endmodule

