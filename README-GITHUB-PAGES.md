# Publicar no GitHub Pages (link fixo)

Este guia cria um link como:

- `https://SEU_USUARIO.github.io/portfolio-divulgacao`

## Opcao 1 (mais simples, sem terminal)

1. Acesse [github.com](https://github.com) e entre na sua conta.
2. Clique em **New repository**.
3. Nome do repositorio: `portfolio-divulgacao`.
4. Deixe como **Public** e clique em **Create repository**.
5. Abra a pasta deste projeto no Finder.
6. Selecione estes itens e arraste para a pagina do repositorio no GitHub:
   - `index.html`
   - `styles.css`
   - `script.js`
   - pasta `assets`
   - arquivo `.nojekyll`
7. Clique em **Commit changes**.
8. No GitHub, entre em **Settings > Pages**.
9. Em **Source**, selecione:
   - **Deploy from a branch**
   - Branch: `main`
   - Folder: `/ (root)`
10. Clique em **Save**.
11. Aguarde 1 a 3 minutos.
12. Seu link vai aparecer nessa mesma tela de Pages.

## Opcao 2 (atalho por script)

1. Crie o repositorio vazio no GitHub com nome `portfolio-divulgacao`.
2. Copie a URL HTTPS do repositorio (ex.: `https://github.com/SEU_USUARIO/portfolio-divulgacao.git`).
3. Rode o arquivo `publicar-github-pages.command` e cole a URL quando ele pedir.
4. Depois no GitHub ative em **Settings > Pages** conforme passos 8 a 10 acima.

## Observacoes importantes

- O link do GitHub Pages e publico (qualquer pessoa com internet consegue abrir).
- Sempre que voce atualizar os arquivos e fizer novo envio, o site atualiza.
- Se a atualizacao demorar para aparecer, aguarde alguns minutos e atualize a pagina com `Cmd + Shift + R`.

## Se aparecer erro de autenticacao no envio

Mensagem comum:

- `Invalid username or token`
- `Password authentication is not supported for Git operations`

Como resolver (token no lugar da senha):

1. No GitHub, clique na sua foto > `Settings`.
2. Va em `Developer settings`.
3. `Personal access tokens` > `Tokens (classic)`.
4. Clique em `Generate new token (classic)`.
5. Nome: `portfolio-push` (exemplo).
6. Expiracao: 30 dias (ou o periodo que preferir).
7. Marque o escopo `repo`.
8. Clique em `Generate token`.
9. Copie o token na hora (o GitHub mostra apenas uma vez).
10. Rode `publicar-github-pages.command` novamente.
11. Quando pedir credenciais no Terminal:
   - Username: seu usuario GitHub (ex.: `EduardoPellissari`)
   - Password: cole o token (nao e sua senha da conta).

Obs.: se o terminal nao perguntar username/password automaticamente, o script agora abre uma etapa manual para voce digitar usuario e token e tentar novamente.
