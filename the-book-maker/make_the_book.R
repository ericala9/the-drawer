# ==============================================================================
#                                     NOTICE
# ==============================================================================
# This script is a personal utility designed to convert legitimate personal
# notes, documents, and public domain texts into an e-reader-friendly format.
#
# The author does not support or encourage digital piracy. This tool is not
# intended for the unauthorized conversion of copyrighted material. Please use
# it responsibly to enhance your reading experience of your own personal files.
#
# DISCLAIMER: This script is provided "as is", without warranty of any kind,
# express or implied. In no event shall the author be liable for any claim,
# damages, or other liability arising from the use of this script.
# ==============================================================================
#                     Make the Book: .txt to .docx Converter 
# ==============================================================================
# Title: Make the Book: .txt to .docx Converter 
# Author: Erica Ambrosio
# Purpose: Converts .txt files into formatted .docx books, or, as the initial
# purpose of this project, converts plain text to Kindle-ready Word docs
# Date: 2026-02-11
# ==============================================================================

# ----------------------------- Environment Setup ------------------------------ 

rm(list = ls()) 
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

options(encoding = "UTF-8")

library(dplyr)
library(officer)
library(stringr)

# -------------------------------- Text Reading --------------------------------  

# Importing the raw manuscript from a .txt file.
raw_manuscript <- readLines("sample_text.txt", encoding = "UTF-8")

# ---------------------------- Text Transformation ----------------------------- 

# Organizing the text into a structured data frame.
# We assign styles based on the position and length of each line.
df_book <- data.frame(content = raw_manuscript, stringsAsFactors = FALSE) %>%
  filter(content != "") %>%
  mutate(
    style = case_when(
      row_number() == 1 ~ "cover",
      nchar(content) <= 75 ~ "chapter_title",
      TRUE ~ "body_text"
    )
  )

# ------------------------------- Book Assembly --------------------------------  

# Initializing the Word document object.
doc <- read_docx()

# Defining the book's metadata (useful for Kindle library organization).
doc <- set_doc_properties(doc, 
                          title = df_book$content[1],
                          creator = "Your Name")

# --- Book Construction Loop ---------------------------------------------------

for(i in 1:nrow(df_book)) {
  
  ## Front Matter: Cover -------------------------------------------------------
  
  if(df_book$style[i] == "cover") {
    # Adding the main title and ensuring it's recognized as a heading
    doc <- body_add_par(doc, value = df_book$content[i], style = "heading 1") %>%
      body_replace_text_at_bkm(bookmark = "", value = df_book$content[i]) 
    
    doc <- body_add_par(doc, value = "", style = "Normal") # Spacer
    doc <- body_add_break(doc) # Moving to the next page
    
    ## Navigation: Table of Contents ---------------------------------------------  
    
    doc <- body_add_par(doc, value = "Table of Contents", style = "heading 1")
    doc <- body_add_toc(doc, level = 1)
    doc <- body_add_break(doc)
    
  } else if(df_book$style[i] == "chapter_title") {
    # Ensure each chapter starts on a fresh page
    if(i > 1 && df_book$style[i-1] != "cover") doc <- body_add_break(doc)
    
    ## Main Matter: Chapters -----------------------------------------------------  
    
    # Adding the chapter title using fpar for future styling flexibility
    doc <- body_add_fpar(doc, 
                         fpar(ftext(df_book$content[i])), 
                         style = "heading 1") 
    
  } else {
    ## Body Text ---------------------------------------------------------------
    doc <- body_add_par(doc, value = df_book$content[i], style = "Normal")
  }
}

# ------------------------------ Document Export ------------------------------- 

# Generating the final .docx file. 
# This file is now ready to be sent to your Kindle.
print(doc, target = "sample_text.docx")

# ------------------------------------------------------------------------------
