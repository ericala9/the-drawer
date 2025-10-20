---
title: "Acessando um Banco de Dados com Segurança no R"
author: "Erica Ambrosio"
date: "2025-10-20"
tags: ["R", "segurança", "credenciais", "variáveis de ambiente"]
---

# Acessando um Banco de Dados com Segurança no R

Ao utilizar o R para acessar bancos de dados institucionais, é necessário informar seu login e senha. Embora seja comum inserir essas credenciais diretamente no script, essa prática representa um risco de segurança: qualquer pessoa com acesso ao seu código ou à sua tela poderá visualizar suas informações confidenciais.

Mesmo quando se toma o cuidado de apagar esses dados antes de compartilhar o script, o R pode manter um registro no arquivo `.Rhistory`.

A boa notícia é que existe uma forma simples e segura de contornar essa situação: armazenar suas credenciais como variáveis de ambiente no seu computador. Dessa forma, somente você terá acesso a elas, e não será necessário digitá-las toda vez.

---

## Sumário

1. [Instale o pacote `usethis`](#1-instale-o-pacote-usethis)  
2. [Abra o arquivo `.Renviron`](#2-abra-o-arquivo-renviron)  
3. [Adicione suas credenciais ao arquivo `.Renviron`](#3-adicione-suas-credenciais-ao-arquivo-renviron)  
4. [Salve e feche o arquivo](#4-salve-e-feche-o-arquivo)  
5. [Reinicie o R](#5-reinicie-o-r)  
6. [Verifique se as variáveis foram salvas corretamente](#6-verifique-se-as-variáveis-foram-salvas-corretamente)  
7. [Acessando o banco de dados com segurança](#7-acessando-o-banco-de-dados-com-segurança)  
8. [Onde obter mais ajuda](#8-onde-obter-mais-ajuda)

---

## 1. Instale o pacote `usethis`

Caso ainda não o tenha instalado, utilize o comando:

```r
install.packages("usethis")
```

## 2. Abra o arquivo `.Renviron`

Rode o seguinte comando no R:

```r
usethis::edit_r_environ()
```

Esse comando abrirá o arquivo `.Renviron` no RStudio — provavelmente ele estará em branco.

## 3. Adicione suas credenciais ao arquivo `.Renviron`

No arquivo aberto, insira suas informações no seguinte formato:

```r
fulano_db_user = "99999"
fulano_db_senha = "123456"
```

Os nomes das variáveis (fulano_db_user e fulano_db_senha) podem ser personalizados. Recomendamos adotar um padrão como seunome_BancoDeDados_informacao, pois ele facilita a identificação e reutilização das variável:

- **seunome**: identifica que os dados pertencem a você;
- **BancoDeDados**: indica a qual banco de dados as credenciais se referem (ex: `db`);
- **informacao**: especifica se a variável contém o usuário (`user`) ou a senha (`senha`).

Esta padronização é especialmente importante para quem tem acesso a mais de um banco de dados.

## 4. Salve e feche o arquivo

Após inserir os dados, feche o arquivo `.Renviron` clicando no **X** da aba. O RStudio perguntará se você deseja salvar as alterações. Confirme.

## 5. Reinicie o R

Para que as alterações tenham efeito, é necessário reiniciar o R.

## 6. Verifique se as variáveis foram salvas corretamente

Após reiniciar, use os comandos abaixo para conferir se suas credenciais foram carregadas corretamente:
```r
Sys.getenv("fulano_db_user")
Sys.getenv("fulano_db_senha")
```

Se os valores retornarem conforme você salvou, está tudo certo. Caso contrário, reabra o arquivo com:

```r
usethis::edit_r_environ()
```

Verifique se as informações estão lá e, se necessário, repita o processo.

## 7. Acessando o banco de dados com segurança

Agora que suas credenciais estão salvas como variáveis de ambiente, você pode usá-las para acessar o banco de dados sem incluí-las diretamente no script. Segue um exemplo:

```r
library(RODBC)
db <- RODBC::odbcConnect("db",  uid = Sys.getenv("fulano_db_user"),  pwd = Sys.getenv("fulano_db_senha"),  DBMSencoding = "UTF-8")
```

Não se preocupe em decorar esse trecho. Sempre que precisar, você pode retornar a este tutorial para construir o seu código.

Seguindo esses passos, você melhora significativamente a segurança do seu ambiente de trabalho e protege suas informações pessoais.

## 8. Onde obter mais ajuda


Caso tenha dúvidas ou dificuldades, não hesite em entrar em contato pelo e-mail [user@mail.com](mailto:user@mail.com).
