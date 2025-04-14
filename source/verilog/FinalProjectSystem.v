

//TOP MODULE FOR FINAL PROJECT LAB

module FinalProjectSystem(clk, rst,PWGS, PWdigits,LogIn, LogOut, Easy_LED, Medium_LED, Hard_LED, Difficulty_button, User_num,
DUser, DRNG, Done, DTen, DScore_Ones,DScore_Tens, Player_button);

//Buttons
input PWGS,Difficulty_button,Player_button,rst;
// Input Switches
input [3:0] PWdigits, User_num;
// Seven Segment Display
output [6:0] DRNG,Done,DTen,DUser,DScore_Ones,DScore_Tens;
wire [6:0] DRNG,Done,DTen,DUser,DScore_Ones,DScore_Tens;
//LED
output Easy_LED, Medium_LED, Hard_LED,LogIn,LogOut;

//Clk
input clk;

//Wires
wire PW_In,Difficulty_In,Load_P1_In,LogIn,RNG_Out,reconfig,timer_enable,timeout,digit_config,score_up,Load_P1_Out,oneSec_pulse;
wire [3:0] Difficulty,NumberTens,Data_Out,User_num_Out,ten_place,unit_place,digit_ones,digit_tenth,State,Data_In,TestDisplay2;


//PW entering button
ButtonShaper PWGSButtonShaper(PWGS, PW_In, clk, rst);
//Dificulty button
ButtonShaper DifficultyButtonShaper(Difficulty_button, Difficulty_In, clk, rst);
//User's number load in
ButtonShaper PlayerButttonShaper(Player_button, Load_P1_In, clk, rst);

//Authentiation module for password
ROM_AU PWAuthentication(clk, rst, PWdigits, PW_In, LogIn, LogOut);

//Selecting the game difficulty mode
Difficulty_Selector Difficulty_SelectorM(clk, rst, Easy_LED, Medium_LED, Hard_LED, Difficulty_In, Difficulty, LogIn,NumberTens);

//the game controller 
GameControl GameController(clk, rst, Load_P1_In, Difficulty, RNG_Out, Load_P1_Out, reconfig, timer_enable, timeout, 
PW_In,Data_In,digit_config,score_up,Data_Out,User_num,Difficulty_In);
//Score Tracker
two_digit_score ScoreTracker(score_up,digit_config,ten_place,unit_place,clk,rst);

//LSFR RNG
LFSRRng RNGGenerator(clk, rst, Data_In,RNG_Out);

//Timer 
OneSecTimer OneSecondTimerDigit(timer_enable,clk,rst,oneSec_pulse);
//Digit Timer MODULE
Two_Digit_Timer TimerModule(clk, rst, reconfig, oneSec_pulse, timeout, digit_ones, digit_tenth,NumberTens);

//Load register for user button 
LoadRegister LoadRegister(User_num, User_num_Out, clk, rst, Load_P1_Out);

//Seven segement display
sim_7segSystem RNGDisplay(Data_Out, DRNG); //RNG
sim_7segSystem TimerOnesDisplay(digit_ones, Done); //Timer 1 
sim_7segSystem TimerTensDisplay(digit_tenth, DTen); //Timer 2
sim_7segSystem UserNumDisplay(Difficulty, DUser); //user num 
sim_7segSystem ScoreOnesDisplay(unit_place, DScore_Ones); //Score 1 
sim_7segSystem ScoreTensDisplay(ten_place, DScore_Tens); //Score 2 


endmodule