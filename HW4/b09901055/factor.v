module factor (
	input  clk,
	input  rst_n,
	input  i_in_valid,
	input  [11:0] i_n,
	output [3:0]  o_p2,
	output [2:0]  o_p3,
	output [2:0]  o_p5,
	output        o_out_valid,
	output [50:0] number
);

wire i_valid, o_valid;

wire [50:0] n0, n1, n2, n3, n4, n5, n6, n7, n8, n9;
wire [50:0] n20, n21, ni3,ni5;
wire [50:0] no, nc0, nc1, nc2, nc3;
wire [50:0] n30, n31, n32, n33, n50, n51, n52, n53,n67;

// input_valid
wire [11:0] t2, t2_n, t2_out;
wire [11:0] t3, t3_n, t3_out;
wire [11:0] tmpt1,tmpt2,tmp_out;
wire [11:0] t5, t5_n, t5_out;
FD2 f1(i_valid, i_in_valid, clk, rst_n, n8);

wire [11:0] div3, div5;
MUX m1(t2_out, i_n, i_valid, t2, n20);
MUX m2(t2, {1'b0, t2[11:1]}, t2[0], t2_n, n21);
MUX m5(t5_out, i_n, i_valid, t5, n50);
Five_checker ch5(t5, five, n51); 
Five_divider d5(t5, div5, n52);
MUX m6(div5, t5, five, t5_n, n53);
MUX m3(t3_out, i_n, i_valid, t3, n30);
Tree_checker c3(t3, three, n31); 
Three_divider d3(t3, div3, n32);
MUX m4(div3, t3, three, t3_n, n33);
Tree_module tt1(tmpt1,tmpt2,n67);


IV i0(stp3, three, ni3);
IV i1(stp5, five, ni5);
AN3 a0(o_valid, t2[0], stp3, stp5, no);
FD2 f2(o_out_valid, o_valid, clk, rst_n, n9);

wire [3:0] c, c_n, c_out;
wire [3:0] c2, c2_n, c2_out;
MUX #(4) m7(c_out, 4'b0000, i_valid, c, nc0);      
MUX #(4) m8(c2_out, 4'b0000, i_in_valid, c2, nc1); 
Counter cout1(c, c_n, nc2);
Counter cout2(c2, c2_n, nc3);

REGP #(5) r3(clk, rst_n, c_out, c_n, n3);
REGP #(5) r4(clk, rst_n, c2_out, c2_n, n4);
REGP #(4) r5(t2[0], rst_n, o_p2, c2, n5);
REGP #(3) r66(stp3, rst_n, o_p3, c[2:0], n6);
REGP #(3) r7(stp5, rst_n, o_p5, c[2:0], n7);
REGP #(12) r0(clk, rst_n, t2_out, t2_n, n0);
REGP #(12) r1(clk, rst_n, t3_out, t3_n, n1);
REGP #(12) r2(clk, rst_n, t5_out, t5_n, n2);

assign number = n0 + n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8 + n9
			+ n20 + n21 + ni3 + ni5 + no + nc0 + nc1 + nc2 + nc3
			+ n30 + n31 + n32 + n33 + n50 + n51 + n52 + n53+n67;

endmodule



//BW-bit FD2
module REGP#(
	parameter BW = 2
)(
	input clk,
	input rst_n,
	output [BW-1:0] Q,
	input [BW-1:0] D,
	output [50:0] number
);

wire [50:0] numbers [0:BW-1];

genvar i;
generate
	for (i=0; i<BW; i=i+1) begin
		FD2 f0(Q[i], D[i], clk, rst_n, numbers[i]);
	end
endgenerate

//sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<BW; j=j+1) begin 
		sum = sum + numbers[j];
	end
end

assign number = sum;

endmodule

module Counter(
	input [3:0] in,
	output [3:0] out,
	output [50:0] number
);

wire [1:0] inv;
wire [3:0] s;
wire [50:0] num [0:9];

IV i1(out[0], in[0], num[0]); 

IV i2(inv[1], in[1], num[1]);
IV i3(inv[0], in[2], num[2]);

EO e1(out[1], in[1], in[0], num[3]);
ND2 an1(s[0], in[2], inv[1], num[4]);
ND2 an2(s[1], in[2], out[0], num[5]);
ND3 an3(s[2], inv[0], in[1], in[0], num[6]);
ND3 o1(out[2], s[0], s[1], s[2], num[7]);
AN3 an4(s[3], in[2], in[1], in[0], num[8]);
OR2 o2(out[3], in[3], s[3], num[9]);

//sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<10; j=j+1) begin 
		sum = sum + num[j];
	end
end

assign number = sum;

endmodule

module Tree_module(
	input [11:0] tempt,
	output [11:0] tempt_3,
	output [50:0] number);

wire [11:0] div3;
wire [3:0] check_3;
wire [50:0] num [0:2];

Tree_checker t1(tempt,check_3,num[0]);
Three_divider t2(tempt,div3,num[1]);
MUX m1(div3,tempt,check_3,tempt_3,num[2]);

reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<5; j=j+1) begin 
		sum = sum + num[j];
	end
