module stimulus();
  logic clk;
  logic write_enable;
  logic [4:0]  ra1, ra2, wa3;

  logic [31:0] wd3;
  logic [31:0] rd1, rd2;

  integer handle3;
  integer desc3;

  // Instantiate DUT
  regfile dut(.clk(clk),
	        .write_enable(write_enable),
          .ra1(ra1),
          .ra2(ra2),
          .wa3(wa3),
          .rd1(rd1),
          .rd2(rd2),
          .wd3(wd3));

  // Setup the clock to toggle every 1 time units
  initial
    begin
      clk = 1'b1;
      //#5 means 1 time unit is 5ns
      forever #5 clk = ~clk;
    end

    initial
      begin
        // Gives output file name
        handle3 = $fopen("test.out");
        // Tells when to finish simulation
        #500 $finish;
      end

      always
        begin
          desc3 = handle3;
          #5 $fdisplay(desc3, "%b || %b", ra1, rd1);
        end

      initial
        begin
          #0 write_enable = 1'b1;
          #0 ra1 = 5'b00000;
          #0 ra2 = 5'b00000;


          //write 1 to register 1 then read that same register
          #9 wa3 = 5'b00001;
          #0 wd3 = 32'b00001;
          #5 ra1 = 5'b00001;

          //write 7 to register 2 then read that same register
          #15 wa3 = 5'b00010;
          #0 wd3 = 32'b000111;
          #10 ra2 = 5'b00010;

          // write 6 to register 3 and read that same register
          #0 wa3 = 5'b00011;
          #0 wd3 = 32'b000110;
          #10 ra1 = 5'b00011;

        end
endmodule
