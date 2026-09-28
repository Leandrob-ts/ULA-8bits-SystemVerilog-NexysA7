module multiplicador_8bits (
input  logic [7:0] A,
input  logic [7:0] B,
output logic [7:0] MUL_RESULT
);

// Fios para guardar as 8 linhas (Produtos Parciais)
logic [7:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7;
logic [7:0] soma1, soma2, soma3, soma4, soma5, soma6;

// GERANDO OS PRODUTOS PARCIAIS (multiplicação por cada bit)
//adicionado zeros à direita para fazer o "deslocamento" da conta
assign pp0 = B[0] ? A                             : 8'd0;
assign pp1 = B[1] ? {A[6:0], 1'b0}                : 8'd0; // Desloca 1
assign pp2 = B[2] ? {A[5:0], 2'b00}               : 8'd0; // Desloca 2
assign pp3 = B[3] ? {A[4:0], 3'b000}              : 8'd0; // Desloca 3
assign pp4 = B[4] ? {A[3:0], 4'b0000}             : 8'd0; // Desloca 4
assign pp5 = B[5] ? {A[2:0], 5'b00000}            : 8'd0; // Desloca 5
assign pp6 = B[6] ? {A[1:0], 6'b000000}           : 8'd0; // Desloca 6
assign pp7 = B[7] ? {A[0],   7'b0000000}          : 8'd0; // Desloca 7

// SOMANDO TUDO
// 7 somadores em cascata para somar as 8 linhas.
// Cout vazio porque não precisamos do carry final no multiplicador de 8 bits
    
somador_8bits S1 (.A(pp0),   .B(pp1), .Cin(1'b0), .SUM(soma1), .Cout());
somador_8bits S2 (.A(soma1), .B(pp2), .Cin(1'b0), .SUM(soma2), .Cout());
somador_8bits S3 (.A(soma2), .B(pp3), .Cin(1'b0), .SUM(soma3), .Cout());
somador_8bits S4 (.A(soma3), .B(pp4), .Cin(1'b0), .SUM(soma4), .Cout());
somador_8bits S5 (.A(soma4), .B(pp5), .Cin(1'b0), .SUM(soma5), .Cout());
somador_8bits S6 (.A(soma5), .B(pp6), .Cin(1'b0), .SUM(soma6), .Cout());
somador_8bits S7 (.A(soma6), .B(pp7), .Cin(1'b0), .SUM(MUL_RESULT), .Cout()); // Entrega o resultado direto na saída do multiplicador

endmodule