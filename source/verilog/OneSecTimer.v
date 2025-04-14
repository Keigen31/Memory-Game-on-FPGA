//ECE 5440
//MY TRAN - UH ID 2095966
//the One Sec Timer top level module
 module OneSecTimer(enable, clk, rst, oneSec_pulse);
	input enable, clk, rst;
	output oneSec_pulse;

	wire timeout_100ms;
	wire timeout_1ms;
	
   count_1ms_LFSR count_1ms_LFSR_1(enable, clk, rst, timeout_1ms);
	count_to_100 count_to_100_instant(timeout_1ms, clk, rst, timeout_100ms);
   count_to_10 count_to_10_instant(timeout_100ms, clk, rst, oneSec_pulse);

	
endmodule
