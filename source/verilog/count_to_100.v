//ECE 5440
//MY TRAN - UH ID 2095966
//the One Sec Timer count_to_100 module
module count_to_100(enable, clk, rst, timeout);
    input clk, rst, enable;
    output reg timeout;
    reg [7:0] count_100;
    
    always @(posedge clk) begin
        if (rst == 1'b0) begin
            count_100 <= 0;
            timeout <= 1'b0;
        end
        else begin
            if (enable == 1'b1) begin
                if (count_100 == 99) begin
                    count_100 <= 0;
                    timeout <= 1'b1;
                end
                else begin
                    count_100 <= count_100 + 1'b1;
                    timeout <= 1'b0;
                end
            end
            else begin
                timeout <= 1'b0;
            end
        end
    end
endmodule
