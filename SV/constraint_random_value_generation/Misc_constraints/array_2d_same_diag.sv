//Systemverilog constraint to generate a 2d array with same diagonal & anti-diagonal values (asumption is 2-d array is symmetric - i.e same number of rows & cols)
class array_2d_same_diag;
  parameter int a = 5; 
  rand bit [3:0] arr[a][a];
  
  constraint diag_cons {foreach(arr[i,j])
    if(i == j)
      arr[i][j] == arr[0][0];
                       }
  
  constraint anti_diag {foreach(arr[i,j])
    					if(i+j == (a - 1))
                                  arr[i][j] == arr[0][a-1];
                                }
endclass

module tb;
  array_2d_same_diag h1;
  
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