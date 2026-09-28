module somador_8bits(

input  logic [7:0] A,
input  logic [7:0] B,
input  logic       Cin,

output logic [7:0] SUM,
output logic       Cout

);

// Fios internos para passar o "vai um" (carry) de um bloco para o outro
logic c1, c2, c3, c4, c5, c6, c7;


// Instanciando 8 Full Adders em cascata (Ripple Carry Adder)
// Ligamos o bit específico de A e B, ex: A[0] e B[0]

full_adder FA0 (.A(A[0]), .B(B[0]), .Cin(Cin), .SUM(SUM[0]), .Cout(c1));
full_adder FA1 (.A(A[1]), .B(B[1]), .Cin(c1),  .SUM(SUM[1]), .Cout(c2));
full_adder FA2 (.A(A[2]), .B(B[2]), .Cin(c2),  .SUM(SUM[2]), .Cout(c3));
full_adder FA3 (.A(A[3]), .B(B[3]), .Cin(c3),  .SUM(SUM[3]), .Cout(c4));
full_adder FA4 (.A(A[4]), .B(B[4]), .Cin(c4),  .SUM(SUM[4]), .Cout(c5));
full_adder FA5 (.A(A[5]), .B(B[5]), .Cin(c5),  .SUM(SUM[5]), .Cout(c6));
full_adder FA6 (.A(A[6]), .B(B[6]), .Cin(c6),  .SUM(SUM[6]), .Cout(c7));
full_adder FA7 (.A(A[7]), .B(B[7]), .Cin(c7),  .SUM(SUM[7]), .Cout(Cout)); // O último bit joga o carry para a saída final (Cout) do módulo

endmodule