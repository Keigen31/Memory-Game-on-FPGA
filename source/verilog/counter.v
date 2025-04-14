module counter(clk, rst, count, Count_out);

	input clk, rst, count;
	output reg[3:0] Count_out;
	
	always @(posedge clk) begin
		if(rst == 1'b0) begin
			Count_out <= 4'b0000;
		end
		else begin
			if(count == 1'b1) begin
				if(Count_out == 4'b1111) begin
					Count_out <= 4'b000;
				end else begin
					Count_out <= Count_out + 1;
				end 
			end
		end
	end 
	
endmodule