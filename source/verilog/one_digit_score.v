module one_digit_score(digit, carry_out, carry_in, digit_config, clk, rst);
	input  carry_in, digit_config, clk, rst; //digit_config can be modified into 10'd
	output carry_out;
	output [3:0] digit;
	
	reg carry_out;
	reg [3:0] digit;
	
	always @(posedge clk)
	begin
		if (rst == 1'b0)
		begin
			digit <= 4'd0;
			carry_out <= 1'b0;				
		end
		else
		begin
			if (digit_config == 1'b1)
			begin
				digit <= 4'd0;
				carry_out <= 1'b0;				
			end
			
			if (carry_in == 1'b1)
			begin
				if (digit < 4'd8)
					digit <= digit + 4'd1;

				if (digit == 4'd8)
				begin
					digit <= digit + 4'd1;
					carry_out <= 1'b1;
				end
				
				if (digit == 4'd9)
				begin
					digit <= 1'b0;
					carry_out <= 1'b0;					
				end			
			end
			else
			begin
				carry_out <= 1'b0;
			end
		end
	end	
endmodule

