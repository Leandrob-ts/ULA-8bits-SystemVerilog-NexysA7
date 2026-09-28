module full_adder(

input logic A, 
input logic B,
input logic Cin, 

output logic SUM,
output logic Cout

);

// "fios" internos para conectar os blocos
logic fio_soma_ha1;
logic fio_cout_ha1;
logic fio_cout_ha2;

// instancindo o PRIMEIRO Half Adder (Soma a com b)
    half_adder HA1 (
        .a(A), // .a (minúsculo do half_adder) recebe o A (maiúsculo do full_adder)
        .b(B),
        .sum(fio_soma_ha1),
        .cout(fio_cout_ha1)
    );

    half_adder HA2 (
        .a(fio_soma_ha1),
        .b(Cin),
        .sum(SUM), // A soma final sai do sum minúsculo e vai para o SUM maiúsculo
        .cout(fio_cout_ha2)
    );

assign Cout = fio_cout_ha1 | fio_cout_ha2;  // Junta os dois carries parciais

endmodule