module regfile(input logic clk,
               input logic write_enable,
               input logic [4:0] ra1, ra2, wa3,
               input logic [31:0] wd3,
               output logic [31:0] rd1, rd2);

logic [31:0]    RF[31:0];
//This part assigns the read registers to whatever is in the registers at
//the location specified

always_comb
  begin
    if(ra1 == 5'b0) begin
      assign rd1=0;
    end else begin
      assign rd1 = RF[ra1];
    end

    if(ra2 == 5'b0) begin
      assign rd2=0;
    end else begin
      assign rd2 = RF[ra2];
    end
  end

//This section clears all registers when the reset line is pulled high
always @(posedge clk) begin
  if(write_enable) RF[wa3] <= wd3;
end

endmodule
  // three ported register file
  // read two ports combinatorially
  // write third port on rising edge of clock
  // register 0 hardwired to 0