end

assign number = sum;


endmodule

module Five_module(
	input [11:0] tempt,
	output [11:0] tempt_5,
	output [50:0] number);

wire [11:0] div5;
wire [3:0] check_5;
wire [50:0] num [0:2];

Tree_checker t1(tempt,check_5,num[0]);
Three_divider t2(tempt,div5,num[1]);
MUX m1(div5,tempt,check_5,tempt_5,num[2]);

reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<5; j=j+1) begin 
		sum = sum + num[j];
	end
end

assign number = sum;


endmodule

module SkipAdder(
	input a, b, cin,
	output s, cout,
	output [50:0] number
);

wire [50:0] num [0:4];
wire tempt ;
wire [3:0] t;

FA1 g1(t[3], t[2], a, b, 1, num[0]);
FA1 g2(t[1], t[0], a, b, 0, num[1]);
MUX21H m0(s, t[0], t[2], cin, num[2]);
AN2 g3(tempt, t[3], cin, num[3]);
OR2 g4(cout, t[1], tempt, num[4]);

//sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<5; j=j+1) begin 
		sum = sum + num[j];
	end
end

assign number = sum;

endmodule

module MUX#(
	parameter BW = 12
)(
	input [BW-1:0] in1, 
	input [BW-1:0] in2, 
	input ctrl,
	output [BW-1:0] out,
	output [50:0] number
);

wire [50:0] numbers [0:BW-1];

genvar i;
generate
	for (i=0; i<BW; i=i+1) begin
		MUX21H m0(out[i], in2[i], in1[i], ctrl, numbers[i]);
	end
endgenerate

//sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<BW; j=j+1) begin 
		sum = sum + numbers[j];
	end
end

assign number = sum;

endmodule


module Tree_checker (
	input  [11:0] in,
	output valid,
	output [50:0] number
);

wire [3:0] three;
wire [3:0] tempt1, tempt2;
wire [11:0] s;
wire [1:0] h1, h2;
wire [2:0] ss;
wire t;
wire [2:0] three_inv;
wire [5:0] c;
wire [50:0] num [0:28];
wire [1:0] no;

// add all bit
FA1 g1(s[1], s[0], in[0], in[2], in[4], num[0]);
FA1 g2(s[3], s[2], in[6], in[8], in[10],num[1]);
FA1 g3(s[5], s[4], in[1], in[3], in[5], num[2]);
FA1 g4(s[7], s[6], in[7], in[9], in[11], num[3]);
FA1 g5(h1[1], h1[0], s[0], s[2],0, num[4]);
FA1 g6(h2[1], h2[0], s[1], s[3],0, num[5]);
EO e1(tempt1[1], s[5], s[4], num[8]);
EO e2(tempt2[1], s[7], s[6], num[9]);
OR2 o1(tempt1[2], s[5], s[4], num[6]);
OR2 o2(tempt2[2], s[7], s[6], num[7]);


AN2 an3(tempt1[3],tempt1[2],tempt1[2],num[10]);
AN2 an4(tempt2[3],tempt2[2],tempt2[2],num[11]);

