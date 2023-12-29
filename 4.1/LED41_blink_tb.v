`timescale 1ns/100ps

module testbench ();
    reg clk = 0;
    reg button = 0;
    wire led0, led1, led2, led3, led4, led5, led6, led7;

    // Generamos reloj
    // Periodo = 5 * timescale = 5 * 1ns
    localparam CLOCK_PERIOD = 5;

    // Inicialmente está a 0
    initial clk = 1'b0;

    // Cambio valor de clk cada 5ns
    always #CLOCK_PERIOD clk = ~clk;

    // INICIALIZO BOTON
    initial begin
        button = 0;
        #500;    // 5ms
        button = 1;
        #500;    // 5ms
        button = 0;

    end

    reg errores = 0;

    // Instancia del módulo LED_blink
    LED_blink DUT (
        .CLK(clk),
        .SW2(button),  
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
        $dumpfile(`DUMPSTR("LED41_blink_tb.vcd"));
        $dumpvars(0, testbench);
        #1;
        if (!(led0 === 0 && led1 === 0 && led2 === 0 && led3 === 0 && led4 === 0 && led5 === 0 && led6 === 0 && led7 === 0))
        begin
            $display("Error: LEDs no están en 0 al inicio");
            errores = errores + 1;
        end
        // Comprobación después de pulsar el boton
        #505;
        // Comprobar si los LEDs son los esperados después del reset
        if (!(led0 === 0 && led1 === 0 && led2 === 0 && led3 === 0 && led4 === 0 && led5 === 0 && led6 === 0 && led7 === 0))
        begin
            $display("Error: Configuración de LEDs incorrecta después del reset");
            errores = errores + 1;
        end
        #500;
        // Comprobar si los LEDs son los esperados después de soltar el boton
        if (!(led0 === 1 && led1 === 0 && led2 === 0 && led3 === 0 && led4 === 0 && led5 === 0 && led6 === 0 && led7 === 0))
        begin
            $display("Error: Configuración de LEDs incorrecta después de soltar el boton");
            errores = errores + 1;
        end

        if (errores === 0)
            $display("\nTestbench completado sin errores\n");
        else
            $display("\nTestbench completado con %d errores\n", errores);
        #500;

        $finish;
    end
endmodule
