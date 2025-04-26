module rows_with_max_sum;
  bit mat[3][4];
  function int rows_with_max_sum(ref bit mat[3][4]);
    int max_value=0;
    int max_idx;
    bit [7:0] cnt[3]; //very important to initialize cnt array based on input matrix's row size
    
    foreach(mat[i]) begin
      foreach(mat[,j]) begin
        cnt[i] = cnt[i] + mat[i][j]; //logic to add all the ones for each row & append the cnt to the cnt array (Note:- cnt array is indexed by row. so we can easily get row with max num of ones by just returning index of cnt array) [no need to cast here]
      end
    end
    //$display("cnt=%p",cnt);
    //logic to find max element in an array (in this context:- rows with max ones)
    foreach(cnt[k]) begin
      if(cnt[k] > max_value) begin
        max_value = cnt[k];
        max_idx = k;
      end
    end
    return max_idx; //row with maximum number of ones
    
  endfunction
  
  initial begin
    mat = '{'{0,1,1,1},
            '{0,0,1,1},
            '{1,1,1,1}};
    
    $display("row with max ones=%d", rows_with_max_sum(mat));

    
  end
endmodule