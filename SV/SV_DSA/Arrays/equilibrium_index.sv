//equilibrium index
//precompute prefix sum & suffix sum & compare
//Ref:- prefix_sum/suffix_sum of arr = https://www.geeksforgeeks.org/prefix-sum-array-implementation-applications-competitive-programming/
//Ref:- https://www.geeksforgeeks.org/dsa/equilibrium-index-of-an-array/

module equilibrium_index;
  bit [4:0] arr[] = '{1, 2, 0, 3};
  int n = arr.size();
  bit [4:0] prefix_sum[] = new[n];
  bit [4:0] suffix_sum[] = new[n];
  
  initial begin
    prefix_sum[0] = arr[0];
    suffix_sum[n - 1] = arr[n - 1];
    
    for(int i=1;i<n;i++) begin
      prefix_sum[i] = arr[i] + prefix_sum[i-1];
    end
    
    for(int j=(n-2);j>=0;j--) begin
      suffix_sum[j] = arr[j] + suffix_sum[j+1];
    end
    
    for(int k=0;k<n;k++) begin
      if(prefix_sum[k] == suffix_sum[k]) begin
        $display("equilibrium index found:%d",k);
        break;
      end
    end
  end
endmodule