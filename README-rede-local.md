# Rodar em Rede Local (Celular e Computador)

Opcao 1 (mais simples):

1. Abra a pasta do site.
2. Execute o arquivo `iniciar-rede-local.command`.
3. Primeiro teste no proprio Mac (link `localhost`).
4. Depois abra no celular o link com IP local que aparecer no Terminal
   (ex.: `http://192.168.x.x:5500/index.html`).

Opcao 2 (VS Code Live Server):

1. Abra a pasta `portfolio-divulgacao` no VS Code.
2. Clique em `Go Live`.
3. Use o link com IP local (na mesma rede Wi-Fi), nao `127.0.0.1`.

Opcao 3 (mais confiavel quando o celular nao abre na rede local):

1. Clique com o botao direito em `iniciar-link-publico.command` e escolha `Abrir`.
2. Ordem de tentativas do script:
   - `cloudflared` (sem tela de aviso)
   - `localhost.run` (normalmente sem tela de aviso)
   - `localtunnel` (pode mostrar tela de aviso)
3. Abra a URL HTTPS no celular.

Nome personalizado no link publico:

1. Abra `iniciar-link-publico.command` em um editor de texto.
2. Ajuste o valor de `SUBDOMINIO_DESEJADO` (ex.: `eduardo-sistemas`).
3. Rode o arquivo novamente.
4. Observacao: em LocalTunnel, nome personalizado pode exigir patrocinio e/ou ja estar em uso.
   Se isso acontecer, o script gera automaticamente um link aleatorio como fallback.

Checklist se nao abrir no celular:

1. Celular e computador no mesmo Wi-Fi.
2. Desative os dados moveis no celular.
3. No Mac, permita conexoes de entrada para `python3`.
4. Se nao aparecer aviso automatico, abra:
`Ajustes do Sistema > Rede > Firewall > Opcoes...`
e adicione `python3` e `Visual Studio Code` como "Permitir conexoes de entrada".
5. Se usar VPN no computador, desconecte para teste.
6. Evite rede "Convidado" (Guest Wi-Fi), pois costuma bloquear dispositivos entre si.

Teste rapido:

1. Rode `iniciar-rede-local.command`.
2. No proprio Mac, teste `http://localhost:PORTA/index.html`.
3. No proprio Mac, teste tambem o link com IP local exibido.
3. Se abrir no Mac e nao abrir no celular, o bloqueio e de rede/firewall.

Se clicar e "nao acontecer nada":

1. Clique com o botao direito no arquivo `.command` e escolha `Abrir`.
2. Se o macOS bloquear, va em `Ajustes > Privacidade e Seguranca` e clique em `Abrir Mesmo Assim`.
3. Alternativa manual no Terminal:
   `cd ~/Documents/Codex/2026-05-25/quero-fazer-um-portifolio-para-divulgar/portfolio-divulgacao && bash iniciar-link-publico.command`
