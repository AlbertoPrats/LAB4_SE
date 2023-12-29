module LED_blink (
    input wire CLK,
    input wire SW2,
    output wire LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7
);
    // Declaración de señales
    reg [27:0] data = 0;
    
    // Asignación: bit 24 de data se asigna a la salida LED
    assign LED0 = data[0];
    assign LED1 = data[1];
    assign LED2 = data[2];
    assign LED3 = data[3];
    assign LED4 = data[4];
    assign LED5 = data[5];
    assign LED6 = data[6];
    assign LED7 = data[7];
    
    // Contador: incrementa con cada flanco de subida del reloj
    always @(posedge CLK)
        begin
            if (SW2)  //Si SW2 está pulsado, reiniciar el contador
                data <= 0;
            else    // De lo contrario, incrementa el contador normalmente
                data <= data + 1;
        end
endmodule
