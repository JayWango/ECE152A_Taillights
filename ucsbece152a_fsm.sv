/*
* Copyright (c) 2023, University of California; Santa Barbara
* Distribution prohibited. All rights reserved.
*
* File: ucsbece152a_fsm.sv
* Description: Starter code for fsm.
*/
module ucsbece152a_fsm import taillights_pkg::*; (
  input logic clk,
  input logic rst_n,
  
  input logic left_i,
  input logic right_i,
  input logic hazard_i,
  input logic brake_i,
  
  output state_t state_o,
  output logic [5:0] pattern_o
);

state_t state_d, state_q = S000_000;
assign state_o = state_q;

// TODO: Implement the FSM and drive `pattern_o`

always_comb begin
  case (state_q)
    S000_000: pattern_o = 6'b000_000;
    S000_100: pattern_o = 6'b000_100;
    S000_110: pattern_o = 6'b000_110;
    S000_111: pattern_o = 6'b000_111;
    S001_000: pattern_o = 6'b001_000;
    S011_000: pattern_o = 6'b011_000;
    S111_000: pattern_o = 6'b111_000;
    S111_111: pattern_o = 6'b111_111;
    S111_100: pattern_o = 6'b111_100;
    S111_110: pattern_o = 6'b111_110;
    S001_111: pattern_o = 6'b001_111;
    S011_111: pattern_o = 6'b011_111;
    
    default:  pattern_o = 6'b000_000;
  endcase
end


always_comb begin
  state_d = S000_000;
  
  //0000 - idle
  if (!left_i && !right_i && !brake_i && !hazard_i) begin 
    state_d = S000_000;
  end

  //0001 - Hazard
  else if (!left_i && !right_i && !brake_i && hazard_i) begin
    case (state_q)
      S111_111: state_d = S000_000;
      default: state_d = S111_111;
    endcase
  end
  
  //0010 - Brake
  else if (!left_i && !right_i && brake_i && !hazard_i) begin
    state_d = S111_111;
  end
  
  //0011 - Brake
  else if (!left_i && !right_i && brake_i && hazard_i) begin
    state_d = S111_111;
  end
  
  //0100 - Right
  else if (!left_i && right_i && !brake_i && !hazard_i) begin
    case (state_q)
      S000_000: state_d = S000_100;
      S000_100: state_d = S000_110;
      S000_110: state_d = S000_111;
      default: state_d = S000_000;
    endcase
  end
  
  //0101 - Hazard
  else if (!left_i && right_i && !brake_i && hazard_i) begin
    case (state_q)
      S111_111: state_d = S000_000;
      default: state_d = S111_111;
    endcase
  end
  
  //0110 - Right Brake 
  else if (!left_i && right_i && brake_i && !hazard_i) begin
    case (state_q)
      S111_000: state_d = S111_100;
      S111_100: state_d = S111_110;
      S111_110: state_d = S111_111;
      default: state_d = S111_000;
    endcase
  end
  
  //0111 - Hazard
  else if (!left_i && right_i && brake_i && hazard_i) begin
    case (state_q)
      S111_111: state_d = S000_000;
      default: state_d = S111_111;
    endcase
  end

  //1000 - Left 
  else if (left_i && !right_i && !brake_i && !hazard_i) begin
    case (state_q)
      S000_000: state_d = S001_000;
      S001_000: state_d = S011_000;
      S011_000: state_d = S111_000;
      S111_000: state_d = S000_000;
    endcase
  end

  //1001 - Hazard 
  else if (left_i && !right_i && !brake_i && hazard_i) begin
    case (state_q)
      S111_111: state_d = S000_000;
      default: state_d = S111_111;
    endcase
  end
  
  //1010 - Left Brake
  else if (left_i && !right_i && brake_i && !hazard_i) begin
    case (state_q)
      S000_111: state_d = S001_111;
      S001_111: state_d = S011_111;
      S011_111: state_d = S111_111;
      default: state_d = S000_111;
    endcase
  end
  
  //1011 - Brake
  else if (left_i && !right_i && brake_i && hazard_i) begin
    state_d = S111_111;
  end
  
  //1100 - Hazard 
  else if (left_i && right_i && !brake_i && !hazard_i) begin
    case (state_q)
      S111_111: state_d = S000_000;
      default: state_d = S111_111;
    endcase
  end

  //1101 - Hazard  
  else if (left_i && right_i && !brake_i && hazard_i) begin
    case (state_q)
      S111_111: state_d = S000_000;
      default: state_d = S111_111;
    endcase
  end
  
  //1110 - Brake
  else if (left_i && right_i && brake_i && !hazard_i) begin
    state_d = S111_111;
  end
  
  //1111 - Brake
  else if (left_i && right_i && brake_i && hazard_i) begin
    state_d = S111_111;
  end
  
end


always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    state_q <= S000_000;
  end else begin
    state_q <= state_d;
  end
end

endmodule
