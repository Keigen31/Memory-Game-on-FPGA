module two_digit_score(score_up, digit_config, ten_place, unit_place, clk, rst);
	input score_up, digit_config, clk, rst;
	output [3:0] ten_place, unit_place;
		
	wire digit_0_carry_out;
	wire digit_1_carry_out;	
		
	one_digit_score digit_0(unit_place, digit_0_carry_out, score_up, digit_config, clk, rst);
	one_digit_score digit_1(ten_place, digit_1_carry_out, digit_0_carry_out, digit_config, clk, rst);

endmodule
