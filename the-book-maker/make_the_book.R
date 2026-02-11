library(dplyr)
library(officer)
library(stringr)

# 1. Ler o arquivo
linhas <- readLines("teste.txt", encoding = "UTF-8")

# 2. Organizar com a nova lógica de [TITLE]
df_livro <- data.frame(texto = linhas, stringsAsFactors = FALSE) %>%
  filter(texto != "") %>%
  mutate(
    tipo = case_when(
      row_number() == 1 ~ "capa",
      nchar(texto) <= 75 ~ "titulo",
      TRUE ~ "paragrafo"
    )
  )

# Vendo o tamanho dos parágrafos para determinar automaticamente os que são
# parágrafo ou título
df_livro |> 
  mutate(tamanho = nchar(texto)) |> 
  summarise(min(tamanho),
            max(tamanho),
            .by = tipo)

# 2. Definindo os estilos de "Perfumaria"
# Criamos um padrão de parágrafo centralizado
centralizado <- fp_par(text.align = "center", padding = 10)

doc <- read_docx()

doc <- set_doc_properties(doc, 
                          title = "O Título do Livro",
                          creator = "Seu Nome Completo")

# 3. Loop de construção
for(i in 1:nrow(df_livro)) {
  
  if(df_livro$tipo[i] == "capa") {
    # Título principal centralizado
    doc <- body_add_par(doc, value = df_livro$texto[i], style = "heading 1") %>%
      body_replace_text_at_bkm(bookmark = "", value = df_livro$texto[i]) 
    # Para garantir a centralização na capa, usamos o comando de alinhamento:
    doc <- body_add_par(doc, value = "", style = "Normal") # Espaço
    doc <- body_add_break(doc)
    
    # Adiciona o Sumário (essencial para o Kindle)
    doc <- body_add_par(doc, value = "Table of Contents", style = "heading 1")
    doc <- body_add_toc(doc, level = 1)
    doc <- body_add_break(doc)
    
  } else if(df_livro$tipo[i] == "titulo") {
    if(i > 1 && df_livro$tipo[i-1] != "capa") doc <- body_add_break(doc)
    
    # Adicionando o Capítulo CENTRALIZADO
    # O officer aplica o estilo 'heading 1' e depois sobrepomos o alinhamento central
    doc <- body_add_fpar(doc, 
                         fpar(ftext(df_livro$texto[i], prop = fp_text(bold = TRUE, font.size = 18))), 
                         style = "heading 1") 
    
    # Nota: No Kindle, o 'heading 1' costuma ignorar a centralização se não for forçada no template.
    # Se o comando acima não centralizar, a forma mais garantida é usar o template.docx:
  } else {
    doc <- body_add_par(doc, value = df_livro$texto[i], style = "Normal")
  }
}

# 4. Salvar
print(doc, target = "teste.docx")
