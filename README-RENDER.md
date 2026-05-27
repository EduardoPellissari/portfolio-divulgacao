# Publicar no Render (site estatico)

Este projeto ja esta pronto para o Render com o arquivo `render.yaml`.

## Opcao 1 (recomendada): Blueprint (automatico)

1. Entre em [render.com](https://render.com/) e faca login.
2. Clique em **New +** > **Blueprint**.
3. Conecte o repositorio `portfolio-divulgacao` do GitHub.
4. O Render vai ler o `render.yaml` automaticamente.
5. Clique em **Apply** para criar o servico.
6. Aguarde o deploy finalizar.

## Opcao 2: Criacao manual de Static Site

1. No Render, clique em **New +** > **Static Site**.
2. Selecione o repositorio `portfolio-divulgacao`.
3. Configure:
   - Build Command: `echo "Static site - sem etapa de build"`
   - Publish Directory: `.`
4. Em Environment Variables, adicione:
   - `SKIP_INSTALL_DEPS` = `true`
5. Clique em **Create Static Site**.

## Depois do deploy

- O Render gera uma URL no formato `https://nome-do-servico.onrender.com`.
- A cada novo push no GitHub, o Render publica as alteracoes automaticamente.
