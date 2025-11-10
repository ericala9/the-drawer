centralizado <- function(title, width = 78, border = "-", uppercase = FALSE) {
  if (uppercase) title <- toupper(title)
  label <- paste0(" ", title, " ")
  pad_total <- width - nchar(label)
  pad_left <- floor(pad_total / 2)
  pad_right <- ceiling(pad_total / 2)
  line <- paste0("# ", strrep(border, pad_left), label,strrep(border, pad_right))
  cat(line, "\n")
}

centralizado <- function(title, width=78, border = "-", uppercase = FALSE) {
  if (uppercase) title <- toupper(title)
  top_bottom <- paste(rep(border, width), collapse = "")
  pad <- floor((width - nchar(title))/2)
  middle <- paste0(strrep(" ", pad-1), title)
  cat("#", top_bottom, "\n# ", middle, "\n#", top_bottom, "\n")
}
