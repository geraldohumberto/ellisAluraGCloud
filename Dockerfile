# Use uma imagem oficial do Python como imagem base. A versão alpine é leve.
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
COPY requirements.txt .

# Instala as dependências do projeto
# --no-cache-dir: Desabilita o cache para manter a imagem menor
# --upgrade pip: Garante que estamos usando a versão mais recente do pip
RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt

# Copia o restante do código da sua aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para que o mundo externo possa acessar o contêiner
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner for iniciado
# --host 0.0.0.0 é necessário para tornar a aplicação acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
