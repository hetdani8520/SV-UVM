//Note:-1)By default, all members of class are "public" & visible (accessible) from both inside & outside of the class
//A member identified as local is available only to methods inside the class. Further, these local members
//are not visible within subclasses. Of course, nonlocal methods that access local class properties or methods
//can be inherited and work properly as methods of the subclass.

//Problem-1:- Can we access local property of parent class inside child? 
//Ans.:Yes. local property of parent class can be accessed by child class if any non-local methods defined in parent class access the local property. (This is simple conseqeuence of inheritance)

//local method in parent class accessible (via non-local methods) by both parent & child class:
class sv_parent;
  local bit [3:0] a;
  
  function void acc_local(bit [3:0] a_global);
  this.a = a_global;
    $display("local property a value=%d",this.a); 
  endfunction
  
endclass

class sv5_child extends sv_parent;
//child inherits all non-local methods as well as local & non-local properties from parent class
endclass
      
module test_1;
  sv_parent sv_parent_h;
  sv5_child sv5_ch1;
  
  initial begin
    sv5_ch1 = new();
    sv_parent_h = new();
    sv_parent_h.acc_local(5);   //parent accessing local property defined inside parent class using non-local method
    sv5_ch1.acc_local(6); //child accessing local property defined inside parent using non-local method (defined in parent class)
  end

endmodule

/*---------------------------------------------------------------------------------------------------------------*/

//Problem-2:-If yes how can we restrict to access the parent class property from outside the class, (Not possible I guess)
//Ans.However, if one wants to restrict access of local properties defined inside parent by child class, then the non-local methods accessing the local property in the parent class SHOULD BE CHANGED to "local" which will restrict child AS WELL AS PARENT from accessing/modifying any local properties defined in parent class.

//Ex.b:-
class sv5;
  local bit [3:0] a;
  
  local function void acc_local(bit [3:0] a_global);
  this.a = a_global;
    $display("local property a value=%d",this.a); 
  endfunction
  
endclass

class sv5_child2 extends sv5;
endclass
      
module test_2;
  sv5 sv5_h;
  sv5_child2 sv5_ch1;
  
  initial begin
    sv5_ch1 = new();
    sv5_h = new();
    //sv5_h.acc_local(5);   //not accessible if "acc_local" method is defined as "local" in parent class (not accessible by parent)
    //sv5_ch1.acc_local(6); //not accessible if "acc_local" method is defined as "local" in parent class (not accessible by child)
  end
  
endmodule
