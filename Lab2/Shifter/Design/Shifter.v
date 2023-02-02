module Shifter( result, leftRight, sftSrc );
    
  output wire[15:0] result;

  input wire leftRight;
  input wire[15:0] sftSrc;
  /*your code here*/
  
  //用2-to-1 mux和leftRight去決定說要把左邊的還是右邊的訊號拉給result 
  assign result[0] = leftRight ? 0 : sftSrc[1];
  assign result[1] = leftRight ? sftSrc[0] : sftSrc[2];
  assign result[2] = leftRight ? sftSrc[1] : sftSrc[3];
  assign result[3] = leftRight ? sftSrc[2] : sftSrc[4];
  assign result[4] = leftRight ? sftSrc[3] : sftSrc[5];
  assign result[5] = leftRight ? sftSrc[4] : sftSrc[6];
  assign result[6] = leftRight ? sftSrc[5] : sftSrc[7];
  assign result[7] = leftRight ? sftSrc[6] : sftSrc[8];
  assign result[8] = leftRight ? sftSrc[7] : sftSrc[9];
  assign result[9] = leftRight ? sftSrc[8] : sftSrc[10];
  assign result[10] = leftRight ? sftSrc[9] : sftSrc[11];
  assign result[11] = leftRight ? sftSrc[10] : sftSrc[12];
  assign result[12] = leftRight ? sftSrc[11] : sftSrc[13];
  assign result[13] = leftRight ? sftSrc[12] : sftSrc[14];
  assign result[14] = leftRight ? sftSrc[13] : sftSrc[15];
  assign result[15] = leftRight ? sftSrc[14] : 0;

endmodule
