#!/bin/bash

# Solicitar informações ao usuário
read -p "Digite o nome do módulo (por exemplo, vr1): " MODULE_NAME
read -p "Digite o nome de usuário: " USERNAME
read -sp "Digite a senha: " PASSWORD
echo
read -p "Digite o modo SSL (default: disable): " SSL_MODE
SSL_MODE=${SSL_MODE:-disable}

CONFIG_FILE_PATH="./postgres_exporter.yml"

mkdir -p $(dirname $CONFIG_FILE_PATH)

cat <<EOF > $CONFIG_FILE_PATH
auth_modules:
  $MODULE_NAME:
    type: userpass
    userpass:
      username: $USERNAME
      password: $PASSWORD
    options:
      sslmode: $SSL_MODE
EOF

chmod 600 $CONFIG_FILE_PATH

echo "Arquivo de configuração criado em $CONFIG_FILE_PATH com sucesso!"