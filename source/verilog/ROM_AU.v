module ROM_AU(clk, rst, PWDigits, PWGS, LogIn, LogOut); 

	input clk, rst, PWGS; 
	input[3:0] PWDigits;
	output LogIn, LogOut;
	wire[4:0] address;
	wire[3:0] q;
	
	//module ROM_PSWD (address,clock,q);
	ROM_PSWD ROM_PSWD(address, clk, q);
	
	//module Authentiation(clk, rst, PWGS, PWdigits, adress, q, LogIn, LogOut);
	Authentication Authentication_1(clk, rst, PWGS, PWDigits, address, q, LogIn, LogOut);
	
endmodule