FA1 g8(s[9], s[8], tempt1[1], tempt2[1], h1[1], num[13]);
FA1 g9(s[11], s[10], tempt1[2], tempt2[2], h2[1], num[14]);
FA1 g7(ss[0], three[0], s[4], s[6], h1[0], num[12]);
FA1 g10(ss[1], three[1], ss[0], s[8], h2[0], num[15]);
EO3 e3(t, tempt1[3], tempt2[3], s[11], num[16]);
FA1 g11(ss[2], three[2], ss[1], s[9], s[10], num[17]);
EO e4(three[3], t, ss[2], num[18]);

IV iv1(three_inv[0], three[0], num[19]);
IV iv2(three_inv[1], three[1], num[20]);
IV iv3(three_inv[2], three[2], num[21]);
// check multuple of three

OR4 n1(c[0], three[3], three[2], three[1], three[0], num[22]);
OR4 n2(c[1], three[3], three[2], three_inv[1], three_inv[0], num[23]);
OR4 n3(c[2], three[3], three_inv[2], three_inv[1], three[0], num[24]);
ND4 a1(c[3], three[3], three[2], three_inv[1], three[0], num[25]);
ND4 a2(c[4], three[3], three_inv[2], three[1], three_inv[0], num[26]);
AN3 o4(c[5], c[0], c[1], c[2], num[27]);
ND3 o5(valid, c[3], c[4], c[5], num[28]);

// sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<29; j=j+1) begin 
		sum = sum + num[j];
	end
end

assign number = sum;

endmodule

module Three_divider (
	input  [11:0] in,
	output [11:0] out,
	output [50:0] number
);


wire [50:0] num [0:43];

wire [1:0]  f21, f22, f23, f24, f25, f26, f31, f32, f33, f34, f35;
wire [1:0] h20,h30, h31, f30, h32;
wire [25:0] t;
wire [16:0] t1;
wire tempt;
wire [9:0] c;

FA1 g0(t[1], t[0], in[7], in[9], in[11], num[0]);
FA1 g1(t[3], t[2], in[6], in[8], in[10], num[1]);
FA1 g2(t[5], t[4], in[5], in[7], in[9], num[2]);
FA1 g3(t[7], t[6], in[4], in[6], in[8], num[3]);
FA1 g4(t[9], t[8], in[3], in[5], in[7], num[4]);
FA1 g5(t[11], t[10], in[2], in[4], in[6], num[5]);
FA1 g6(t[13], t[12], in[8], in[10], 1, num[6]);
FA1 g7(t[15], t[14], in[1], in[3], in[5], num[7]);
FA1 g8(t[17], t[16], in[7], in[9], in[11], num[8]);
FA1 g9(t[19], t[18], in[0], in[2], in[4], num[9]);
FA1 g10(t[21], t[20], in[6], in[8], in[10], num[10]);
FA1 g11(t[23], t[22], in[11], in[1], in[3], num[11]);
FA1 g12(t[25], t[24], in[5],in[7], in[9], num[12]);

FA1 g13(t1[1], t1[0], in[8], in[10], t[1], num[13]);
FA1 g14(f21[1], f21[0], in[11], t[4], t[7], num[14]);
FA1 g15(f22[1], f22[0], in[10], t[6], t[9], num[15]);
FA1 g16(f23[1], f23[0], in[9], in[11], t[8], num[16]);
FA1 gg0(h20[1], h20[0], t[11], t[13],0, num[17]);
FA1 g17(f24[1], f24[0], t[10], t[12], t[15], num[18]);
FA1 g18(f25[1], f25[0], t[14], t[16], t[19], num[19]);
FA1 g19(f26[1], f26[0], t[18], t[20], t[23], num[20]);
AN2 a0(tempt, t[22], t[24], num[21]);

FA1 gg1(h30[1], h30[0], in[9], in[11],0, num[22]);
FA1 gg2(h31[1], h31[0], t[0], t[3], 0,num[23]);
FA1 g20(f30[1], f30[0], t[2], t[5], f21[1], num[24]);
FA1 gg3(h32[1], h32[0], f21[0], f22[1], 0,num[25]);
FA1 g21(f31[1], f31[0], f22[0], f23[1], h20[1], num[26]);
FA1 g22(f32[1], f32[0], f23[0], h20[0], f24[1], num[27]);
FA1 g23(f33[1], f33[0], t[17], f24[0], f25[1], num[28]);
FA1 g24(f34[1], f34[0], t[21], f25[0], f26[1], num[29]);
FA1 g25(f35[1], f35[0], t[25], f26[0], tempt, num[30]);

