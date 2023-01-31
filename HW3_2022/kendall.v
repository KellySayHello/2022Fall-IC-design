`timescale 1ns/1ps

module kendall_rank(kendall, i0_x, i0_y, i1_x, i1_y, i2_x, i2_y, i3_x, i3_y);
//DO NOT CHANGE!
    input  [3:0] i0_x, i0_y, i1_x, i1_y, i2_x, i2_y, i3_x, i3_y;
    output [3:0] kendall;
//---------------------------------------------------
    wire [5:0] smaller_x,smaller_y;

    My_module_0 M0(smaller_x[0],i0_x,i1_x);
    My_module_0 M1(smaller_y[0],i0_y,i1_y);
    My_module_0 M2(smaller_x[1],i0_x,i2_x);
    My_module_0 M3(smaller_y[1],i0_y,i2_y);
    My_module_0 M4(smaller_x[2],i0_x,i3_x);
    My_module_0 M5(smaller_y[2],i0_y,i3_y);
    My_module_0 M6(smaller_x[3],i1_x,i2_x);
    My_module_0 M7(smaller_y[3],i1_y,i2_y);
    My_module_0 M8(smaller_x[4],i1_x,i3_x);
    My_module_0 M9(smaller_y[4],i1_y,i3_y);
    My_module_0 M10(smaller_x[5],i2_x,i3_x);
    My_module_0 M11(smaller_y[5],i2_y,i3_y);

    My_module_x Mx(kendall,smaller_x,smaller_y);

endmodule

module My_module_0(out1,i0, i1 );
    input [3:0] i0, i1;
    output  out1;

    wire [3:0] i0_inv, i1_inv;
    wire [3:0] after_and1, after_and2;
    wire [2:0] after_nor;
    wire [5:0] after_second_and;

    IV Iv1(i0_inv[0],i0[0]);
    IV Iv2(i0_inv[1],i0[1]);
    IV Iv3(i0_inv[2],i0[2]);
    IV Iv4(i0_inv[3],i0[3]);

    IV Iv5(i1_inv[0],i1[0]);
    IV Iv6(i1_inv[1],i1[1]);
    IV Iv7(i1_inv[2],i1[2]);
    IV Iv8(i1_inv[3],i1[3]);

    ND2 and1(after_and1[0],i0_inv[3],i1[3]);
    AN2 and2(after_and1[1],i0_inv[2],i1[2]);
    AN2 and3(after_and1[2],i0_inv[1],i1[1]);
    AN2 and4(after_and1[3],i0_inv[0],i1[0]);

    ND2 and5(after_and2[0],i1_inv[3],i0[3]);
    AN2 and6(after_and2[1],i1_inv[2],i0[2]);
    AN2 and7(after_and2[2],i1_inv[1],i0[1]);
    AN2 and8(after_and2[3],i1_inv[0],i0[0]);

    AN2 nr1(after_nor[0],after_and1[0],after_and2[0]);
    NR2 nr2(after_nor[1],after_and1[1],after_and2[1]);
    NR2 nr3(after_nor[2],after_and1[2],after_and2[2]);

    ND2 an1(after_second_and[0],after_nor[0],after_and1[1]);
    ND3 an3(after_second_and[2],after_nor[0],after_nor[1],after_and1[2]);
    ND4 an5(after_second_and[4],after_nor[0],after_nor[1],after_nor[2],after_and1[3]);

    //out=1 smaller
    ND4 or1(out1,after_and1[0],after_second_and[0],after_second_and[2],after_second_and[4]);

endmodule

module My_module_x(kendall,smaller_x,smaller_y);
    input [5:0] smaller_x,smaller_y;
    output [3:0] kendall;

    wire [5:0] tempt1,tempt2,cordant;

    wire [3:0] t;
    wire [3:0] t_inv;
    wire tempt3;
    // wire [2:0] bit;
    // wire [2:0] bit_inv;
    wire [10:0] n;

    OR2 nr1(tempt1[0],smaller_x[0],smaller_y[0]);
    OR2 nr2(tempt1[1],smaller_x[1],smaller_y[1]);
    OR2 nr3(tempt1[2],smaller_x[2],smaller_y[2]);
    OR2 nr4(tempt1[3],smaller_x[3],smaller_y[3]);
    OR2 nr5(tempt1[4],smaller_x[4],smaller_y[4]);
    OR2 nr6(tempt1[5],smaller_x[5],smaller_y[5]);

    ND2 an1(tempt2[0],smaller_x[0],smaller_y[0]);
    ND2 an2(tempt2[1],smaller_x[1],smaller_y[1]);
    ND2 an3(tempt2[2],smaller_x[2],smaller_y[2]);
    ND2 an4(tempt2[3],smaller_x[3],smaller_y[3]);
    ND2 an5(tempt2[4],smaller_x[4],smaller_y[4]);
    ND2 an6(tempt2[5],smaller_x[5],smaller_y[5]);


    ND2 or1(cordant[0],tempt1[0],tempt2[0]);// if out=1,that means the pair is 4cordant
    ND2 or2(cordant[1],tempt1[1],tempt2[1]);
    ND2 or3(cordant[2],tempt1[2],tempt2[2]);
    ND2 or4(cordant[3],tempt1[3],tempt2[3]);
    ND2 or5(cordant[4],tempt1[4],tempt2[4]); 
    ND2 or6(cordant[5],tempt1[5],tempt2[5]);

    //part two :calculate how many pair of cordant 3*2
    FA1 fa1(t[1],t[0],cordant[0],cordant[1],cordant[2]);
    FA1 fa2(t[3],t[2],cordant[3],cordant[4],cordant[5]);

    IV gate1(t_inv[0],t[0]);
    IV gate2(t_inv[1],t[1]);
    IV gate3(t_inv[2],t[2]);
    IV gate4(t_inv[3],t[3]);

    ND3 g1(n[0],t[2],t_inv[1],t_inv[0]);
    ND3 g2(n[1],t[2],t_inv[3],t[0]);
    ND3 g3(n[2],t_inv[2],t_inv[1],t[0]);
    ND3 g4(n[3],t[2],t[1],t[3]);
    ND3 g5(n[4],t_inv[2],t[1],t_inv[0]);

    ND4 g6(n[5],t_inv[3],t[2],t_inv[1],t[0]);
    ND4 g7(n[6],t[3],t[2],t_inv[1],t_inv[0]);
    ND4 g8(n[7],t[3],t[2],t[1],t[0]);

    ND4 g9(n[8],t[3],t_inv[2],t[1],t_inv[0]);
    ND2 g10(n[9],t_inv[3],t_inv[1]);
    ND3 g11(n[10],t_inv[3],t_inv[2],t_inv[0]);

    ND4 g12(tempt3,n[0],n[1],n[2],n[3]);
    OR2 gg1(kendall[0],tempt3,n[4]);

    ND4 gg2(kendall[1],n[4],n[5],n[6],n[7]);
    ND4 gg3(kendall[2],n[8],n[9],n[10],n[0]);
    ND3 gg4(kendall[3],n[9],n[10],n[0]);
    //part three: 3+3 compute bit
    // wire c;
    // FA1 fa3(c,bit[0],t[0],t[2],0);
    // FA1 fa4(bit[2],bit[1],t[1],t[3],c);

    // //part four: translate bit to kendall;
    // IV gate1(bit_inv[0],bit[0]);
    // IV gate2(bit_inv[1],bit[1]);
    // IV gate3(bit_inv[2],bit[2]);
    
    // ND3 gate4(n[0],bit_inv[2],bit[1],bit_inv[0]);
    // ND2 gate5(n[1],bit_inv[1],bit[0]);
    // ND2 gate6(n[2],bit[2],bit_inv[1]);
    // ND3 g1(kendall[0],n[0],n[1],n[2]);

    // ND2 gate7(n[3],bit[2],bit[0]);
    // ND2 g2(kendall[1],n[0],n[3]);
 
    // ND2 gate8(n[4],bit[1],bit_inv[0]);
    // ND2 gate9(n[5],bit_inv[2],bit_inv[1]);
    // ND2 g3(kendall[2],n[4],n[5]);

    // ND2 gate10(n[6],bit_inv[2],bit_inv[0]);
    // ND2 g4(kendall[3],n[5],n[6]);

endmodule