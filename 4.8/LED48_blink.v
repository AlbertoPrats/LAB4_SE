module LED_blink (
    input wire CLK,
    output wire LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7
);

    reg [27:0] data = 0;
    reg add_mode = 1'b1; // modo suma/resta
    reg [2:0] prev_led = 3'b0; // Variable para rastrear el LED encendido anteriormente

    // Asignación: bits 20 a 27 de data se asignan a las salidas LED
    assign LED0 = data[0];
    assign LED1 = data[1];
    assign LED2 = data[2];
    assign LED3 = data[3];
    assign LED4 = data[4];
    assign LED5 = data[5];
    assign LED6 = data[6];
    assign LED7 = data[7];

    always @(posedge CLK) begin
        if (add_mode == 1'b1) begin
            data <= data << 1; // Desplazar el patrón de barrido hacia la izquierda
            case (prev_led)
                3'b000: data[0] <= 1'b1; // Encender el LED 0
                3'b001: data[1] <= 1'b1; // Encender el LED 1
                3'b010: data[2] <= 1'b1; // Encender el LED 2
                3'b011: data[3] <= 1'b1; // Encender el LED 3
                3'b100: data[4] <= 1'b1; // Encender el LED 4
                3'b101: data[5] <= 1'b1; // Encender el LED 5
                3'b110: data[6] <= 1'b1; // Encender el LED 6
                3'b111: data[7] <= 1'b1; // Encender el LED 7
            endcase
            if (prev_led == 3'b111) // si ha llegado al final, cambia al modo de resta
                add_mode <= 1'b0;
            else
                prev_led <= prev_led + 1; // Cambiar al siguiente LED

        end else if (add_mode == 1'b0) begin
            data <= data >> 1; // Desplazar el patrón de barrido hacia la derecha
            case (prev_led)
                3'b000: data[0] <= 1'b1; // Encender el LED 0
                3'b001: data[1] <= 1'b1; // Encender el LED 1
                3'b010: data[2] <= 1'b1; // Encender el LED 2
                3'b011: data[3] <= 1'b1; // Encender el LED 3
                3'b100: data[4] <= 1'b1; // Encender el LED 4
                3'b101: data[5] <= 1'b1; // Encender el LED 5
                3'b110: data[6] <= 1'b1; // Encender el LED 6
                3'b111: data[7] <= 1'b1; // Encender el LED 7
            endcase
            if (prev_led == 3'b000) // si ha llegado al inicio, cambia al modo de suma
                add_mode <= 1'b1;
            else
                prev_led <= prev_led - 1; // Cambiar al anterior LED
        
        end
    end
endmodule


