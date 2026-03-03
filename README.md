# projeto-node

Repositório de estudo sobre o funcionamento do **GitHub Copilot CLI** integrado ao GitHub Actions.

## 📋 Sobre o Projeto

Este projeto tem como objetivo explorar e demonstrar como o GitHub Copilot CLI pode ser utilizado de forma automatizada dentro de pipelines de CI/CD, permitindo que tarefas de análise e modificação de código sejam executadas via prompts de linguagem natural.

## 🚀 Como Funciona

1. Um **workflow do GitHub Actions** é disparado manualmente (`workflow_dispatch`) com um prompt como parâmetro.
2. O **Copilot CLI** é instalado e executa o prompt no repositório.
3. As mudanças geradas são capturadas como um diff e aplicadas ao código.
4. Um **Pull Request em modo draft** é criado automaticamente com as alterações sugeridas.

## 📁 Estrutura do Projeto

```
projeto-node/
├── .github/
│   └── workflows/
│       └── copilot-cli.yml      # Workflow principal do GitHub Actions
├── scripts/
│   └── copilot-apply.sh         # Script que executa o Copilot CLI e cria o PR
└── README.md
```

## ⚙️ Pré-requisitos

- **Personal Access Token (PAT)** do GitHub configurado como secret `PERSONAL_ACCESS_TOKEN` no repositório, com permissões de `contents: write` e `pull-requests: write`.
- Acesso ao **GitHub Copilot**.

## ▶️ Como Usar

1. Acesse a aba **Actions** do repositório.
2. Selecione o workflow **"Copilot CLI - Estudo de Funcionamento"**.
3. Clique em **"Run workflow"** e preencha o campo `prompt` com a instrução desejada.
4. Aguarde a execução — um PR draft será criado com as mudanças sugeridas pelo Copilot.

### Exemplo de prompt

```
Analise o repositório e gere um resumo dos arquivos presentes, descrevendo o propósito de cada um.
```

## 🛠️ Tecnologias

- [GitHub Actions](https://docs.github.com/en/actions)
- [GitHub Copilot CLI](https://docs.github.com/en/copilot)
- Node.js 20
- Bash
