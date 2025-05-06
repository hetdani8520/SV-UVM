//Ref:- https://en.wikipedia.org/wiki/Eight_queens_puzzle
//Ref2: https://yue-guo.com/2019/02/07/solving-the-n-queens-problem-using-constraints-in-systemverilog/

class n_queen_problem;
  parameter int N = 8;
  rand bit chess_board[N][N];
  
  //queens should only be 1 per row
  constraint one_per_row {foreach(chess_board[i]){
    chess_board[i].sum() with (int'(item)) == 1;}}
    
  //queens should only be 1 per column  
  constraint one_per_col {foreach(chess_board[,j]){
      chess_board.sum(row) with (row.sum(col) with (col.index == j?int'(col):0)) == 1;}}
      
  //queens should be on diff diagonals
  //abs diff b/w rows & cols should be different
  //If both cells have a queen (1), they must not be on the same diagonal.
    constraint diag {
  // Ensure that no two queens lie on the same diagonal
  foreach (chess_board[i, j]) {
    // Check against every other cell that has a queen placed (i.e., chess_board[k][l] == 1)
    foreach (chess_board[k, l]) {
      // Skip self-comparison (same cell)
      if (i != k || j != l) {
        // Only compare queens that are placed (value 1)
        if (chess_board[i][j] && chess_board[k][l]) {
          // Ensure that the queens are not on the same diagonal
          abs(i - k) != abs(j - l);
        }
      }
    }
  }
}

  //function returning abs value of variable
  function int abs(int x);
  return (x < 0) ? -x : x;
endfunction
 
endclass

module test;
  n_queen_problem q1;
  
  initial begin
    q1=new();
    assert(q1.randomize()) else
      $fatal(0,"randomization error");
    //display arr for debug
    foreach(q1.chess_board[i]) begin
      $write("%d:",i);
      foreach(q1.chess_board[,j]) begin
        $write("%d\t",q1.chess_board[i][j]);
      end
      $display;
    end
  end
endmodule