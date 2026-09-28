`timescale 1ns/1ps

module TB;

    // Fios para enviar estímulos físicos para a ULA
    logic [7:0] A;
    logic [7:0] B;
    logic [2:0] Sel;
    
    logic [7:0] result;
    
    // Variáveis do Testbench para a auto-verificação (Self-Checking)
    logic [7:0] expected; // O "gabarito" da conta
    int errors = 0;       // Contador de falhas
    int tests = 0;        // Contador de testes


    // Instância do DUT (Design Under Test) / Módulo de hardware que vai ser testado dentro do ambiente de simulação
    ULA dut (
        .A(A),
        .B(B),
        .Sel(Sel),
        .result(result)
    );

    initial begin // Roda automaticamente ao ligar o simulador
      $display("Iniciando testes na ULA"); // Mostra na tela

        // Faz 8 operações (Sel de 0 a 7)       2 na 3
        for (int op = 0; op < 8; op++) begin 
            
            // Faz a entrada A de 0 até 255     2 na 8
            for (int i = 0; i < 256; i++) begin 
                
                // Faz a entrada B de 0 até 255   2 na 8 
                for (int j = 0; j < 256; j++) begin 
                    
                // Executa os estímulos
                Sel = op[2:0];
                A   = i[7:0];
                B   = j[7:0];

                    // Calcula o "gabarito" no software (Comportamental)
                    case(Sel)
                        3'b000: expected = A + B; // SUM
                        3'b001: expected = A - B; // SUB
                        3'b011: expected = -A;    // COM 
                        3'b010: expected = A * B; // MUL 
                        3'b100: expected = A & B; // AND
                        3'b101: expected = A | B; // OR
                        3'b110: expected = ~A;    // NOT
                        3'b111: expected = A ^ B; // XOR
                    endcase
                    
                    #1;      // Aguarda a propagação dos sinais combinacionais do circuito real
                    
                    tests++; // Registra que mais um teste foi feito

                    // 4. Verificação automática (Self-Checking)
                    if (result !== expected) begin
                        $error("FALHA (Sel=%b): A=%d, B=%d | Obtido=%d, Esperado=%d", Sel, A, B, result, expected);
                        errors++; 
                    end

                end
            end
        end


// Relatório Final na tela
        $display("========================================");
        $display("Simulacao Concluida");
        $display("Total de testes realizados: %0d", tests);  // Imprime a variável de testes
        $display("Total de erros encontrados: %0d", errors); // Imprime a variável de erros
        
        if (errors == 0) begin
            $display("RESULTADO: O circuito nao apresentou falhas");
        end 
        else begin
            $display("RESULTADO: O circuito falhou em alguns testes.");
        end
            $display("========================================");
        
            $finish;
    end
endmodule        
