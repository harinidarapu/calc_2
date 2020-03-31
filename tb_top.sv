// This module connects the DUT and Testbench via interface

`include "interface.sv"
`include "test.sv"
module tb_top
parameter simulation_cycle = 100;

// clock & reset signal declaration
	bit c_clk;
	bit reset;

// clock generation
	always #(simulation_cycle/2) 
    c_clk = ~c_clk;
	
// creating istance for interface
	intf intf1(c_clk, reset); // APB interafce

// creating instance for test
	test test_tb (intf1);
	
// Creating instance for DUT
	calc2_top  dut ( .out_data1(intf1_out_Data_A), .out_data2(intf1_out_Data_B), .out_data3(intf1_out_Data_C), .out_data4(intf1_out_Data_C),
					 .out_resp1(intf1_res_A), .out_resp2(intf1_res_B), .out_resp3(intf1_res_C), .out_resp4(intf1_res_C),
					 .out_tag1(intf1_out_tag_A), .out_tag2(intf1_out_tag_B), .out_tag3(intf1_out_tag_C), .out_tag4(intf1_out_tag_D),
					 .scan_out(intf1_out_scan_out), .a_clk(intf1_a_clk), .b_clk(intf1_b_clk), .c_clk(intf1_c_clk),.reset(intf1_reset), .scan_in(intf1_scan_in), 
					 .req1_cmd_in(intf1_req_A), .req1_data_in(intf1_data_A1), .req1_tag_in(intf1_tag_A), 
					 .req2_cmd_in(intf1_req_B), .req2_data_in(intf1_data_B1), .req2_tag_in(intf1_tag_B), 
					 .req3_cmd_in(intf1_req_C), .req3_data_in(intf1_data_C1), .req3_tag_in(intf1_tag_C), 
					 .req4_cmd_in(intf1_req_D), .req4_data_in(intf1_data_D1), .req4_tag_in(intf1_tag_D));
endmodule