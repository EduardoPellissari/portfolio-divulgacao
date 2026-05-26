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

PORTA=""
for CANDIDATA in 5500 8080 3000 9000 8000; do
  if ! lsof -iTCP:"$CANDIDATA" -sTCP:LISTEN >/dev/null 2>&1; then
    PORTA="$CANDIDATA"
    break
  fi
done

if [ -z "$PORTA" ]; then
  echo "Nao foi possivel encontrar uma porta livre."
  echo "Feche outros servidores locais e tente novamente."
  pause_and_exit 1
fi

HOST_BIND="0.0.0.0"
IPS_LOCAIS="$(ifconfig | awk '/inet / {print $2}' | grep -E '^(192\.168\.|10\.|172\.(1[6-9]|2[0-9]|3[0-1])\.)' | sort -u || true)"

echo "Servidor iniciado em rede local."
echo "Abra no navegador:"
echo "http://localhost:$PORTA/index.html"
echo ""

if [ -n "$IPS_LOCAIS" ]; then
  while IFS= read -r IP; do
    [ -n "$IP" ] && echo "http://$IP:$PORTA/index.html"
  done <<< "$IPS_LOCAIS"
else
  echo "Nao consegui listar IPs locais automaticamente."
  echo "No Mac, abra Ajustes > Rede e veja o IP do Wi-Fi."
  echo "Depois use: http://SEU_IP:$PORTA/index.html"
fi

echo ""
echo "Dica: no celular, desative os dados moveis e use o mesmo Wi-Fi do computador."
echo "Para encerrar, pressione Ctrl+C."
echo ""

python3 -m http.server "$PORTA" --bind "$HOST_BIND" || {
  echo ""
  echo "Falha ao iniciar o servidor local."
  pause_and_exit 1
}
