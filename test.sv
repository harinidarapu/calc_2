// Harini
// This test is written in program block


`include "environment.sv"
program test(intf intf1);

// declaring environment instance
	environment env;
	initial
		begin
			env = new(intf1);
	
// setting no of transactions to be generated
	
		env.gen.repeat_count = 8;

//  Initializing the stimulus to drive
		env.run();

		end
	
endprogram