#!/bin/bash

#chmod +x test.sh
#./teste.sh

# Substitua pelo caminho para o arquivo CSV
arquivo_csv="nomes.csv"

# Percorre todos os arquivos na pasta atual
for filename in *; do
    # Verifica se o nome do arquivo corresponde ao padrão "id_cpf_ecc"
    if [[ $filename =~ ^[0-9]+_([0-9]+\.[0-9]+\.[0-9]+-[0-9]+)_ecc\.(pdf|pptx)$ ]]; then
        # Extrai o CPF do nome do arquivo
        cpf="${BASH_REMATCH[1]}"
        
        # Use o grep para encontrar a linha correspondente ao CPF no arquivo CSV
        linha=$(grep "$cpf" "$arquivo_csv")

        # Verifique se a linha foi encontrada
        if [ -n "$linha" ]; then
            nome=$(echo "$linha" | cut -d ';' -f 1)
            echo "Nome correspondente para CPF $cpf: $nome"
            
            # Renomeia o arquivo com o nome encontrado
            novo_nome="${nome// / }"
            novo_nome="${novo_nome//;/,}"
            mv "$filename" "$novo_nome.${BASH_REMATCH[2]}"
            echo "Arquivo renomeado para $novo_nome.${BASH_REMATCH[2]}"
        else
            echo "Nome não encontrado para CPF $cpf. Não é possível renomear o arquivo."
        fi
    fi
done
