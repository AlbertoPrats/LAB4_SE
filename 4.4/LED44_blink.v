
module DebouncedButton (
    input wire CLK,
    input wire SW2,
    output wire btn_pressed
);
    reg [3:0] debounce_count = 4'b1000;  // Contador para el debounce
    reg pressed = 1'b0;
    reg btn_last = 1'b0;  // Almacena el estado anterior del botón

    assign btn_pressed = pressed;  // Señal de botón pulsado

    always @(posedge CLK) begin
        if(SW2)
            if (debounce_count > 0)
                debounce_count <= debounce_count - 1;
            else if (debounce_count == 0) begin // Han pasado 10 ms desde el flanco de subida del botón
                if(btn_last == 1'b0) begin
                    pressed <= 1'b1;
                    btn_last <= 1'b1;
                end else if(btn_last == 1'b1)
                    pressed <= 1'b0;
            end
        else begin
            pressed <= 1'b0;
            debounce_count <= 4'b1000;
            btn_last <= 1'b0;
        end       
    end
endmodule



module LED_blink (
    input wire CLK,
    input wire SW2,
    output wire LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7
);
    wire btn_pressed;
    reg [27:0] data = 0;

    // Instancia del módulo DebouncedButton
    DebouncedButton btn_debouncer (
        .CLK(CLK),
        .SW2(SW2),
        .btn_pressed(btn_pressed)
    );

    // Asignación: bits 20 a 27 de data se asignan a las salidas LED
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
            if (btn_pressed)  // Si el botón se ha pulsado, reiniciar el contador
                data <= 0;
            else    // De lo contrario, incrementa el contador normalmente
                data <= data + 1;
        end
endmodule
