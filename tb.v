`timescale 1ns / 1ps

module tb_project;

    // Dilwsi simatwn Testbench (8-bit eisodoi, 16-bit eksodos)
    reg [7:0] x_tb;
    reg [7:0] y_tb;
    reg clk_tb;
    reg rst_tb;
    
    // Eksodos tou kyklwmatos
    wire [15:0] s_tb;

    // Diasyndesi me to Top-level Component (UUT)
    project uut (
        .x(x_tb),
        .y(y_tb),
        .clk(clk_tb),
        .rst(rst_tb),
        .s(s_tb)
    );

    // Dimiourgia rologiou (Pio argo roloi: Periodos T = 100ns)
    initial begin
        clk_tb = 1'b0;
    end
    always #50 clk_tb = ~clk_tb;

    // Senaria dokimis (Stimulus)
    initial begin
    

        // 1. Katastasi RESET
        // Ksekinaei sta 0ns. To roloi einai LOW.
        rst_tb = 1'b1;
        x_tb = 8'd0;
        y_tb = 8'd0;
        
        // Perimenoume 125ns. Ekeinh th stigmh to roloi einai LOW (0), 
        // opote apofeygoume ta setup violations.
        #125; 
        rst_tb = 1'b0; 

        // 2. DOKIMI 1: Pollaplasiasmos thetikwn arithmwn
        // Pame sta 225ns (to roloi einai pali LOW). Allazoume ta dedomena me asfaleia!
        #100; 
        x_tb = 8'd12;
        y_tb = 8'd10;
        
        // Perimenoume 2 plireis kyklous rologiou (200ns) gia na ginei i praksi
        #200; 

        // 3. DOKIMI 2: Pollaplasiasmos me to miden
        x_tb = 8'd255;
        y_tb = 8'd0;
        #200;

        // 4. DOKIMI 3: Pollaplasiasmos oriakwn timwn (Max unsigned values)
        x_tb = 8'd255;
        y_tb = 8'd255;
        #200;

        // 5. DOKIMI 4: Tyxaies times
        x_tb = 8'd15;
        y_tb = 8'd15;
        #200;

        // 6. DOKIMI 5: Elegxos me arnitikous arithmous (Booth signed)
        x_tb = 8'hFF; 
        y_tb = 8'd5;
        #200;

        $display("Booth Multiplier Simulation Finished.");
        $stop;
    end

endmodule