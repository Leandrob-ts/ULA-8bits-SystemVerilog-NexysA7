module ULA(
    input logic [7:0] A,
    input logic [7:0] B,
    input logic [2:0] Sel,
    
    output logic [7:0] result
);
    //"fios" que vão ligar a ULA ao nosso Somador
    logic [7:0] fio_A_somador;
    logic [7:0] fio_B_somador;
    logic       fio_Cin_somador;
    logic [7:0] fio_Soma_resultado; // Onde o somador vai entregar a resposta
    logic [7:0] fio_Mul_resultado;  // Onde o multiplicador vai entregar a resposta

// ETAPA 1: PREPARAR OS DADOS PARA O SOMADOR MUX DE ENTRADA
always_comb begin

    // Valores padrão por segurança
        fio_A_somador   = A;
        fio_B_somador   = B;
        fio_Cin_somador = 1'b0; 

    case(Sel)
     // SUM (A + B)
     3'b000: begin 
        fio_A_somador   = A;
        fio_B_somador   = B;
        fio_Cin_somador = 1'b0;
     end


    // SUB (A - B) -> É o mesmo que A + (~B) + 1
    3'b001: begin
        fio_A_somador   = A;
        fio_B_somador   = ~B;     // Inverte o B (Custa quase zero LUTs)
        fio_Cin_somador = 1'b1;   // Soma 1 no Cin (Complemento de 2)
     end

     
     //COM (-A) -> É o mesmo que (~A) + 0 + 1
     3'b011: begin
        fio_A_somador   = ~A;     // Inverte o A (Custa quase zero LUTs)
        fio_B_somador   =  8'b0;  // B vira zero
        fio_Cin_somador =  1'b1;  // Soma 1 no Cin (Complemento de 2)
     end
endcase
end


// ETAPA 2: INSTANCIAR O SOMADOR
somador_8bits SOMADOR1 (
        .A(fio_A_somador),
        .B(fio_B_somador),
        .Cin(fio_Cin_somador),
        .SUM(fio_Soma_resultado),
        .Cout() // vazio, a ULA de 8 bits costuma ignorar o overflow
);

// Instanciando o Multiplicador (trabalha em paralelo com o somador)
    multiplicador_8bits MULTIPLICADOR1 (
        .A(A),                              // Recebe o A original da ULA
        .B(B),                              // Recebe o B original da ULA
        .MUL_RESULT(fio_Mul_resultado)      // Joga a resposta no fio novo
    );


// ETAPA 3: ESCOLHER O RESULTADO FINAL (MUX DE SAÍDA)
always_comb begin


 result = 8'b00000000; 
 case(Sel)

  3'b000: result  = fio_Soma_resultado; // SUM
  3'b001: result  = fio_Soma_resultado; // SUB
  3'b010: result  = fio_Mul_resultado;  // MUL  
  3'b011: result  = fio_Soma_resultado; // COM 
  3'b100: result  = A & B;              // AND
  3'b101: result  = A | B;              // OR
  3'b110: result  = ~A;                 // NOT
  default: result = A ^ B;              // XOR

    endcase
end


endmodule