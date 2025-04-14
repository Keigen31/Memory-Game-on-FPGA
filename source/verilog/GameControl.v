module GameControl(clk, rst, Load_P1_In, Difficulty, RNG_Out, Load_P1_Out, Reconfig, Timer_enable, Timeout, 
PWGS,Data_In,digit_config,score_up,Data_Out,userNum,Difficulty_In); 
	input clk, rst, Load_P1_In, Timeout, PWGS,Difficulty_In; 
	input [3:0] userNum,Difficulty, Data_In;
	//in authentiation module, difficulty will equal 0 if not passed
	//Pass_Segment(Passed_Logo, Pass_LED)
	//i(Passed_Logo ==1'b1) P and L 
	output reg Timer_enable, Reconfig, RNG_Out, Load_P1_Out,digit_config,score_up;
	output reg[3:0] Data_Out;
	reg[3:0] mode_counter, player_counter;
	
	reg[4:0]address;
	reg [3:0] data;
	wire [3:0] q;
	reg RW; //read write signal for RAM
	//1 is write, 0 is read
	reg enable;
	wire oneSec_pulse;
	reg[3:0] State; //4'b0000
	parameter Config_Timer = 0, Prepare = 1, RAMCall = 2,Wait1= 3,Wait2=4,RAMCatch = 5, Player_Turn = 6, Failed = 7, Passed = 8, Win = 9, 
	Over = 10;
	
	//instantiate the RAM module
	RAM_Digits DUT_RAM_Digits(address, clk, data, RW, q);

	//instantiate one second timer for wait function
	OneSecTimer OneSecTimerWait(enable,clk,rst,oneSec_pulse);
	always @(posedge clk) begin
		if(rst == 1'b0) begin 
			enable <= 1'b0;
			Timer_enable <= 1'b0;
			Data_Out <= 4'b0000;
			data <= 4'b0000;
			Load_P1_Out <= 1'b0;
			RNG_Out <= 1'b0;
			Reconfig <= 1'b1;
			mode_counter <= Difficulty;
			player_counter <= Difficulty;
			address <= 5'b00000;
			RW <= 1'b1;
			digit_config <=1'b1;
			score_up <= 1'b0;
			State <= Config_Timer;
		end 
		else 	
              case(State)
				Config_Timer: begin
					if(Difficulty != 1'b0) begin
						Load_P1_Out <= 1'b0;
						RNG_Out <= 1'b0;
						Reconfig <= 1'b1;
						mode_counter <= Difficulty;
						player_counter <= Difficulty;
						address <= 5'b00000;
						RW <= 1'b1;
						score_up <= 1'b0;
						digit_config <=1'b1;
						State <= Prepare;
					end
					else 
					State <= Config_Timer;
				end
				Prepare: begin
					RNG_Out <= 1'b1;
					Reconfig <= 1'b0;
					digit_config <=1'b0;
					enable <= 1'b1;
					if(Difficulty_In == 1'b1) begin
						Reconfig <= 1'b1;end
					if(PWGS == 1'b1) begin
						State <= RAMCall;
						mode_counter <= Difficulty;
						player_counter<= Difficulty;
					end
					else begin
						State <= Prepare;
					end
				end
				RAMCall: begin
					RNG_Out <= 1'b1;
					Load_P1_Out <= 1'b0;
					RW <= 1'b1;
					State <= Wait1;
					end
				Wait1: begin State<= Wait2;end
				Wait2: begin 
					State <= RAMCatch; end
				RAMCatch: begin
					data <= Data_In;
					Data_Out <= Data_In;
					if(oneSec_pulse == 1'b1) begin
					address <= address + 1'b1;
					mode_counter <= mode_counter - 1'b1;
					if(mode_counter != 0) begin
					State <= RAMCall; end
					else
						State <= Player_Turn;
						address <= 5'b00000;
					end
					else
						State<= RAMCatch;
				end
				Player_Turn: begin
					score_up <= 1'b0;
					Timer_enable <= 1'b1;
					Load_P1_Out <= Load_P1_In;
					if(Load_P1_In == 1'b1) begin 
						if (userNum == q)
							State <= Passed;
						else
							State <= Failed; end
				    
				end
				Failed: begin
					score_up <= 1'b0;
					State <= Over;
				end
				Passed: begin
					player_counter <= player_counter - 1'b1;
					address <= address + 1'b1;
					if(player_counter != 0) begin
						State <= Player_Turn;
						score_up <= 1'b1; end
					else begin
						State <= Win; end
				
				end
				Win: begin
					//display passed
					State <= Over;
				end				
				Over: begin
					Timer_enable <= 1'b0;
					Load_P1_Out <= 1'b0;
					RNG_Out <= 1'b0;
					digit_config <=1'b1;
					if(PWGS == 1'b1)
						State <= Config_Timer;
					else
						State <= Over;
			    end        
				default: begin
					Load_P1_Out <= 1'b0;
					RNG_Out <= 1'b0;
					Reconfig <= 1'b1;
					mode_counter <= Difficulty;
					player_counter <= Difficulty;
					address <= 5'b00000;
					RW <= 1'b1;
					State <= Config_Timer;
				end
            endcase
        end
endmodule