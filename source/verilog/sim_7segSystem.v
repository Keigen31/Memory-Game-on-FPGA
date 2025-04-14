//ECE 6370/5440 - 10771
//MY TRAN, 5966
//7 SEGMENT DISPLAY MODULE
//THE MODULE IS BUILT AS A 4 TO 7 DECODER TO CHANGE 4-BIT BINARY INPUT NUMBER AND TRANSFORM THEM TO 7 SEGMENT. 
//ALL 7 SEGMENTS ARE USED TO MAKE UP A DIGITAL ANALOG NUMBER ON FPGA BOARD.
//DEPENDS ON WHAT NUMBER OR LETTER WE WANT TO CREATE, ASSIGN 0 TO TURN ON A SEGMENT, AND 1 TO TURN OFF THE OTHER UNWATED SEGMENT

module sim_7segSystem(userIn, Dout);
	input [3:0]userIn; 
	output [6:0] Dout;
	
	reg[6:0] Dout;
	

	always@(userIn)
	begin
		case(userIn)
			4'b0000: begin Dout = 7'b1000000; end
            	4'b0001: begin Dout = 7'b1111001; end
            	4'b0010: begin Dout = 7'b0100100; end
            	4'b0011: begin Dout = 7'b0110000; end
            	4'b0100: begin Dout = 7'b0011001; end
            	4'b0101: begin Dout = 7'b0010010; end
            	4'b0110: begin Dout = 7'b0000010; end
            	4'b0111: begin Dout = 7'b1111000; end
            	4'b1000: begin Dout = 7'b0000000; end
            	4'b1001: begin Dout = 7'b0011000; end
			4'b1010: begin Dout = 7'b0001000; end
            	4'b1011: begin Dout = 7'b0000011; end
            	4'b1100: begin Dout = 7'b1000110; end
            	4'b1101: begin Dout = 7'b0100001; end
            	4'b1110: begin Dout = 7'b0000110; end
            	4'b1111: begin Dout = 7'b0001110; end

		default: begin Dout = 7'b0000000; end
		
		endcase
	end

endmodule