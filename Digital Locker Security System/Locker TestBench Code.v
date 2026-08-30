module tb;
  
  reg clk, rst, s_in;
  reg [3:0] in;

  wire open_dut, open_ref;

  integer error_count = 0;
  integer i;
  
  locker dut (.clk(clk),.rst(rst),.s_in(s_in),.in(in),.open(open_dut));
  
  locker_golden ref1 (.clk(clk),.rst(rst),.s_in(s_in),.in(in),.open(open_ref));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb);
  end

  always @(posedge clk) begin
    
    $display("t=%0t | Secrete Code=%b | User Input dut ref %b %b | attempt=%0d | timer=%0d | open dut ref %b %b",$time, dut.out, dut.q,ref1.shift_reg, dut.attempt_cnt, dut.timer_cnt, open_dut,open_ref);
  
  end
  
  always @(posedge clk) begin
    
    if (open_dut != open_ref) begin
      $display("MISMATCH t=%0t | open dut ref %b %b | attempt=%0d timer=%0d",$time, open_dut, open_ref,dut.attempt_cnt, dut.timer_cnt);
      
      error_count = error_count + 1;
    end
    
  end
  
  always @(posedge clk) begin
    
    if (dut.attempt_cnt > 5)
      $display("ERROR: Attempt exceeded limit at t=%0t", $time);

    if (dut.timer_cnt > 30)
      $display("ERROR: Timer exceeded limit at t=%0t", $time);
  end

  task send_input;
    input [3:0] data;
    integer j;
    begin
      for (j = 0; j < 4; j = j + 1) begin
        s_in = data[j];
        #10;
      end
    end
  
  endtask

  task send_random;
    reg [3:0] data;
    begin
      data = $random;
      send_input(data);
    end
    
  endtask

  initial begin

    rst = 1; s_in = 0; in = 4'b1111;
    #20 rst = 0;

    repeat (5) send_input(4'b1010);

    #300;

    send_input(4'b0000); 
    #10;
    send_input(4'b1111);

    #40;

    if (error_count == 0)
      $display("TEST PASSED");
    else
      $display("TEST FAILED with %0d errors", error_count);

    $finish;
  end

endmodule
