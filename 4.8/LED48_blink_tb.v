`timescale 1ns/100ps

module testbench ();
    reg clk = 0;
    wire led0, led1, led2, led3, led4, led5, led6, led7;

    // Generamos reloj
    // Periodo = 5 * timescale = 5 * 1ns
    localparam CLOCK_PERIOD = 5;

    // Inicialmente está a 0
    initial clk = 1'b0;

    // Cambio valor de clk cada 5ns
    always #CLOCK_PERIOD clk = ~clk;


    // Instancia del módulo LED_blink
    LED_blink DUT (
        .CLK(clk),
        .LED0(led0),
        .LED1(led1),
        .LED2(led2),
        .LED3(led3),
        .LED4(led4),
        .LED5(led5),
        .LED6(led6),
        .LED7(led7)
    );

    // Verificar el comportamiento esperado
    initial begin
        $dumpfile(`DUMPSTR("LED48_blink_tb.vcd"));
        $dumpvars(0, testbench);
        #5000;

        $finish;
    end
endmodule