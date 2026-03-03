#!/usr/bin/env bash
set -euo pipefail

PROMPT="${1:-Analise o repositório e gere um resumo dos arquivos presentes, descrevendo o propósito de cada um.}"
PATCH_FILE="/tmp/copilot-changes.patch"

echo "=== Executando Copilot CLI ==="
echo "Prompt: $PROMPT"
echo ""

copilot --allow-all -p "$PROMPT"

echo ""
echo "=== Gerando diff das mudanças ==="
git diff > "$PATCH_FILE"

if [ -s "$PATCH_FILE" ]; then
  echo "=== Aplicando diff via git apply ==="
  git apply --allow-empty "$PATCH_FILE"
  echo "=== Diff aplicado com sucesso ==="
  echo ""
  echo "--- Resumo das mudanças ---"
  git diff --stat HEAD
  
  echo ""
  echo "=== Criando branch e commit ==="
  BRANCH_NAME="copilot-changes-$(date +%s)"
  git checkout -b "$BRANCH_NAME"
  git add -A
  git commit -m "chore: aplicar mudanças sugeridas pelo Copilot

Prompt utilizado: $PROMPT"
  
  echo "=== Fazendo push da branch ==="
  git push -u origin "$BRANCH_NAME"
  
  echo "=== Criando Pull Request em modo draft ==="
  gh pr create \
    --draft \
    --title "🤖 Mudanças sugeridas pelo Copilot" \
    --body "**Prompt utilizado:**
\`\`\`
$PROMPT
\`\`\`

**Resumo das mudanças:**
$(git diff --stat HEAD~1)

---
_Este PR foi criado automaticamente pelo script copilot-apply.sh_" \
    --head "$BRANCH_NAME"
  
  echo "=== PR criado com sucesso! ==="
else
  echo "=== Nenhuma mudança detectada no diff ==="
fi