#!/bin/bash

EXECUTABLE="./programa"
LIB_PATH="."
NUM_RUNS=100

# Verifica se o programa existe
if [ ! -f "$EXECUTABLE" ]; then
    echo "Erro: programa não encontrado."
    exit 1
fi

# Exporta o caminho da biblioteca
export LD_LIBRARY_PATH=$LIB_PATH

total_time=0
min_time=999999
max_time=0

echo "Executando $NUM_RUNS vezes..."

for i in $(seq 1 $NUM_RUNS); do
    # Captura o tempo real de execução em segundos com precisão de milissegundos
    output=$( { /usr/bin/time -f "%e" $EXECUTABLE > /dev/null; } 2>&1 )

    # Converte para float
    time=$(echo "$output" | tr ',' '.')

    # Soma tempo total
    total_time=$(echo "$total_time + $time" | bc)

    # Atualiza mínimo
    comp=$(echo "$time < $min_time" | bc)
    if [ "$comp" -eq 1 ]; then
        min_time=$time
    fi

    # Atualiza máximo
    comp=$(echo "$time > $max_time" | bc)
    if [ "$comp" -eq 1 ]; then
        max_time=$time
    fi

    echo "Execução $i: $time segundos"
done

# Calcula média
average=$(echo "scale=3; $total_time / $NUM_RUNS" | bc)

echo ""
echo "Resumo após $NUM_RUNS execuções:"
echo "Tempo médio: $average segundos"
echo "Tempo mínimo: $min_time segundos"
echo "Tempo máximo: $max_time segundos"