AN2 an2(c[0], f34[0], f35[1], num[31]);
SkipAdder cs0(f33[0], f34[1], c[0], out[0], c[1], num[32]);
SkipAdder cs1(f32[0], f33[1], c[1], out[1], c[2], num[33]);
SkipAdder cs2(f31[0], f32[1], c[2], out[2], c[3], num[34]);
SkipAdder cs3(h32[0], f31[1], c[3], out[3], c[4], num[35]);
SkipAdder cs4(f30[0], h32[1], c[4], out[4], c[5], num[36]);
SkipAdder cs5(h31[0], f30[1], c[5], out[5], c[6], num[37]);
SkipAdder cs6(t1[0], h31[1], c[6], out[6], c[7], num[38]);
SkipAdder cs7(h30[0], t1[1], c[7], out[7], c[8], num[39]);
SkipAdder cs8(in[10], h30[1], c[8], out[8], c[9], num[40]);
EO eo0(out[9], in[11], c[9], num[41]);
AN2 a3(out[10], in[11], c[9], num[42]);

AN2 a41(out[11],0,0,num[43]);

//sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<44; j=j+1) begin 
		sum = sum + num[j];
	end
end

assign number = sum;

endmodule

module Five_checker (
	input  [11:0] in,
	output valid,
	output [50:0] number
);

wire [3:0] t;
wire [3:0] t1, t2, t3;
wire [1:0] h11, h12, h13, h21, h22, h23;
wire [1:0] f1, f2, f3, f4, f5;
wire e1, e2;
wire f00, f01,f02;
wire i0, i2;
wire [2:0] c;

wire [50:0] num [0:28];

OR2 o1(t1[2], in[2], in[3], num[0]);
OR2 o2(t2[2], in[6], in[7], num[1]);
OR2 o3(t3[2], in[10], in[11], num[2]);
EO eo1(t1[1], in[2], in[3], num[3]);
EO eo2(t2[1], in[6], in[7], num[4]);
EO eo3(t3[1], in[10], in[11], num[5]);

FA1 g1(h11[1], h11[0], in[0], in[2],0, num[6]);
FA1 g2(h21[1], h21[0], in[1], t1[1], 0,num[7]);
FA1 g3(h12[1], h12[0], in[4], in[6],0, num[8]);
FA1 g4(h22[1], h22[0], in[5], t2[1],0, num[9]);
FA1 g5(h13[1], h13[0], in[8], in[10],0, num[10]);
FA1 g6(h23[1], h23[0], in[9], t3[1],0, num[11]);
FA1 gate1(f1[1], f1[0], t1[2], t2[2], t3[2], num[12]);
EO3 gate4(e1, t1[2], t2[2], t3[2], num[13]);

FA1 gg2(f00, t[0], h11[0], h12[0], h13[0], num[14]);
FA1 gg3(f2[1], f2[0], h11[1], h12[1], h13[1], num[15]);
FA1 gg4(f3[1], f3[0], h21[0], h22[0], h23[0], num[16]);
FA1 gg5(f4[1], f4[0], h21[1], h22[1], h23[1], num[17]);

FA1 gg6(f01, t[1], f00, f2[0], f3[0], num[18]);
FA1 gg7(f5[1], f5[0], f1[0], f2[1], f3[1], num[19]);
EO3 ga5(e2, f1[1], e1, f4[1], num[20]);
FA1 gg8(f02, t[2], f4[0], f01, f5[0], num[21]);
EO3 e01(t[3], f5[1], e2, f02, num[22]);

// check multiple of five
IV iv1(i0, t[0], num[23]);
IV iv2(i2, t[2], num[24]);
OR4 n1(c[0], t[3], t[2], t[1], t[0], num[25]);
OR4 n2(c[1], t[3], i2, t[1], i0, num[26]);
ND4 a1(c[2], t[3], i2, t[1], t[0], num[27]);
ND3 o4(valid, c[0], c[1], c[2], num[28]);

// sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<29; j=j+1) begin 
		sum = sum + num[j];
	end
end

assign number = sum;

endmodule


