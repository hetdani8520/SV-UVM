////////////////////////////////////////////////////////////////////////////////////////////////////
//Problem:-Write a piece of code to randomize a 2-diamensional array to generate below pattern:
//1  2  3  4  5
//2  3  4  5  6
//3  4  5  6  7
//4  5  6  7  8
//5  6  7  8  9
////////////////////////////////////////////////////////////////////////////////////////////////////

class multid_array_gen;
  rand bit [3:0] arr[5][5];
  
  constraint array_elements{foreach(arr[i,j])
    arr[i][j] == i + j + 1;}
endclass

module test_arr;
  multid_array_gen h1;
  
  initial begin
    h1=new();
    
    assert(h1.randomize()) else
      $fatal(0,"2d array gen randomization error");
    
    //print multi dim array
    foreach(h1.arr[i,]) begin
      //$write("%d:",i);
      foreach(h1.arr[,j]) begin
        $write("%d",h1.arr[i][j]);
      end
      $display;
    end
        
  end
endmodule