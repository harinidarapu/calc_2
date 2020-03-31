// Driver 
// Driver is responsible to receive the stimulus generated from the generator and drive it to the DUT


// For simplicity 'define is used to acces the interface signals
'define DRIV_INF v_intf.driver.driver_out
// now DRIV_INF ----> v_intf.driver.driver_out
class Driver

// no of transactions 
	int no_of_transactions;

// creating virtula interface handle 
	virtual intf v_intf;
 
//Defining the mailbox 
	mailbox gen_to_driv;

//constructor
	function new(virtual intf v_intf,mailbox gen_to_driv);
// getting mailbox and interface handels from mailbox
	this.v_intf = v_intf;
	thid.gen_to_driv = gen_to_driv;
	endfunction

// reset task
task reset;
	wait(v_intf.reset);
		$display("---- RESET STARTED-----");
// all request commands --> DUT
		DRIV_INF.req_A <= 4'b0000;
		DRIV_INF.req_B <= 4'b0000;
		DRIV_INF.req_C <= 4'b0000;
		DRIV_INF.req_D <= 4'b0000;

// all data inputs --> DUT
		DRIV_INF.data_A1 <= 32'h00000000;
		DRIV_INF.data_B1 <= 32'h00000000;
		DRIV_INF.data_C1 <= 32'h00000000;
		DRIV_INF.data_D1 <= 32'h00000000;

//all tags --> DUT
		DRIV_INF.tag_A <= 2'b00;
		DRIV_INF.tag_B <= 2'b00;
		DRIV_INF.tag_C <= 2'b00;
		DRIV_INF.tag_D <= 2'b00;
	
	wait (!v_intf.reset);
		$display("----- RESET ENDED-------");
endtask
	

// task drive --> to drive the transaction packets to the DUT 
task drive;
 forever 
	begin
		Transaction trans;
		gen_to_driv.get(trans);
		$display("--- Driver's transmission is starting---");
		@`DRIV_INF;
			$display("\n",$time," : ------------Sending data-1 on all port of dut----------");
			
			// PORT A
				`DRIV_INF.req_A <= trans.req_A;
                `DRIV_INF.data_A1 <= trans.data_A1;
                `DRIV_INF.tag_A <= trans.tag_A;
                $display("\n",$time,": 1 trans.req_A %h",trans.req_A);
                $display($time,": 1 trans.data_A1 %h",trans.data_A1);
                $display($time,": 1 trans.tag_A %h",trans.tag_A);
			
			// PORT B
				`DRIV_INF.req_B <= trans.req_B;
                `DRIV_INF.data_B1 <= trans.data_B1;
                `DRIV_INF.tag_B <= trans.tag_B;
                $display("\n",$time,": 1 trans.req_B %h",trans.req_B);
                $display($time,": 1 trans.data_B1 %h",trans.data_B1);
                $display($time,": 1 trans.tag_B %h",trans.tag_B);
				
			// PORT C
				`DRIV_INF.req_C <= trans.req_C;
                `DRIV_INF.data_C1 <= trans.data_C1;
                `DRIV_INF.tag_C <= trans.tag_C;
                $display("\n",$time,": 1 trans.req_C %h",trans.req_C);
                $display($time,": 1 trans.data_C1 %h",trans.data_C1);
                $display($time,": 1 trans.tag_C %h",trans.tag_C);
			
			// PORT D
				`DRIV_INF.req_D <= trans.req_D;
                `DRIV_INF.data_D1 <= trans.data_D1;
                `DRIV_INF.tag_D <= trans.tag_D;
                $display("\n",$time,": 1 trans.req_D %h",trans.req_D);
                $display($time,": 1 trans.data_D1 %h",trans.data_D1);
                $display($time,": 1 trans.tag_D %h",trans.tag_D);
				
 //---------------------------------data2 pass--------------------------------------------

@`DRIV_INF;

 $display("\n",$time," : ------------Sending data-2 on all port of dut----------");
		
		// PORT A
				`DRIV_INF.req_A <= 4'B0000;
                `DRIV_INF.data_A1 <= trans.data_A2;
				$display("\n",$time,": 1 trans.req_A %h",trans.req_A);
                $display($time,": 1 trans.data_A2 %h",trans.data_A2);
                
		// PORT B
				`DRIV_INF.req_B <= 4'B0000;
                `DRIV_INF.data_B1 <= trans.data_B2;
				$display("\n",$time,": 1 trans.req_B %h",trans.req_B);
                $display($time,": 1 trans.data_B2 %h",trans.dataB2);		
		
		// PORT C
				`DRIV_INF.req_C <= 4'B0000;
                `DRIV_INF.data_C1 <= trans.data_C2;
				$display("\n",$time,": 1 trans.req_C %h",trans.req_C);
                $display($time,": 1 trans.data_C2 %h",trans.data_C2);
		
		// PORT A
				`DRIV_INF.req_D <= 4'B0000;
                `DRIV_INF.data_D1 <= trans.data_D2;
				$display("\n",$time,": 1 trans.req_D %h",trans.req_D);
                $display($time,": 1 trans.data_D2 %h",trans.data_D2);
		
		no_of_transactions++
	end
endtask : drive

endclass 