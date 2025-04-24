/*
Here’s a question I came across recently in my interview:
Given this array:

{1, 9, 8, 4, 0, 0, 2, 7, 0, 6, 0}
👉 Move all non-zero elements to the left while keeping their order.
👉 Push all zeros to the right (in-place, no extra arrays).
Expected Output:

{1, 9, 8, 4, 2, 7, 6, 0, 0, 0, 0}
💡 How would you solve this in C or SystemVerilog?
Drop your solutions in the comments!👇
I’ll share the optimized approach soon. ⏳
*/

module two_pointer_segregate_no_preserve_order;
  bit [3:0] arr[];
  
  function automatic void segregate_arr(ref bit [3:0] arr[]);
    bit [3:0] left = 0;
    bit [3:0] right = arr.size() - 1;
    bit [3:0] temp;
    
    while(left < right) begin
      //break from this only when condition fails.
      //if element on the left is already non-zero, then retain the order & increment the left pointer.
      while((arr[left] != 0) && (left<right)) begin
        left++;
      end
      
      //imp: break from this only when condition fails.
      //if element on right is already zero, then retain the order & decrement right pointer
      while((arr[right] == 0) && (left<right)) begin
        right--;
      end
      
      if(left < right) begin //you can swap anyway
        temp = arr[left];
        arr[left] = arr[right];
        arr[right] = temp;
        left++;
        right--;
      end
    end
 endfunction
  
  initial begin
    arr = '{1, 9, 8, 4, 0, 0, 2, 7, 0, 6, 0};
    segregate_arr(arr);
    $display("segregated arr=%p",arr);
  end
  
  
endmodule