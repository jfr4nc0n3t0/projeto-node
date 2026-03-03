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
else
  echo "=== Nenhuma mudança detectada no diff ==="
fi
