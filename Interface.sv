// Harini
// Interface 
// Interface is the collection of common signals between two entities
// its direction is governerd by Modports and synchronization by clocking block.

interface intf (input a_clk,b_clk,c_clk);

// input and output signals of DUT

logic [0:3] req_A,req_B,req_C,req_D;
logic [0:31] data_A1,data_B1,data_C1,data_D1,out_Data_A,out_Data_B,out_Data_C,out_Data_D;
logic [0:1] tag_A,tag_B,tag_C,tag_D,out_tag_A,out_tag_B,out_tag_C,out_tag_D;
bit reset,scan_in,scan_out,a_clk,b_clk;

// defining clocking block --> driver for synchronization of its outputs

clocking driver_out @(posedge c_clk);
// all request commands --> DUT
	output req_A,req_B,req_C,req_D;

// all data inputs --> DUT
	output data_A1,data_B1,data_C1,data_D1;

//all tags --> DUT
	output tag_A,tag_B,tag_C,tag_D;
endclocking

// defining clocking block --> Monitor for synchronization of inputs

clocking monitor_input @(posedge c_clk)
//need to sample responde from DUT  
	input res_A,res_B,res_C,res_D;

// need to sample data out from DUT
	input out_Data_A,out_Data_B,out_Data_C,out_Data_D;

// need to sample output tags from DUT	
	input out_tag_A,out_tag_B,out_tag_C,out_tag_D;
endclocking

// directing all the signals

modport driver (clocking driver_out);
modport monitor (clocking monitor_input);
modport DUT ( input req_A,req_B,req_C,req_D,data_A1,data_B1,data_C1,data_D1,tag_A,tag_B,tag_C,tag_D,reset,scan_in,scan_out,a_clk,b_clk
			  output res_A,res_B,res_C,res_D,out_Data_A,out_Data_B,out_Data_C,out_Data_D,out_tag_A,out_tag_B,out_tag_C,out_tag_D );
			  

endinterface