// Generator
// its major task is to 
// 1. declare "repeat_count" to know no of transaction to generate
// 2.  Randamize the input
// 3.  Put into mailbox
// 4. Trigger an Event

class Generator

// Declare the transaction class
	rand transaction trans

// Declare Mailbox
	mailbox gen_to_driv;

// Declare count number
	int repeat_count;
	
// Create an Event
	event ended_gen;

// create constructor
	function new(mailbox gen_to_driv,event ended_gen);
		this.gen_to_driv = gen_to_driv;
		this.ended_gen = ended_gen;
	endfunction

// now creating the main task , which includes--> generate ( create & randomize) repeat_count no of trasactions and put into mailbox

	task main();
		repeat (repeat_count)
			begin
			trans = new();
			if (!trans.randomize())
			$display ("randomization of trasaction failed");
			gen_to_driv.put(trans);
			end
	    --> ended;
	
	endtask		

endclass