//2KB Memory with unequal partitions & hollow regions in between
class mem_partition_unequal_hollow;
  
  bit [31:0] ram_start; //ram start address
  bit [31:0] ram_end;   //ram end address
  
  rand bit [31:0] num_of_partition; //number of partitions
  rand bit [31:0] partition_size[]; //size of each partition
  rand bit [31:0] start_addr_arr[]; //array to capture start address of each partition
  rand bit [31:0] hollow_region[]; //hollow regions
  
  //num of partition (can be configured/constrained by the user)
  constraint n_part {num_of_partition > 4;
                               num_of_partition  < 10;}
  
  //size of each partition with hollow region
  constraint part_size {partition_size.size() == num_of_partition;
                        hollow_region.size() == num_of_partition - 1; //hollow regions are always 1 less than the total number of partitions
                        partition_size.sum() + hollow_region.sum() == ram_end - ram_start + 1;
                        foreach(partition_size[i]){
                          partition_size[i] inside {16,32,64,128,512,1024}; //configured by user
                        if(i< hollow_region.size())
                          hollow_region[i] inside {16,32,64,128,512,1024};
                        }}
  //start address of each partition
  constraint start_addr_each_partition {start_addr_arr.size() == num_of_partition;
                                        foreach(start_addr_arr[i])
                                          if(i)
                                            start_addr_arr[i] == start_addr_arr[i-1] + partition_size[i-1] + hollow_region[i-1];
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
      $display ("Partition %0d start = 0x%0h & partition size=%d bytes & hollow region = %d bytes", i, start_addr_arr[i],partition_size[i],hollow_region[i]);
  endfunction
  
endclass

module tb;
  mem_partition_unequal_hollow m1;
  
  initial begin
    m1=new();
    m1.ram_start = 32'h0;
    m1.ram_end = 32'h7FF;
    assert(m1.randomize()) else
      $fatal(0,"Randomization error");
    m1.display();
  end
endmodule