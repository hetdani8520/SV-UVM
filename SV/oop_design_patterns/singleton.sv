//class to create only one instance of the class( this class guarantees creation of only one instance of the class)
class singleton;
  
  //local restricts the visibility for modification outside the class
  //static provides memory allocation at compile time & prevents object creation to access the class variable/handle sh
  local static singleton sh;
  
  //making new() local restricts the creation on object outside the class
  //making new() local delegates object construction to static method get()
  local function new();
  endfunction
  
  //static get() method enforces policy for construction (which is create on first use)
  static function singleton get();
    if(sh == null)
      sh = new();
    return sh;
  endfunction
  
endclass

module singleton_pattern;
  initial begin
    //invoke get() first time will trigger object creation for singleton class
    $display("create one instance = %h", singleton::get());
    
    //invoke get() second time will not trigger object creation again but rather returns the same pointer address to allocated memory as the one during first object creation which guarantees only single instance of class creation is possible 
    $display("TRY to create second instance(not possible, will return same pointer address as during first object creation) = %h", singleton::get());
  end
endmodule