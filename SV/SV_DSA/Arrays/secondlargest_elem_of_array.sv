module secondlargest_elem_of_arr;
  bit [4:0] arr[] = '{4,3,2,1,0,6,5,10};
  
  bit [4:0] largest = 0;
  bit [4:0] secondlargest = 0;
  
  initial begin
    for(int i=0;i<arr.size();i++) begin
      if(arr[i] > largest) begin
        secondlargest = largest;
        largest = arr[i];
      end
      else if (arr[i] < largest && arr[i] > secondlargest) begin
        secondlargest = arr[i];
      end
    end
    $display("largest=%d",largest);
    $display("secondlargest=%d",secondlargest);
  end
  
endmodule