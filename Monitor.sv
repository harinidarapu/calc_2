//Harini
//Monitor class
// Monitor samples the interface signals and coverts the signal level activity into transaction level
// and send this sampled transaction to the scoreboard via mailbox

// For simplicity 'define is used to acces the interface signals
`define MONITOR_INTF v_intf.monitor.monitor_input

class monitor

// creating virtual interface
	virtual intf v_intf;

// Creating mailbox to send to scoreboard
	mailbox mon_to_scb;
	
//Creating constructor
	function new(virtual intf v_intf,mailbox mon_to_scb);
// getting mailbox and interface handels from Environment
	this.v_intf = v_intf;
	this.mon_to_scb = mon_to_scb;
	endfunction

// Sample the out signals from dut and send those to scoreboard via interface

	task main;
		forever
			begin
			
				transaction trans;
				trans = new();
				@(`MONITOR_INTF.res_A == 1 || `MONITOR_INTF.res_B == 1 ||`MONITOR_INTF.res_C == 1 ||`MONITOR_INTF.res_D == 1 ||`MONITOR_INTF.res_A == 2 ||`MONITOR_INTF.res_B == 2 ||`MONITOR_INTF.res_C == 2 ||`MONITOR_INTF.res_D == 2 );
				
						$display($time": ----------Monitor Recieving data from all Port out of Dut----------");
		// PORT-A:
				trans.res_A = `MONITOR_INTF.res_A;
				trans.out_Data_A = `MONITOR_INTF.out_Data_A;
				trans.out_tag_A = `MONITOR_INTF.out_tag_A;
				$display($time," : res_A %h",trans.res_A);
				$display($time," : out_Data_A %h",trans.out_Data_A);
				$display($time," : out_tag_A %h",trans.out_tag_A);
		
		// PORT-B: 
				trans.res_B = `MONITOR_INTF.res_B;
				trans.out_Data_B = `MONITOR_INTF.out_Data_B;
				trans.out_tag_B = `MONITOR_INTF.out_tag_B;
				$display($time," : res_B %h",trans.res_B);
				$display($time," : out_Data_B %h",trans.out_Data_B);
				$display($time," : out_tag_B %h",trans.out_tag_B);
		
		// PORT-B: 
				trans.res_C = `MONITOR_INTF.res_C;
				trans.out_Data_C = `MONITOR_INTF.out_Data_C;
				trans.out_tag_C = `MONITOR_INTF.out_tag_C;
				$display($time," : res_C %h",trans.res_C);
				$display($time," : out_Data_C %h",trans.out_Data_C);
				$display($time," : out_tag_C %h",trans.out_tag_C);
		
		// PORT-C: 
				trans.res_B = `MONITOR_INTF.res_B;
				trans.out_Data_B = `MONITOR_INTF.out_Data_B;
				trans.out_tag_B = `MONITOR_INTF.out_tag_B;
				$display($time," : res_B %h",trans.res_B);
				$display($time," : out_Data_B %h",trans.out_Data_B);
				$display($time," : out_tag_B %h",trans.out_tag_B);
		// PORT-D: 
				trans.res_D = `MONITOR_INTF.res_B;
				trans.out_Data_D = `MONITOR_INTF.out_Data_D;
				trans.out_tag_D = `MONITOR_INTF.out_tag_D;
				$display($time," : res_D %h",trans.res_D);
				$display($time," : out_Data_D %h",trans.out_Data_D);
				$display($time," : out_tag_D %h",trans.out_tag_D);
				
// Sending the trans packet to scoreboard via mailbox

				mon_to_scb.put(trans); 
			end

		endtask

endclass