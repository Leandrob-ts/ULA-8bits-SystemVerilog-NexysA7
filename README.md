# Unidade Lógica e Aritmética (ULA) 8-bits - Nexys A7

Projeto prático da disciplina de Sistemas Digitais. O objetivo foi desenvolver uma ULA puramente combinacional de 8 bits utilizando **SystemVerilog**, validá-la com 100% de cobertura e prototipá-la fisicamente numa FPGA.

## Arquitetura e Reúso de Hardware
O diferencial deste projeto é o **design estrutural bottom-up**. Para minimizar o uso de LUTs (Look-Up Tables) e otimizar a síntese, os blocos maiores foram construídos instanciando componentes menores:
*   `half_adder.sv` e `full_adder.sv` formam a base do circuito.
*   `somador_8bits.sv` é reaproveitado para as operações de Soma, Subtração, Complemento e serve como bloco construtor do multiplicador.
*   `multiplicador_8bits.sv` desenvolvido de forma estrutural e puramente combinacional.

## Tabela de Operações (Seletor)
A ULA recebe dois operandos de 8 bits (`A` e `B`) e um seletor de 3 bits (`Sel`).

| Sel (Binário) | Botões na Nexys A7 | Operação Lógica/Aritmética |
| :---: | :--- | :--- |
| `000` | Nenhum | Soma (A + B) |
| `001` | Botão Central | Subtração (A - B) |
| `010` | Botão Superior | Multiplicação (A * B) |
| `011` | Botão Sup. + Central | Complemento (-A) |
| `100` | Botão Inferior | AND Lógico (A & B) |
| `101` | Botão Inf. + Central | OR Lógico (A \| B) |
| `110` | Botão Inf. + Superior| NOT Lógico (~A) |
| `111` | Todos os três | XOR Lógico (A ^ B) |

## Ferramentas e Simulação
*   **Design & Síntese:** AMD/Xilinx Vivado (Mapeamento via `Nexys-A7-100T-TP2.xdc`).
*   **Simulação:** Mentor/Siemens QuestaSim.

O testbench (`tb_ULA.sv`) foi construído com a abordagem **self-checking**. Ele testa automaticamente todas as 524.288 combinações possíveis das entradas A, B e Sel, comparando a saída do hardware com o resultado matemático esperado. 

**Para reproduzir a simulação:**
1. Abra o QuestaSim / ModelSim.
2. Navegue até o diretório do projeto.
3. Execute o script de automação no terminal (Transcript):
   ```tcl
   do sim.do
