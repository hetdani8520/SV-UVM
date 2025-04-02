//Write a constraint to generate unique values in rows using multidimensional array. (
class array_2d_unique_rows;
  parameter int a = 3; 
  rand bit [3:0] arr[a][a];
  
  constraint unique_rows {foreach(arr[i])
    unique{arr[i]};
                       }
  
endclass

module tb;
  array_2d_unique_rows h1;
  
  initial begin
    h1 = new();
    assert(h1.randomize()) else
      $fatal(0,"h1::randomization failed");

    //print the array
    foreach(h1.arr[i,]) begin
      $write("%d:",i);
      foreach(h1.arr[,j]) begin
        $write("%d\t",h1.arr[i][j]);
      end
    $display;
    end
    
  end
  
endmodule