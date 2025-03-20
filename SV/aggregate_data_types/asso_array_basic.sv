//associative array methods & usage
module asso_array_basic;
  bit [63:0] asso[int];
  int idx = 32'd1;
  
  initial begin
    repeat(10) begin
      asso[idx] = idx;
      idx = idx << 1;
    end
    
    //iterate through all elements in asso array
    foreach(asso[i]) begin
      $display("asso[%d]=%d",i,asso[i]);
    end
    
    //iterate through all elements of asso array using built-in array methods
    if(asso.first(idx)) begin
      do
        $display("asso[%d]=%d",idx,asso[idx]);
      while(asso.next(idx));
    end
    
    //find & delete first element
    asso.first(idx);
    asso.delete(idx);
    $display("asso array=%p",asso);
    
    //exists function usage
    idx = 1;
    if(asso.exists(idx)) begin //exists return 1 if idx exists
      $display("asso exists element=%d",asso[idx]);
    end
    else begin
      $display("element at index %d does not exist",idx);
    end
        
  end
endmodule