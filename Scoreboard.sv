//  Harini 
// Scoreboard
// scoreboard receives transaction packet from monitor via mailbox

class scoreboard
 
// creating mailbox
 mailbox mon_to_scb;
 
 // no_of_transactions
 int no_of_transactions;

// Variable to note the correct results: 
	int correct1, correct2, correct3, correct4;
	transaction trans;
	mailbox mon_to_scb; 
// variables for calculating the expected result:
	bit [0:1] exp_resp1, exp_resp2, exp_resp3, exp_resp4;
	bit [0:31] exp_data1, exp_data2, exp_data3, exp_data4;

// constructor
	function new(mailbox mon_to_scb);
		this.mon_to_scb = mon_to_scb;
	endfunction
//

// Task to calculate the expected data and response: 
	task exp_output();

		//------------------------------------ADDITION cmd=0001------------------------// 
		// PORT-A:
		if (trans.req_A== 4'b0001) 
		begin
			exp_data1 = trans.data_A1 + trans.data_A2;
			if((exp_data1< trans.data_A1) && (exp_data1< trans.data_A2))
				exp_resp1 = 2'b10;
		end
		// PORT-B:
		if (trans.req_B== 4'b0001) 
		begin
			exp_data2 = trans.data_B1 + trans.data_B2;
			if((exp_data2< trans.data_B1) && (exp_data2< trans.data_B2))
				exp_resp2 = 2'b10;
		end
		// PORT-C:
		if (trans.req_C== 4'b0001) 
		begin
			exp_data3 = trans.data_C21 + trans.data_C22;
			if((exp_data3< trans.data_C21) && (exp_data3< trans.data_C22))
				exp_resp3 = 2'b10;
		end
		// PORT-D:
		if (trans.req_D== 4'b0001)
		begin
			exp_data4 = trans.data_D1 + trans.data_D2;
			if((exp_data4< trans.data_D1) && (exp_data4< trans.data_D2))
				exp_resp4 = 2'b10;
		end  
  
		//------------------------------------SUBTRACTION cmd=0010------------------------//
		// PORT-A:
		if (trans.req_A== 4'b0010) 
		begin
			exp_data1 = trans.data_A1 - trans.data_A2;
			if(trans.data_A1< trans.data_A2)
				exp_resp1 = 2'b10;
		end
		// PORT-B:
		if (trans.req_B== 4'b0010) 
		begin
			exp_data2 = trans.data_B1 - trans.data_B2;
			if(trans.data_B1< trans.data_B2)
				exp_resp2 = 2'b10;
		end
		// PORT-C:
		if (trans.req_C== 4'b0010) 
		begin
			exp_data3 = trans.data_C21 - trans.data_C22;
			if(trans.data_C21< trans.data_C22)
				exp_resp3 = 2'b10;
		end
		// PORT-D:
		if (trans.req_D== 4'b0010) 
		begin
			exp_data4 = trans.data_D1 - trans.data_D2;
			if(trans.data_D1< trans.data_D2)
				exp_resp4 = 2'b10;
		end 
		
		//------------------------------------LEFT SHIFT cmd=0101------------------------//
		// PORT-A:
		if (trans.req_A== 4'b0101) 
		begin
			exp_data1 = (trans.data_A1 << (trans.data_A2 & 31));
		end
		// PORT-B:
		if (trans.req_B== 4'b0101) 
		begin
			exp_data2 = (trans.data_B1 << (trans.data_B2 & 31));
		end  
		// PORT-C:
		if (trans.req_C== 4'b0101) 
		begin
			exp_data3 = (trans.data_C21 << (trans.data_C22 & 31));
		end
		// PORT-D:
		if (trans.req_D== 4'b0101) 
		begin
			exp_data4 = (trans.data_D1 << (trans.data_D2 & 31));
			
		end
		
		//------------------------------------LEFT SHIFT cmd=0101------------------------//
		// PORT-A:
		if (trans.req_A== 4'b0101) 
		begin
			exp_data1 = (trans.data_A << (trans.data_A2 & 31));
		end
		// PORT-B:
		if (trans.req_B== 4'b0101) 
		begin
			exp_data2 = (trans.data_B << (trans.data_B2 & 31));
		end  
		// PORT-C:
		if (trans.req_C== 4'b0101) 
		begin
			exp_data3 = (trans.data_C2 << (trans.data_C2b & 31));
		end
		// PORT-D:
		if (trans.req_D== 4'b0101) 
		begin
			exp_data4 = (trans.data_D << (trans.data_D2 & 31));
		end
		
		//------------------------------------RIGHT SHIFT cmd=0110------------------------//
		// PORT-A:
		if (trans.req_A== 4'b0110) 
		begin 
			exp_data1 = (trans.data_A >> (trans.data_A2 & 31));
		end
		// PORT-B:
		if (trans.req_B== 4'b0110) 
		begin
			exp_data2 = (trans.data_B >> (trans.data_B2 & 31));
		end
		// PORT-C:
		if (trans.req_C== 4'b0110) 
		begin
			exp_data3 = (trans.data_C2 >> (trans.data_C2b & 31));
		end
		// PORT-D:
		if (trans.req_D== 4'b0110) 
		begin
			exp_data4 = (trans.data_D >> (trans.data_D2 & 31));
		end
 
		//--------------------------------cmd=invalid---------------------------//
		// PORT-A:
		if ((trans.req_A==3)||(trans.req_A==4)||(trans.req_A>6))
			exp_resp1 = 2'b10;
		// PORT-B:
		if ((trans.req_B==3)||(trans.req_B==4)||(trans.req_B>6))
			exp_resp2 = 2'b10;
		// PORT-C:
		if ((trans.req_C==3)||(trans.req_C==4)||(trans.req_C>6))
			exp_resp3 = 2'b10;
		// PORT-D:
		if ((trans.req_D==3)||(trans.req_D==4)||(trans.req_D>6))
			exp_resp4 = 2'b10;

		// Check whether the actual and expected values are the same on all ports of the DUT:
		// PORT-A:
		if(trans.out_Data_A==2'b00)
		begin
			$display ($time, " : ERROR! : PORT-A : expected dataa : %h  output_dataa : %h",exp_data1,trans.out_data1);
			$display ($time, " : ERROR! : PORT-A : no response : expected responsea : %h  output_responsea : %h\n",exp_resp1, trans.out_Data_A);
		end
		else if (trans.out_Data_A==2'b11)
			$display ($time, " : ERROR! : PORT-A unused response %h\n",trans.out_Data_A);
		else if (trans.out_Data_A==2'b10 && exp_resp1==2'b10)
			$display ($time, " :Match in ERROR! : PORT-A overflow/underflow as expected %h\n",trans.out_Data_A);
		else 
		begin
			if (exp_data1 != trans.out_data1 )
				$display ($time, " : ERROR! Data doesn't match with expected: PORT-A expected data : %h  output_data : %h\n",exp_data1,trans.out_data1);
			else 
			begin
				$display($time, " : Data match at PORT-A");
				$display ($time, " : Match! Congrats!! : PORT-A expected data : %h  output_data : %h\n",exp_data1,trans.out_data1);  
				correct1++;
			end
		end
   
		// PORT-B:
		if(trans.out_Data_B==2'b00) 
		begin
			$display ($time, " : ERROR! : PORT-B : expected datab : %h  output_datab : %h",exp_data2,trans.out_data2);
			$display ($time, " : ERROR! : PORT-B : no response : expected responseb : %h  output_responseb : %h\n",exp_resp2, trans.out_Data_B);
		end
		else if (trans.out_Data_B==2'b11)
			$display ($time, " : Match in ERROR! : PORT-B unsued response as expected %h\n",trans.out_Data_B);
		else if (trans.out_Data_B==2'b10 && exp_resp2==2'b10)
			$display ($time, " : ERROR! : PORT-B overflow/underflow %h\n",trans.out_Data_B);
		else 
		begin
			if (exp_data2 != trans.out_data2) 
				$display ($time, " : ERROR! PORT-B Data doesn't match with expected: %h  output_data : %h\n",exp_data2, trans.out_data2);
			else 
			begin
				$display($time, " : Data match at PORT-B"); 
				$display ($time, " : Match! Congrats!! : PORT-B expected data : %h  output_data : %h\n",exp_data2,trans.out_data2);  
				correct2++;
			end
		end

		// PORT-C:
		if(trans.out_Data_C==2'b00) 
		begin
			$display ($time, " : ERROR! : PORT-C : expected datac : %h  output_datac : %h",exp_data3,trans.out_data3);
			$display ($time, " : ERROR! : PORT-C : no response : expected responsec : %h  output_responsec : %h\n",exp_resp3, trans.out_Data_C);
		end
		else if (trans.out_Data_C==2'b11)
			$display ($time, " : ERROR! : PORT-C unsued response %h\n",trans.out_Data_C);
		else if (trans.out_Data_C==2'b10 && exp_resp3==2'b10)
			$display ($time, " : Match in ERROR! : PORT-C unsued response as expected %h\n",trans.out_Data_C);
		else 
		begin
			if (exp_data3 != trans.out_data3)
				$display ($time, " : ERROR! PORT-C Data doesn't match with expected: %h  output_data : %h\n",exp_data3,trans.out_data3);
			else 
			begin
				$display($time, ": Data match at PORT-C");
				$display ($time, " : Match! Congrats!! : PORT-C expected data : %h  output_data : %h\n",exp_data3,trans.out_data3);  
				correct3++;
			end
		end 
    
		// PORT-D:
		if(trans.out_Data_D==2'b00) 
		begin
			$display ($time, " : ERROR! : PORT-D : expected datad : %h  output_datad : %h",exp_data4,trans.out_data4);
			$display ($time, " : ERROR! : PORT-D : no response : expected responsed : %h  output_responsed : %h\n",exp_resp4, trans.out_Data_D);
		end
		else if (trans.out_Data_D==2'b11)
			$display ($time, " : ERROR! : PORT-D unsued response %h\n",trans.out_Data_D);
		else if (trans.out_Data_D==2'b10 && exp_resp4==2'b10)
			$display ($time, " : Match in ERROR! : PORT-D unsued response as expected %h\n",trans.out_Data_D);
		else
		begin
			if (exp_data4 != trans.out_data4) 
				$display ($time, " : ERROR! PORT-D Data doesn't match with expected: %h  output_data : %h\n",exp_data4, trans.out_data4);
			else
			begin
				$display($time, " : Data match at PORT-D"); 
				$display ($time, " : Match! Congrats!! : PORT-D expected data : %h  output_data : %h\n",exp_data4,trans.out_data4);
				correct4++;
			end
		end
	
	endtask : exp_output

	// Main Task: 
	task main(); 
  
		$display("\n",$time," : scoreboard for %d transactions", max_trans_cnt);
 
	forever 
	begin
   
		
		mon_to_scb.get(trans);  // get the values from the monitor
  
	
		exp_output();
 
		
		no_of_transactions++
		end 
	end
endtask: main

endclass: team_scoreboard




endclass