module Five_divider (
	input  [11:0] in,
	output [11:0] out,
	output [50:0] number
);

wire [50:0] num [0:40];

wire [1:0] f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f110, f111;
wire [1:0]	 f20, f21, f22, f23, f24, f25, f26,
					 h30, h31, f30, h32, h33, f31, f32, f33, f34;
wire tempt;
wire [8:0] c;

FA1 fa0(f10[1], f10[0], in[7], in[8], in[11], num[0]);
FA1 fa1(f11[1], f11[0], in[6], in[7], in[10], num[1]);
FA1 fa2(f12[1], f12[0], in[5], in[6], in[9], num[2]);
FA1 fa3(f13[1], f13[0], in[4], in[5], in[8], num[3]);
FA1 fa4(f14[1], f14[0], in[3], in[4], in[7], num[4]);
FA1 fa5(f15[1], f15[0], in[8], in[11], 1, num[5]);
FA1 fa6(f16[1], f16[0], in[2], in[3], in[6], num[6]);
FA1 fa7(f17[1], f17[0], in[7], in[10], in[11], num[7]);
FA1 fa8(f18[1], f18[0], in[1], in[2], in[5], num[8]);
FA1 fa9(f19[1], f19[0], in[6], in[9], in[10], num[9]);
FA1 fa10(f110[1], f110[0], in[0], in[1], in[4], num[10]);
FA1 fa11(f111[1], f111[0], in[5], in[8], in[9], num[11]);

FA1 fa12(f20[1], f20[0], in[8], in[9], f10[1], num[12]);
FA1 fa13(f21[1], f21[0], in[11], f11[0], f12[1], num[13]);
FA1 fa14(f22[1], f22[0], in[10], f12[0], f13[1], num[14]);
FA1 fa15(f23[1], f23[0], in[9], f13[0], f14[1], num[15]);
FA1 fa16(f24[1], f24[0], f14[0], f15[0], f16[1], num[16]);
FA1 fa17(f25[1], f25[0], f16[0], f17[0], f18[1], num[17]);
FA1 fa18(f26[1], f26[0], f18[0], f19[0], f110[1], num[18]);
AN2 a0(tempt, f110[0], f111[0], num[19]);

FA1 ffa1(h30[1], h30[0], in[10], in[11],0, num[20]);
FA1 ffa2(h31[1], h31[0], in[9], in[10], 0,num[21]);
FA1 fa19(f30[1], f30[0], f10[0], f11[1], f21[1], num[22]);
FA1 ffa3(h32[1], h32[0], f21[0], f22[1],0, num[23]);
FA1 ffa4(h33[1], h33[0], f22[0], f23[1],0, num[24]);
FA1 fa20(f31[1], f31[0], f15[1], f23[0], f24[1], num[25]);
FA1 fa21(f32[1], f32[0], f17[1], f24[0], f25[1], num[26]);
FA1 fa22(f33[1], f33[0], f19[1], f25[0], f26[1], num[27]);
FA1 fa23(f34[1], f34[0], f111[1], f26[0], tempt, num[28]);

AN2 an2(c[0], f33[0], f34[1], num[29]);
SkipAdder cs0(f32[0], f33[1], c[0], out[0], c[1], num[30]);
SkipAdder cs1(f31[0], f32[1], c[1], out[1], c[2], num[31]);
SkipAdder cs2(h33[0], f31[1], c[2], out[2], c[3], num[32]);
SkipAdder cs3(h32[0], h33[1], c[3], out[3], c[4], num[33]);
SkipAdder cs4(f30[0], h32[1], c[4], out[4], c[5], num[34]);
SkipAdder cs5(f20[0], f30[1], c[5], out[5], c[6], num[35]);
SkipAdder cs6(h31[0], f20[1], c[6], out[6], c[7], num[36]);
SkipAdder cs7(h30[0], h31[1], c[7], out[7], c[8], num[37]);
SkipAdder cs8(in[11], h30[1], c[8], out[8], out[9], num[38]);

AN2 a1(out[10],0,0,num[39]);
AN2 a3(out[11],0,0,num[40]);

//sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<41; j=j+1) begin 
		sum = sum + num[j];
	end
end

assign number = sum;

endmodule
