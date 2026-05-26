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

# Edite este valor para o nome desejado no link publico (quando suportado pelo servico).
# Exemplo: eduardo-sistemas
SUBDOMINIO_DESEJADO="${SUBDOMINIO_DESEJADO: Portifólio Eduardo Pellissari Moreira}"

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 nao encontrado no sistema."
  pause_and_exit 1
fi

MODO_TUNNEL=""
if command -v cloudflared >/dev/null 2>&1; then
  MODO_TUNNEL="cloudflare"
elif command -v ssh >/dev/null 2>&1; then
  MODO_TUNNEL="localhostrun"
elif command -v npx >/dev/null 2>&1; then
  MODO_TUNNEL="localtunnel"
else
  echo "Nao encontrei cloudflared, ssh nem npx no sistema."
  echo "Opcao 1 (recomendada): instalar cloudflared para link sem pagina de aviso."
  echo "Instalacao (macOS Homebrew): brew install cloudflared"
  echo "Opcao 2: instalar Node.js para usar localtunnel."
  echo "Site: https://nodejs.org/"
  pause_and_exit 1
fi

PORTA=""
for CANDIDATA in 5500 8080 3000 9000; do
  if ! lsof -iTCP:"$CANDIDATA" -sTCP:LISTEN >/dev/null 2>&1; then
    PORTA="$CANDIDATA"
    break
  fi
done

if [ -z "$PORTA" ]; then
  echo "Nao foi possivel encontrar uma porta livre."
  pause_and_exit 1
fi

python3 -m http.server "$PORTA" --bind 127.0.0.1 >/tmp/portfolio-http.log 2>&1 &
SERVIDOR_PID=$!

cleanup() {
  kill "$SERVIDOR_PID" >/dev/null 2>&1 || true
}

trap cleanup EXIT INT TERM

echo "Servidor local iniciado."

if [ "$MODO_TUNNEL" = "cloudflare" ]; then
  echo "Modo: Cloudflare Tunnel (sem pagina de aviso do LocalTunnel)."
  echo "Aguarde alguns segundos para aparecer uma URL https://...trycloudflare.com"
  echo "Quando terminar, pressione Ctrl+C."
  echo ""

  cloudflared tunnel --url "http://127.0.0.1:$PORTA" || {
    echo ""
    echo "Falha ao gerar o link publico com cloudflared."
    pause_and_exit 1
  }
elif [ "$MODO_TUNNEL" = "localhostrun" ]; then
  echo "Modo: localhost.run (normalmente sem tela de aviso)."
  echo "Aguarde aparecer uma URL https://..."
  echo "Quando terminar, pressione Ctrl+C."
  echo ""

  ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:127.0.0.1:"$PORTA" nokey@localhost.run || {
    echo ""
    echo "Falha ao gerar o link publico com localhost.run."
    echo "Tentando LocalTunnel..."
    echo ""

    if command -v npx >/dev/null 2>&1; then
      npx --yes localtunnel --port "$PORTA" || {
        echo ""
        echo "Falha ao gerar o link publico."
        pause_and_exit 1
      }
    else
      pause_and_exit 1
    fi
  }
else
  echo "Modo: LocalTunnel (pode aparecer pagina de aviso antes do site)."
  echo "Tentando usar nome personalizado: $SUBDOMINIO_DESEJADO"
  echo "Aguarde alguns segundos para aparecer a URL https://..."
  echo "Quando terminar, pressione Ctrl+C."
  echo ""

  if npx --yes localtunnel --port "$PORTA" --subdomain "$SUBDOMINIO_DESEJADO"; then
    exit 0
  fi

  echo ""
  echo "Nao foi possivel reservar o nome personalizado no LocalTunnel."
  echo "Esse recurso pode exigir patrocinio ou o nome pode ja estar em uso."
  echo "Gerando link publico aleatorio como fallback..."
  echo ""

  npx --yes localtunnel --port "$PORTA" || {
    echo ""
    echo "Falha ao gerar o link publico."
    echo "Tente novamente em alguns segundos."
    pause_and_exit 1
  }
fi
