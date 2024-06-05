module ramcontroller (
  inout [15:0] ramdatain1,
  inout [15:0] ramdatain2,
  output [16:0] addressram1,
  output [16:0] addressram2,
  output clockenable,
  output ramclock,
  output cs1,
  output cs2,
  inout dqs1,
  inout dqs2,
  output reset,
  
);
  
endmodule
