`timescale 1ms/1ms

module ucsbece152a_taillights_tb();

  // Testbench signals
  logic clk;
  logic rst_n;
  logic clk_dimmer_i;
  logic left_i;
  logic right_i;
  logic hazard_i;
  logic brake_i;
  logic runlights_i;
  
  logic [5:0] lights_o;

  ucsbece152a_taillights dut (
    .clk(clk),
    .rst_n(rst_n),
    .clk_dimmer_i(clk_dimmer_i),
    .left_i(left_i),
    .right_i(right_i),
    .hazard_i(hazard_i),
    .brake_i(brake_i),
    .runlights_i(runlights_i),
    .lights_o(lights_o)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #500 clk = ~clk; // 1000ms period (1Hz)
  end

  // Dimmer clock generation
  initial begin
    clk_dimmer_i = 0;
    forever #5 clk_dimmer_i = ~clk_dimmer_i; // 10ms period (100Hz)
  end

  // Test sequence
  initial begin
    rst_n = 1;
    left_i = 0;
    right_i = 0;
    hazard_i = 0;
    brake_i = 0;
    runlights_i = 0;
    
    // Test left turn signal
    $display("Testing left turn signal...");
    left_i = 1;
    #4000; // 4 seconds
    left_i = 0;
    #500; // 0.5 seconds
    
    // Test right turn signal
    $display("Testing right turn signal...");
    right_i = 1;
    #4000; // 1 second
    right_i = 0;
    #500; // 0.5 seconds
    
    // Test brake signal
    $display("Testing brake signal...");
    brake_i = 1;
    #2000; // 1 second
    brake_i = 0;
    #500; // 0.5 seconds
    
    // Test hazard signal
    $display("Testing hazard signal...");
    hazard_i = 1;
    #4000; 
    hazard_i = 0;
    #500; 
    
    // Test left break signal
    $display("Testing left break signal...");
    left_i = 1;
    brake_i = 1;
    #6000; 
    left_i = 0;
    brake_i = 0;
    #500; 
    
    // Test right break signal
    $display("Testing right break signal...");
    right_i = 1;
    brake_i = 1;
    #6000; 
    right_i = 0;
    brake_i = 0;
    #500; 
    
    // Test running lights
    $display("Testing running lights with left on...");
    runlights_i = 1;
    left_i = 1;
    #4000; 
    runlights_i = 0;
    left_i = 0;
    #500; 
    

    $stop;
  end

  // Monitor output
  initial begin
    $monitor("Time: %0t | left_i: %b, right_i: %b, hazard_i: %b, brake_i: %b, runlights_i: %b | lights_o: %b",
             $time, left_i, right_i, hazard_i, brake_i, runlights_i, lights_o);
  end

endmodule
