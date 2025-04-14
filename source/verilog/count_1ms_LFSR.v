//ECE 5440
//MY TRAN - UH ID 2095966
//the One Sec Timer testbench but with LFSR modification 
module count_1ms_LFSR(enable, clk,rst, timeout);
  input clk, rst;
  output reg timeout;
  input enable; 
  reg [15:0] LFSR;
  wire feedback = LFSR[15];
  always @(posedge clk)
  begin
	if(rst == 1'b0) begin
		LFSR <= 16'hFFFF; 
		timeout <= 1'b0; 
	end 
	else begin 
	if(enable == 1'b1) begin 
		if(LFSR == 16'b0110110110110110) begin //change this after 2nd simul
			LFSR <= 16'hFFFF; 
			timeout <= 1'b1;
		 end
		else begin
		timeout <= 1'b0;
		LFSR[0] <= feedback;
		LFSR[1] <= LFSR[0];
		LFSR[2] <= LFSR[1] ^ feedback;
		LFSR[3] <= LFSR[2] ^ feedback;
		LFSR[4] <= LFSR[3];
		LFSR[5] <= LFSR[4] ^ feedback;
		LFSR[6] <= LFSR[5];
		LFSR[7] <= LFSR[6];
		LFSR[8] <= LFSR[7];
		LFSR[9] <= LFSR[8];
		LFSR[10] <= LFSR[9];
		LFSR[11] <= LFSR[10];
		LFSR[12] <= LFSR[11];
		LFSR[13] <= LFSR[12];
		LFSR[14] <= LFSR[13];
		LFSR[15] <= LFSR[14];
		end end end end
endmodule