# Desafio Dev - API para Gerenciamento de Transações de Lojas

## Sobre o Projeto

Este projeto é um sistema para processar arquivos CNAB, armazenar registros financeiros e fornecer uma API para consulta de lojas e suas transações.

## Tecnologias Utilizadas

- **Ruby on Rails** (versão 8.0.1)
- **PostgreSQL** (Banco de Dados)
- **Redis** (Cache e fila de processamento)
- **Sidekiq** (Processamento assíncrono)
- **RSpec** (Testes automatizados)
- **Swagger (RSwag)** (Documentação da API)
- **Docker & Docker Compose** (Ambiente de desenvolvimento)
- **TailwindCSS** (Estilização de páginas)

---

## Como Rodar o Projeto Localmente com Docker

### 1️) **Instalar Dependências**

Certifique-se de ter o **Docker** e o **Docker Compose** instalados.

### 2️) **Subir os Containers**

Execute o seguinte comando na raiz do projeto:

```sh
docker-compose up --build
```

### 3️) **Criar e Migrar o Banco de Dados**

Abra um novo terminal e execute dentro do contêiner **web**:

```sh
docker-compose exec web bin/rails db:setup
```

Isso irá criar e migrar o banco de dados automaticamente.

### 4️) **Acessar a API**

A API estará disponível em:

- [http://localhost:3000](http://localhost:3000)

O Sidekiq estará disponível em:

- [http://localhost:3000/sidekiq](http://localhost:3000/sidekiq)

---

## Documentação da API

A documentação da API está disponível via **Swagger**:

**Acesse:** [http://localhost:3000/api-docs](http://localhost:3000/api-docs)

---

## Endpoints Principais

### **Lojas** (`/api/stores`)

- `GET /api/stores` → Retorna a lista de lojas cadastradas
- `GET /api/stores/:id` → Retorna detalhes de uma loja específica

### **Registros Financeiros** (`/api/financial_records`)

- `GET /api/financial_records/:id` → Retorna detalhes de uma transação específica

### **Sidekiq Dashboard** (`/sidekiq`)

- Permite visualizar e gerenciar tarefas assíncronas

---

## ✅ Coverage de Testes

Os testes foram escritos utilizando **RSpec**. Para verificar a cobertura de testes, rode:

```sh
docker-compose exec web bundle exec rspec
```

Para visualizar o relatório de cobertura de testes no navegador:

```sh
open coverage/index.html
```
ou
```sh
xdg-open coverage/index.html
```

---

## Considerações Finais

Este projeto foi desenvolvido com foco em **eficiência e escalabilidade**, utilizando **Sidekiq** para processamento assíncrono.

