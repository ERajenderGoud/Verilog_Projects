module tb;
  
  reg clk,rst,load;
  reg [3:0] u_in_h,u_in_m,u_in_s;
  wire [3:0] hours,minutes,seconds;
  reg [3:0] ref_h,ref_m,ref_s;
  
  integer errors = 0;
  
  clock dut1 (clk,rst,load,u_in_h,u_in_m,u_in_s,hours,minutes,seconds);
  
  ref_clock dut2 (clk,rst,load,u_in_h,u_in_m,u_in_s,ref_h,ref_m,ref_s);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  
  always @(posedge clk) begin
      
      if (hours != ref_h || minutes != ref_m || seconds != ref_s) begin
        $display("ERROR at Time=%0t | DUT=%0d:%0d:%0d | REF=%0d:%0d:%0d",$time,hours, minutes, seconds,ref_h, ref_m, ref_s);
        errors = errors + 1;
      end
  end
  
  initial begin

    $monitor("Time=%0t | Load=%d | input=%0d:%0d:%0d | Clock(DUT)=%0d:%0d:%0d |Clock(REF)=%0d:%0d:%0d",$time,load,u_in_h,u_in_m,u_in_s,hours,minutes,seconds,ref_h,ref_m,ref_s);
    
    rst = 1; load = 0;
    #20;
    rst = 0;
    #200;
    
    @(negedge clk);
    load = 1;
    u_in_h = 7;
    u_in_m = 5;
    u_in_s = 12;

    @(negedge clk);
    load = 0;
    #200;

    if (errors == 0)
      $display("TEST PASSED");
    else
      $display("TEST FAILED with %0d errors", errors);
    
    $finish;
    
  end
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb);
  end
  
endmodule
