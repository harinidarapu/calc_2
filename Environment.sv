// Harini
// Environment class contains 
 //Mailbox
 //Generator
 //Driver
 //scoreboard
 //monitor
 
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"	

class Environment

// Declaring handles
	Generator gen;
	Driver driv;
	monitor mon;
	scoreboard scd;
	mailbox gen_to_driv;
	mailbox mon_to_scb;

// Declaring event for synchronization  between generator and test
	event gen_event_ended;
	
// Virtual interface
	virtual intf v_intf;

// Creating Constructor 
	function new(virtual intf v_inft);
		//interface
		this.v_inft = v_inft;
		//mailbox
		gen_to_driv = new();
		mon_to_scb = new();
		// passing arguments
		gen = new(gen_to_driv,gen_event_ended);
		driv = new(v_inft,gen_to_driv);
		mon = new(,v_inft,mon_to_scb);
		scb = new(mon_to_scb);
		
			
	endfunction
	
// For better understanding, generator and driver methods are divinded into 3 methods
	// 1. pre_test() , 2. test() , 3. post_test() 
	
// Methods to call initialization i.e reset
	task pre_test();
		driv.reset();
	endtask : pre_test

// methods to call stimulus generation and stimulus driving 
	task test();
		fork
		gen.main();
		driv.main();
		mon.main();
		scd,main();
		join_any
	endtask : test
	
// methods to wait for completion of generation and driving
	task post_test();
		wait(gen_event_ended.triggered);
		wait (gen.repeat_count == driv.no_of_transactions);
		wait (gen.repeat_count== scb.no_of_transactions);
	endtask : post_test
	
	
// now running all the tasks defined above

		task run;
			pre_test();
			test();
			post_test();
			$finish;
		endtask : run
		
endclass

 