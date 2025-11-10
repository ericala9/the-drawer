# ==============================================================================
#                           Base Script for R Projects
# ==============================================================================
# Title: Base Script
# Author: Name
# Purpose: Template with utility functions and standard setup for new R projects
# Date: yyyy.mm.dd
# Request: details of the demand — what, who, when, and how (email, Redmine,
# WhatsApp)
# ==============================================================================

# ------------------------------------------------------------------------------
#                               Environment Setup
# ------------------------------------------------------------------------------

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

# Function to create centered section titles
center_title <- function(title, width = 78, border = "-", uppercase = FALSE) {
  if (uppercase) title <- toupper(title)
  label <- paste0(" ", title, " ")
  pad_total <- width - nchar(label)
  pad_left <- floor(pad_total / 2)
  pad_right <- ceiling(pad_total / 2)
  line <- paste0("# ", strrep(border, pad_left), label,strrep(border, pad_right))
  cat(line, "\n")
}

# center_title("Data Preparation")

# ------------------------------------------------------------------------------
#                                Data Preparation
# ------------------------------------------------------------------------------

db.con <- RODBC::odbcConnect("db", uid=Sys.getenv("user_bd_nome_user"),
                                  pwd=Sys.getenv("user_bd_nome_pswd"),DBMSencoding  = "UTF-8")
df <- RODBC::sqlQuery(db.con, paste0("select * FROM schema.table"))

# [...]

# ------------------------------------------------------------------------------
#                                    Analysis
# ------------------------------------------------------------------------------

# Add analysis code here

# ------------------------------------------------------------------------------
#                                   Deliveries
# ------------------------------------------------------------------------------
#
# Description of outputs, including:
# - What was delivered
# - Who received it
# - When and how the delivery was made (email, Redmine, WhatsApp, etc.)
#
# Example:
# - summary_table.xlsx sent to X on 2025.10.21 via email
#
# Example:
# Output:        summary_table.xlsx
# Recipient:     X
# Date:          2025.10.21
# Sent via:      email
# Notes:         Sent along with the project summary report

# ------------------------------------------------------------------------------
#                                   Next Steps
# ------------------------------------------------------------------------------
# Notes about what remains to be done or future improvements
# ------------------------------------------------------------------------------
