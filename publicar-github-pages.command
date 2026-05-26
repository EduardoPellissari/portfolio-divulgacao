#!/bin/bash

set -u

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

pause_and_exit() {
  local code="${1:-0}"
  echo ""
  read -r -p "Pressione Enter para fechar..." _
  exit "$code"
}

cd "$(dirname "$0")"

echo "=========================================="
echo " Publicar projeto no GitHub Pages"
echo "=========================================="
echo ""
echo "Antes de continuar:"
echo "1) Crie um repositorio PUBLICO vazio no GitHub"
echo "2) Copie a URL HTTPS dele"
echo "   Ex.: https://github.com/SEU_USUARIO/portfolio-divulgacao.git"
echo ""

read -r -p "Cole a URL HTTPS do repositorio: " REPO_URL

if [ -z "$REPO_URL" ]; then
  echo "URL nao informada."
  pause_and_exit 1
fi

if [ ! -f "index.html" ]; then
  echo "Nao encontrei index.html nesta pasta."
  pause_and_exit 1
fi

if [ ! -d ".git" ]; then
  git init || pause_and_exit 1
fi

git add . || pause_and_exit 1

if git diff --cached --quiet; then
  echo "Nenhuma alteracao nova para enviar."
else
  git commit -m "Publicacao do portifolio" >/dev/null 2>&1 || true
fi

git branch -M main || pause_and_exit 1

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REPO_URL" || pause_and_exit 1
else
  git remote add origin "$REPO_URL" || pause_and_exit 1
fi

git push -u origin main || {
  echo ""
  echo "Falha no envio para o GitHub."
  echo "Se pedir autenticacao, use seu usuario GitHub e token de acesso pessoal."
  pause_and_exit 1
}

echo ""
echo "Arquivos enviados com sucesso!"
echo ""
echo "Proximo passo no GitHub:"
echo "Settings > Pages > Deploy from a branch > main > /(root) > Save"
echo ""
echo "Depois disso, aguarde 1 a 3 minutos para o link ficar online."

pause_and_exit 0
