module mux1bit2_1 (input a,b,sel,output out);
  
  assign out = sel ? b : a;
  
endmodule

module mux3bit2_1 (input [2:0] a,b,input sel,output [2:0] out);
  
  mux1bit2_1 r1 (a[0],b[0],sel,out[0]);
  mux1bit2_1 r2 (a[1],b[1],sel,out[1]);
  mux1bit2_1 r3 (a[2],b[2],sel,out[2]);
  
endmodule

module mux5bit2_1 (input [4:0] a,b,input sel,output [4:0] out);
  
  mux1bit2_1 r1 (a[0],b[0],sel,out[0]);
  mux1bit2_1 r2 (a[1],b[1],sel,out[1]);
  mux1bit2_1 r3 (a[2],b[2],sel,out[2]);
  mux1bit2_1 r4 (a[3],b[3],sel,out[3]);
  mux1bit2_1 r5 (a[4],b[4],sel,out[4]);
  
endmodule

module and0(input a,b,output out);
  
  assign out = a & b;
  
endmodule

module and1(input a,b,c,output out);
  
  assign out = a & b & c;
  
endmodule

module and2(input a,b,c,d,output out);
  
  assign out = a & b & c & d;
  
endmodule

module and3(input a,b,c,d,e,output out);
  
  assign out = a & b & c & d & e;
  
endmodule

module or0(input a,b,output out);
  
  assign out = a | b;
  
endmodule
module or1(input a,b,c,output out);
  
  assign out = a | b | c;
  
endmodule

module or2(input a,b,c,d,output out);
  
  assign out = a | b | c | d;
  
endmodule

module or3(input a,b,c,d,e,output out);
  
  assign out = a | b | c | d | e;
  
endmodule


module com1bit (input a,b,output eq,non_eq);
  
  assign eq = (a == b);
  assign non_eq = (a != b);
  
endmodule

module com3bit (input [2:0] a,b,output eq,non_eq);
  
  wire [2:0] eqi,non_eqi;
  
  com1bit u1 (a[2],b[2],eqi[2],non_eqi[2]);
  com1bit u2 (a[1],b[1],eqi[1],non_eqi[1]);
  com1bit u3 (a[0],b[0],eqi[0],non_eqi[0]);
  
  and1 u4 (eqi[2],eqi[1],eqi[0],eq);
  or1 u5 (non_eqi[2],non_eqi[1],non_eqi[0],non_eq);
  
endmodule

module com4bit (input [3:0] a,b,output eq,non_eq);
  
  wire [3:0] eqi,non_eqi;
  
  com1bit u1 (a[3],b[3],eqi[3],non_eqi[3]);
  com1bit u2 (a[2],b[2],eqi[2],non_eqi[2]);
  com1bit u3 (a[1],b[1],eqi[1],non_eqi[1]);
  com1bit u4 (a[0],b[0],eqi[0],non_eqi[0]);
  
  and2 u5 (eqi[3],eqi[2],eqi[1],eqi[0],eq);
  or2 u6 (non_eqi[3],non_eqi[2],non_eqi[1],non_eqi[0],non_eq);
  
endmodule

module com5bit (input [4:0] a,b,output eq,non_eq);
  
  wire [4:0] eqi,non_eqi;
  
  com1bit u1 (a[4],b[4],eqi[4],non_eqi[4]);
  com1bit u2 (a[3],b[3],eqi[3],non_eqi[3]);
  com1bit u3 (a[2],b[2],eqi[2],non_eqi[2]);
  com1bit u4 (a[1],b[1],eqi[1],non_eqi[1]);
  com1bit u5 (a[0],b[0],eqi[0],non_eqi[0]);
  
  and3 u6 (eqi[4],eqi[3],eqi[2],eqi[1],eqi[0],eq);
  or3 u7 (non_eqi[4],non_eqi[3],non_eqi[2],non_eqi[1],non_eqi[0],non_eq);
  
endmodule


module full_adder(input a,b,cin,output sum,cout);
  
  assign sum  = a ^ b ^ cin;
  assign cout = (a & b) | (b & cin) | (a & cin);

endmodule

