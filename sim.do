# Cria a pasta de trabalho virtual
vlib work

# Compila todos os arquivos de hardware e o testbench ativando a cobertura (linhas, condições e variações de bit)
vlog -cover bcst half_adder.sv full_adder.sv somador_8bits.sv multiplicador_8bits.sv ULA.sv TB.sv

# Carrega o testbench no simulador com a ferramenta de cobertura ligada
vsim -coverage work.TB

# Executa todos os 524.288 testes (o simulador vai parar sozinho quando ler o $finish)
run -all

# Imprime o relatório detalhado de cobertura na tela
coverage report -detail
