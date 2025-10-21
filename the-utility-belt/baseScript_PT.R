# ==============================================================================
#                        Script padrão para projetos em R 
# ==============================================================================
# Título: Script padrão
# Autor: Nome
# Objetivo: Modelo com configurações e funções padrão para novos projetos em R
# Data: yyyy.mm.dd
# Demanda: informações sobre a solicitação — o que foi pedido, por quem, quando 
# e por qual meio (email, Redmine, WhatsApp)
# ==============================================================================

# ------------------------------------------------------------------------------
#                            Configuração do ambiente
# ------------------------------------------------------------------------------

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

options(encoding = "UTF-8")
options(scipen = 999)

require(openxlsx)
require(dplyr)
require(tidyr)
require(reshape2)
require(stringr)

# ------------------------------------------------------------------------------
#                           Preparação dos dados
# ------------------------------------------------------------------------------

# [...]

# ------------------------------------------------------------------------------
#                                 Análise
# ------------------------------------------------------------------------------

# Escreva a análise aqui

# ------------------------------------------------------------------------------
#                                Entregas
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
# Data:          2025.10.21
# Meio de envio: email
# Notas:         Enviado junto com o relatório de resumo do projeto

# ------------------------------------------------------------------------------
#                            Próximos passos
# ------------------------------------------------------------------------------
# Notas sobre o que falta ser feito e o que pode ser melhorado no futuro
# ------------------------------------------------------------------------------
