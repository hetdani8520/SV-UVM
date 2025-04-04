//2KB Memory with unequal partitions
//user needs to provide constraint on unequal partition size combinations based on ram start & end addr
class mem_partition_unequal;
  
  bit [31:0] ram_start; //ram start address
  bit [31:0] ram_end;   //ram end address
  
  rand bit [31:0] num_of_partition; //number of partitions
  rand bit [31:0] partition_size[]; //size of each partition
  rand bit [31:0] start_addr_arr[]; //array to capture start address of each partition
  
  //num of partition (can be configured/constrained by the user)
  constraint n_part {num_of_partition > 4;
                               num_of_partition  < 10;}
  
  //size of each partition
  constraint part_size {partition_size.size() == num_of_partition;
                        partition_size.sum() == ram_end - ram_start + 1;
                        foreach(partition_size[i])
                          partition_size[i] inside {16,32,64,128,512,1024}; //configured by user
                       }
  //start address of each partition
  constraint start_addr_each_partition {start_addr_arr.size() == num_of_partition;
                                        foreach(start_addr_arr[i])
                                          if(i)
                                            start_addr_arr[i] == start_addr_arr[i-1] + partition_size[i-1];
                                        else
                                          start_addr_arr[i] == ram_start;
                                       }
  
  function void display();
    $display ("------ Memory Block --------");
    $display ("RAM StartAddr   = 0x%0h", ram_start);
    $display ("RAM EndAddr     = 0x%0h", ram_end);
    $display ("Number of partitions = %0d", num_of_partition);
    $display ("------ Partitions --------");
    foreach (start_addr_arr[i])
      $display ("Partition %0d start = 0x%0h & partition size=%d bytes", i, start_addr_arr[i],partition_size[i]);
  endfunction
  
endclass

module tb;
  mem_partition_unequal m1;
  
  initial begin
    m1=new();
    m1.ram_start = 32'h0;
    m1.ram_end = 32'h7FF;
    assert(m1.randomize()) else
      $fatal(0,"Randomization error");
    m1.display();
  end
endmodule