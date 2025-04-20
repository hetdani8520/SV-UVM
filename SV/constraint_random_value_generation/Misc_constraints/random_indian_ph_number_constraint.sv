//This program excludes indian landline range (2-6)
//For more info on indian phone number schemes refer:- https://www.quora.com/Why-do-phone-numbers-in-India-start-with-only-7-8-or-9
class random_indian_ph_number_constraint;
  typedef enum logic [3:0] {STD, EMERGENCY, POLICE, LOCAL, NON_LOCAL} ph_types;
  
  rand ph_types types;
  
  rand bit [39:0] ph_num;
  
  //first digits "(7-9)" are reserved for mobile phone numbers in india (LOCAL)
  //first digit "1" is reserved for indian police,fire brigade etc. (EMERGENCY, POLICE etc..)
  //+91 is the country code for india when making an international call (NON_LOCAL)
  //first digit "0" is reserved for STD calls
  constraint ph {(types == STD) 	  -> ph_num == 0;
                 (types == EMERGENCY) -> ph_num == 108; //ambulance
                 (types == POLICE)	-> ph_num == 100; //police helpline
                 (types == NON_LOCAL) -> (ph_num inside {[40'd917000000000:40'd919999999999]});
                 (types == LOCAL)	  -> (ph_num inside {[40'd7000000000:40'd9999999999]});
                }
                 
  
endclass

module test;
  random_indian_ph_number_constraint r1;
  
  initial begin
    r1=new();
    repeat(5) begin
      assert(r1.randomize()) else
      $fatal(0,"randomization error");
    $display("ph_type=%s,ph_num=%d",r1.types.name(),r1.ph_num);
    end
  end
endmodule