# ==============================================================================
#                        Script padrão para projetos em R 
# ==============================================================================
# Título: Script padrão
# Autor: Nome
# Objetivo: Modelo com configurações e funções padrão para novos projetos em R
# Data: yyyy-mm-dd
# Demanda: informações sobre a solicitação — o que foi pedido, por quem, quando 
# e por qual meio (email, Redmine, WhatsApp)
# ==============================================================================

# ------------------------- Configuração do ambiente  -------------------------- 

rm(list = ls()) 
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

options(encoding = "UTF-8")
options(scipen = 999)
rstudioapi::writeRStudioPreference("data_viewer_max_columns", 1000L)

require(RODBC)
require(openxlsx)
require(dplyr)
require(tidyr)
require(reshape2)
require(stringr)

# Função para criar títulos centralizados de seções.
centralizado <- function(title, width = 78, border = "-", uppercase = FALSE) {
  if (uppercase) title <- toupper(title)
  label <- paste0(" ", title, " ")
  pad_total <- width - nchar(label)
  pad_left <- floor(pad_total / 2)
  pad_right <- ceiling(pad_total / 2)
  line <- paste0("# ", strrep(border, pad_left), label,strrep(border, pad_right))
  cat(line, "\n")
}

# centralizado("Preparação dos dados")

# ---------------------------- Preparação dos dados ---------------------------- 

db.con <- RODBC::odbcConnect("db", uid=Sys.getenv("user_bd_nome_usuario"),
                                  pwd=Sys.getenv("user_bd_nome_senha"),DBMSencoding  = "UTF-8")
dados <- RODBC::sqlQuery(db.con,paste0("select * FROM esquema.tabela"))

# [...]

# ---------------------------------- Análise ----------------------------------- 

# Escreva a análise aqui

# ---------------------------- Exportação dos dados ---------------------------- 

# Criação da pasta de output se ela ainda não existir.
if (!dir.exists("./output")) {
  dir.create("./output")
}

# ------------------------------------------------------------------------------
#                                    Entregas 
# ------------------------------------------------------------------------------
#
# Descrição dos produtos, incluindo:
# - O que foi entregue
# - Quem recebeu
# - Quando e como a entrega foi feita (email, Redmine, WhatsApp, etc.)
#
# Exemplo:
# - tabela_resumo.xlsx enviada para X em 2025.10.21 por email
#
# Exemplo:
# Produto:       tabela_resumo.xlsx
# Destinatário:  X
# Data:          2025-10-21
# Meio de envio: email
# Notas:         Enviado junto com o relatório de resumo do projeto

# ------------------------------------------------------------------------------
#                                Próximos passos
# ------------------------------------------------------------------------------
# Notas sobre o que falta ser feito e o que pode ser melhorado no futuro
# ------------------------------------------------------------------------------
