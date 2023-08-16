#!/bin/bash

# Criar um array para armazenar os nomes das pessoas
declare -a pessoas

# Listar todos os documentos na pasta atual e adicionar nomes das pessoas ao array
for arquivo in *; do
    if [ -f "$arquivo" ]; then
        pessoa=$(echo "$arquivo" | cut -d'-' -f1 | sed 's/^[ \t]*//;s/[ \t]*$//')
        pessoas+=("$pessoa")
    fi
done

# Remover duplicatas dos nomes das pessoas
pessoas=($(printf "%s\n" "${pessoas[@]}" | sort -u))

# Criar pastas com os nomes das pessoas
for pessoa in "${pessoas[@]}"; do
    mkdir -p "$pessoa"
done

# Mover arquivos para suas respectivas pastas
for arquivo in *; do
    if [ -f "$arquivo" ]; then
        pessoa=$(echo "$arquivo" | cut -d'-' -f1 | sed 's/^[ \t]*//;s/[ \t]*$//')
        mv "$arquivo" "$pessoa"
    fi
done

# Imprimir os nomes das pessoas armazenados no array
echo "Arquivos movidos para suas respectivas pastas:"
for pessoa in "${pessoas[@]}"; do
    echo "$pessoa"
done
