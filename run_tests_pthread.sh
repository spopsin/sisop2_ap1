#!/bin/bash

total_time=0
min_time=999999999
max_time=0
runs=100

for i in $(seq 1 $runs)
do
    echo "Execução $i:"
    start=$(date +%s%N)
    ./programa_pthread 30000000 > /dev/null
    end=$(date +%s%N)

    duration_ns=$((end - start))
    duration_sec=$(echo "scale=3; $duration_ns / 1000000000" | bc)
    echo "Tempo: ${duration_sec} s"

    total_time=$((total_time + duration_ns))
    if [ $duration_ns -lt $min_time ]; then
        min_time=$duration_ns
    fi
    if [ $duration_ns -gt $max_time ]; then
        max_time=$duration_ns
    fi
done

media_ns=$((total_time / runs))
media_sec=$(echo "scale=3; $media_ns / 1000000000" | bc)
min_sec=$(echo "scale=3; $min_time / 1000000000" | bc)
max_sec=$(echo "scale=3; $max_time / 1000000000" | bc)

echo "Resumo após $runs execuções:"
echo "Tempo médio: $media_sec s"
echo "Tempo mínimo: $min_sec s"
echo "Tempo máximo: $max_sec s"
