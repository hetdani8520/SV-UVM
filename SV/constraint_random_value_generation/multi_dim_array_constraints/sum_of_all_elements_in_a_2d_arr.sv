//sum of all elements in a 2-array is a constant value

class sum_of_all_elements_in_a_2d_array;
  parameter int N = 3;
  
  rand bit [7:0] magic_square[N][N];

  rand bit [4:0] max_sum;
  
  constraint constant_value {max_sum inside {[0:31]};}
  
  constraint sum_of_all_elements {
    magic_square.sum(item) with (item.sum with (int'(item))) == max_sum;
  }

endclass
    
module tb;
  sum_of_all_elements_in_a_2d_array m1;
  initial begin
  m1=new();
  
  assert(m1.randomize()) else 
    $fatal(0,"randomization::error failed");
  
  $display("max sum of all elements of a 2-d matrix is:%d",m1.max_sum);
  foreach(m1.magic_square[i]) begin
    $write("%d:",i);
    foreach(m1.magic_square[,j]) begin
      $write("%d\t",m1.magic_square[i][j]);
    end
    $display;
  end
  end
endmodule