//Write constraint such that sum of arr[10] is 100 without using .sum method

class q1;
  parameter int N = 10;
  rand bit [7:0] arr[N];     // this array composes of elements that sum upto 100
  rand bit [7:0] arr_sum[N]; //this stores aggregate sum of prev elements  
  

  constraint sum_all {foreach(arr_sum[i]){
    arr[i] inside {[0:20]};
    if(i==1){ //2nd element
      arr_sum[i] == arr[i] + arr[i-1]; //first arr_sum is sum of first 2 elements 
    }
    if(i>1){
      arr_sum[i] == arr_sum[i-1] + arr[i]; //for rest indices the aggregate sum is(==) prev cummulative sum + current element at that index
    }
      }
      arr_sum[9] inside {100}; //last element of arr_sum is aggregate sum of all elements in arr which should be 100
    
    //unique{arr}; //if needed unique elements
  }
endclass

module test;
  q1 q1_h;
  
  initial begin
    q1_h=new();
    assert(q1_h.randomize()) else
      $fatal(0,"randomization error");
    foreach(q1_h.arr[i]) begin
      $display("arr[%d]=%d",i,q1_h.arr[i]);
    end
    $display("arr=%p",q1_h.arr);  //sum of 10 array elements = 100
    $display("arr=%p",q1_h.arr_sum); //debug
  end
endmodule