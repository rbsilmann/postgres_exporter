### Passo 1: Realizar as Alterações no Banco

1. **Utilize o arquivo `alteracoes-bd.sql`**:
   Conecte no banco de dados e utilize os passos em `sql/alteracoes-bd.sql`

### Passo 2: Criar o Arquivo `postgres_exporter.yml`

1. **Crie e execute o script `exporter.sh`**:
   Salve o seguinte script em um arquivo chamado `exporter.sh`:

   ```bash
   nano exporter.sh
   ```

   Copie e cole o conteúdo de `scripts/exporter.sh`

2. **Torne o script executável**:
   Execute o comando abaixo para tornar o script executável:

   ```bash
   chmod +x exporter.sh
   ```

3. **Executar o script para criar o arquivo `postgres_exporter.yml`**:
   Execute o script:

   ```bash
   ./exporter.sh
   ```

   Siga as instruções interativas para preencher as informações.

### Passo 3: Editar o `init-exporter.sh`

1. **Criar ou editar o arquivo `init-exporter.sh`**:
   Abra ou crie o arquivo `init-exporter.sh`:

   ```bash
   nano init-exporter.sh
   ```

   Crie o arquivo conforme o exemplo `scripts/init-exporter.sh`.

   Certifique-se de substituir `/caminho/para/o/binario/` e `/caminho/para/o/` pelos caminhos corretos no seu sistema.

2. **Tornar o script executável**:
   Torne o `init-exporter.sh` executável:

   ```bash
   chmod +x init-exporter.sh
   ```

### Passo 4: Criar o Serviço no Rocky Linux

1. **Criar o arquivo de serviço**:
   Crie um novo arquivo de serviço para o `postgres_exporter`. Por exemplo, `postgres_exporter.service`:

   ```bash
   sudo nano /etc/systemd/system/postgres_exporter.service
   ```

   Adicione o seguinte conteúdo ao arquivo:

   ```ini
   [Unit]
   Description=Postgres Exporter
   After=network.target

   [Service]
   Type=simple
   User=seu_usuario
   ExecStart=/caminho/para/o/init-exporter.sh
   Restart=on-failure

   [Install]
   WantedBy=multi-user.target
   ```

   Substitua `seu_usuario` pelo nome do usuário que deve executar o serviço.

2. **Recarregar o daemon do systemd**:
   Após criar o arquivo de serviço, você precisa recarregar o daemon do systemd para reconhecer o novo serviço:

   ```bash
   sudo systemctl daemon-reload
   ```

3. **Iniciar e habilitar o serviço**:
   Inicie o serviço e habilite-o para iniciar na inicialização do sistema:

   ```bash
   sudo systemctl start postgres_exporter
   sudo systemctl enable postgres_exporter
   ```

4. **Verificar o status do serviço**:
   Você pode verificar se o serviço está funcionando corretamente com o seguinte comando:

   ```bash
   sudo systemctl status postgres_exporter
   ```

### Passo 5: Subir o Ambiente Usando Docker Compose

1. **Certifique-se de ter o Docker instalado**:
   Primeiro, verifique se o Docker está em seu sistema. Você pode verificar com o seguinte comando:

   ```bash
   docker --version
   ```

   Se não estiverem instalados, você pode seguir a [documentação oficial do Docker](https://docs.docker.com/get-docker/) para instalar o Docker.

2. **Crie o arquivo `compose.yml`**:
   Se você ainda não criou o arquivo `compose.yml`, crie um novo arquivo e adicione a configuração que já discutimos:

   ```bash
   nano compose.yml
   ```

   Cole o conteúdo do `compose.yml`

3. **Criar o arquivo de configuração do Prometheus (`prometheus.yml`)**:
   Crie o arquivo `prometheus.yml` no mesmo diretório que o `compose.yml`:

   ```bash
   nano prometheus.yml
   ```

   Cole o conteúdo do `prometheus.yml`

4. **Subir todo o ambiente**:
   Após criar os arquivos necessários, você pode subir todo o ambiente com o seguinte comando:

   ```bash
   docker compose up -d
   ```

   O `-d` faz com que os containers sejam executados em segundo plano.

5. **Verificar se os containers estão em execução**:
   Você pode verificar se todos os containers foram iniciados corretamente com o comando:

   ```bash
   docker compose ps
   ```

6. **Acessar os serviços**:
   - **PostgreSQL**: O banco de dados estará acessível em `localhost:5432`.
   - **pgAdmin**: Acesse em `http://localhost:8500` (login: `admin@email.com`, senha: `postgres`).
   - **Prometheus**: Acesse em `http://localhost:9090`.
   - **Grafana**: Acesse em `http://localhost:3000` (login: `admin`, senha: `admin`).

### Conclusão

Agora você configurou tudo para usar o `postgres_exporter`. As etapas cobrem desde a configuração do banco de dados até a criação de um serviço no Rocky Linux.