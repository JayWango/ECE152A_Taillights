/*
* Copyright (c) 2023, University of California; Santa Barbara
* Distribution prohibited. All rights reserved.
*
* File: ucsbece152a_taillights.sv
* Description: Starter code for taillights.
*/
module ucsbece152a_taillights (
  input logic clk,
  input logic rst_n,
  input logic clk_dimmer_i,
  
  input logic left_i,
  input logic right_i,
  input logic hazard_i,
  input logic brake_i,
  input logic runlights_i,
  
  output logic [5:0] lights_o
);

logic [5:0] fsm_pattern;

ucsbece152a_fsm fsm (
  .clk(clk),
  .rst_n(rst_n),
  .left_i(left_i),
  .right_i(right_i),
  .hazard_i(hazard_i),
  .brake_i(brake_i),
  .state_o(/* unused */ ),
  .pattern_o(fsm_pattern)
);

assign lights_o = (runlights_i && clk_dimmer_i) ? (6'b111111) : (fsm_pattern);

endmodule