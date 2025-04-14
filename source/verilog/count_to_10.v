//ECE 5440
//MY TRAN - UH ID 2095966
//The One Sec count_t0_10 module 

module count_to_10(enable, clk, rst, timeout);
    input clk, rst, enable;
    output reg timeout;
    reg [3:0] count_10;
    
    always @(posedge clk) begin
        if (rst == 1'b0) begin
            count_10 <= 0;
            timeout <= 1'b0;
        end
        else begin
            if (enable == 1'b1) begin
                if (count_10 == 9) begin
                    count_10 <= 0;
                    timeout <= 1'b1;
                end
                else begin
                    count_10 <= count_10 + 1'b1;
                    timeout <= 1'b0;
                end
            end
            else begin
                timeout <= 1'b0;
            end
        end
    end
endmodule