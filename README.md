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

## Síntese e Utilização de Recursos (Vivado)
O circuito provou ser altamente otimizado na arquitetura estrutural. O mapeamento físico utilizou a seguinte interface:
*   **16 Switches (Chaves):** Entradas `A[7:0]` e `B[7:0]`.
*   **3 Push Buttons:** Seletor `Sel[2:0]`.
*   **8 LEDs:** Saída `result[7:0]`.

**Relatório de Utilização (Utilization Report):**
*   **Slice LUTs:** 70 (<1%)
*   **Bonded IOBs:** 27
*   **Flip-Flops / BRAMs:** 0 (Comprova a natureza puramente combinacional da ULA).

## Como Executar

### 1. Simulação (QuestaSim / ModelSim)
O testbench (`TB.sv`) utiliza a abordagem **self-checking**, testando automaticamente as 524.288 combinações possíveis.
1. Abra o QuestaSim e navegue até o diretório do projeto.
2. Execute o script no terminal (Transcript): `do sim.do`
*Nota: O projeto atingiu **100% de Statement Coverage**.*

### 2. Implementação na FPGA (Vivado)
1. Crie um novo projeto no **Vivado** selecionando a linguagem `SystemVerilog`.
2. Em *Add Sources*, adicione os 5 ficheiros de hardware (`.sv`). Não adicione o testbench.
3. Em *Add Constraints*, adicione o ficheiro `Nexys-A7-100T-TP2.xdc`.
4. Em *Default Part*, pesquise e selecione o chip **xc7a100tcsg324-1**.
5. No menu lateral, clique em **Run Synthesis** para compilar o projeto.
6. Clique em **Generate Bitstream** para criar o binário da placa.
7. Conecte a placa Nexys A7 ao computador por USB e ligue-a.
8. Clique em **Open Hardware Manager** > **Open Target** > **Auto Connect**.
9. Clique em **Program Device** para transferir a ULA para o hardware físico e teste nos botões.
