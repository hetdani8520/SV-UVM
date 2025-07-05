//sorting followed by two-pointer technique
module two_sum;
  bit [5:0] arr[] = {7,6,5,3,2,4,1};
  bit [5:0] target = 6;
  
  bit [5:0] temp=0;
  
  int left = 0;
  int right = arr.size() - 1;
  int sum = 0;
  
  initial begin
    //sorting
    for(int i=0;i<arr.size();i++) begin
      for(int j=i+1;j<arr.size();j++) begin
        if(arr[i] > arr[j]) begin
          temp = arr[i];
          arr[i] = arr[j];
          arr[j] = temp;
        end
      end
    end
    
    $display("sorted arr=%p",arr);
    
    //two-pointer technique
    while(left < right) begin
      sum = arr[left] + arr[right];
    if(sum == target) begin
      $display("num1 = %d",arr[left]);
      $display("num2 = %d",arr[right]);
      break;
    end
    else if(sum > target) begin
      right--;
    end
    else if(sum < target) begin
      left++;
    end
    end
      
    
  end
endmodule