module inc3(input  [2:0] a,output [2:0] sum);
  
  wire c1, c2;
  
  full_adder f1(a[0],1'b1,1'b0,sum[0],c1);
  full_adder f2(a[1],1'b0,c1,sum[1],c2);
  full_adder f3(a[2],1'b0,c2,sum[2]);

endmodule

module inc5(input  [4:0] a,output [4:0] sum);
  
  wire c1, c2, c3, c4;
  
  full_adder f1(a[0], 1'b1, 1'b0, sum[0], c1);
  full_adder f2(a[1], 1'b0, c1,   sum[1], c2);
  full_adder f3(a[2], 1'b0, c2,   sum[2], c3);
  full_adder f4(a[3], 1'b0, c3,   sum[3], c4);
  full_adder f5(a[4], 1'b0, c4,   sum[4]);

endmodule


module counter (input clk,rst,output reg [2:0] count);

  always @(posedge clk or posedge rst) begin
    if(rst)
        count <= 0;
    else if(count == 3)
        count <= 0;
    else
        count <= count + 1;
  end
  
endmodule


module dff1bit (input clk,rst,din,output reg dout);
  
  always @ (posedge clk or posedge rst) begin
    if (rst)
      dout <= 0;
    else
      dout <= din;
  end
  
endmodule

module dff4bitu (input clk,rst,input s_in,output [3:0] q);
    
  dff1bit u1 (clk,rst,s_in,q[3]);
  dff1bit u2 (clk,rst,q[3],q[2]);
  dff1bit u3 (clk,rst,q[2],q[1]);
  dff1bit u4 (clk,rst,q[1],q[0]);
    
endmodule

module dff5bits (input clk,rst,input [4:0] in,output [4:0] out);
  
  dff1bit u1 (clk,rst,in[0],out[0]);
  dff1bit u2 (clk,rst,in[1],out[1]);
  dff1bit u3 (clk,rst,in[2],out[2]);
  dff1bit u4 (clk,rst,in[3],out[3]);
  dff1bit u5 (clk,rst,in[4],out[4]);
  
endmodule

module dff4bits (input clk,rst,input [3:0] in,output [3:0] out);
  
  dff1bit u1 (clk,rst,in[0],out[0]);
  dff1bit u2 (clk,rst,in[1],out[1]);
  dff1bit u3 (clk,rst,in[2],out[2]);
  dff1bit u4 (clk,rst,in[3],out[3]);
    
endmodule

module dff3bits (input clk,rst,input [2:0] in1,output [2:0] out1);
  
  dff1bit u1 (clk,rst,in1[0],out1[0]);
  dff1bit u2 (clk,rst,in1[1],out1[1]);
  dff1bit u3 (clk,rst,in1[2],out1[2]);
    
endmodule


module locker (input clk,rst,s_in,input [3:0] in,output open);
  
  wire rst_int,s_in_blocked,rst_shift;
  wire eq1,non_eq1,eq2,non_eq2,eq3,non_eq3,eq4,non_eq4;
  wire b, b1,block;
  
  wire [3:0] q, out;
  wire [2:0] cnt;
  
  wire [2:0] attempt_cnt,attempt_cnt_next,attempt_temp;
  wire [4:0] timer_cnt,timer_cnt_next,timer_temp;

  wire [2:0] attempt_plus1;
  wire [4:0] timer_plus1;

  assign rst_int = rst;
  
  or0 r1 (rst,eq4,rst_shift);
  
  dff4bitu r2 (clk,rst_shift,s_in_blocked,q);
  
  dff4bits r3 (clk,rst_int,in,out);
  
  counter r4 (clk,rst_shift,cnt);
  
  com3bit r5 (cnt,3'd3,eq1,non_eq1);
  
  com4bit r6 (q,out,eq2,non_eq2);
  
  and0 r7 (eq1,eq2,open);
  
  com3bit r8 (attempt_cnt,3'b101,eq3,non_eq3);
  
  and1 r9 (eq1,non_eq2,non_eq3,b);
  
  inc3 r10 (attempt_cnt, attempt_plus1);
  
  mux3bit2_1 r11 (attempt_cnt, attempt_plus1, b, attempt_temp);
  
  mux3bit2_1 r12 (attempt_temp, 3'b000, eq4, attempt_cnt_next);
  
  dff3bits r13 (clk, rst_int, attempt_cnt_next, attempt_cnt);
  
  com5bit r14 (timer_cnt,5'd30,eq4,non_eq4);
  
  and0 r15 (eq3,non_eq4,b1);
  
  inc5 r16 (timer_cnt, timer_plus1);
  
  mux5bit2_1 r17 (timer_cnt, timer_plus1, b1, timer_temp);

  mux5bit2_1 r18 (timer_temp, 5'b00000, eq4, timer_cnt_next);
  
  dff5bits r19 (clk, rst_int, timer_cnt_next, timer_cnt);
  
  and0 r20 (eq3,non_eq4,block);
  
  mux1bit2_1 r21 (s_in,1'b0,block,s_in_blocked);
  
endmodule


module locker_golden (
    input clk,
    input rst,
    input s_in,
    input [3:0] in,
    output open
);

  reg [3:0] shift_reg;
  reg [1:0] bit_count;

  reg [2:0] attempt_cnt;
  reg [4:0] timer_cnt;

  wire match;
  wire block;
  wire [3:0] next_shift;

  assign match = (shift_reg == in);

  assign block = (attempt_cnt == 3'b101) &&
                 (timer_cnt < 5'd30);

  assign next_shift = {s_in, shift_reg[3:1]};

  assign open = (bit_count == 2'd3) &&
                (shift_reg == in);


  always @(posedge clk or posedge rst) begin

    if (rst) begin

      shift_reg   <= 4'b0000;
      bit_count   <= 2'b00;
      attempt_cnt <= 3'b000;
      timer_cnt   <= 5'b00000;

    end

    else begin

      if (timer_cnt == 5'd30) begin

        timer_cnt   <= 5'd0;
        attempt_cnt <= 3'd0;

        shift_reg   <= 4'b0000;
        bit_count   <= 2'b00;

      end

      else if (block) begin

        shift_reg <= {1'b0, shift_reg[3:1]};

        timer_cnt <= timer_cnt + 1'b1;

      end

      else begin

        shift_reg <= next_shift;

        bit_count <= bit_count + 1'b1;

        if (bit_count == 2'd3) begin

          bit_count <= 2'd0;

          if (!match) begin
            attempt_cnt <= attempt_cnt + 1'b1;
          end

        end

      end

    end

  end

endmodule
