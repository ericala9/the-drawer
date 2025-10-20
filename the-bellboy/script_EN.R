# ==============================================================================
#                              📁 Folder Monitoring
# ==============================================================================
# Notifies the user when new folders are created in a specified directory.
# Created with the help of CoPilot.
# Date: 2025-07-14
# ==============================================================================


# ------------------------------------------------------------------------------
#                            🛠️ Environment Setup
# ------------------------------------------------------------------------------

# Load required libraries
library(jsonlite)
library(lubridate)
library(beepr)
library(tcltk)
tcltk::tclRequire("Tk")
library(crayon)

# Define folder paths
main_folder    <- "Z:/Folder/Target"                     # Folder to monitor
history_folder <- "C:/Users/erica/monitor"                    # Folder for daily history files
log_file       <- file.path(history_folder, "folder_log.txt")# Central log file
ps_script      <- "C:/Users/erica/project/notify.ps1"         # 🎈 PowerShell notification script

# Create history folder if it doesn't exist
if (!dir.exists(history_folder)) dir.create(history_folder, recursive = TRUE)

# ------------------------------------------------------------------------------
#                            📆 Date Preparation
# ------------------------------------------------------------------------------

# Format today's and yesterday's dates
today     <- format(Sys.Date(), "%Y-%m-%d")
yesterday <- format(Sys.Date() - 1, "%Y-%m-%d")

# Define history file paths
history_file_today     <- file.path(history_folder, paste0("folder_history_", today, ".json"))
history_file_yesterday <- file.path(history_folder, paste0("folder_history_", yesterday, ".json"))

# ------------------------------------------------------------------------------
#                            📂 Folder Comparison Logic
# ------------------------------------------------------------------------------

# Get today's folder list
folders_today <- list.dirs(main_folder, full.names = FALSE, recursive = TRUE)

# Load yesterday's data
folders_yesterday <- if (file.exists(history_file_yesterday)) {
  fromJSON(history_file_yesterday)
} else {
  character(0)
}

# Identify new folders
new_folders <- setdiff(folders_today, folders_yesterday)

# Save today's folder list
write_json(folders_today, history_file_today, pretty = TRUE)

# ------------------------------------------------------------------------------
#                            🔔 Notification & Logging
# ------------------------------------------------------------------------------

# Compose message
timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
if (length(new_folders) > 0) {
  folder_msg <- paste("•", new_folders, collapse = "\n")
  message_hello    <- paste("Checked at", timestamp, "\nNew folders found:\n", folder_msg)
  
  cat(yellow(message_hello), "\n")                  # 🟡 Console log
  beepr::beep(3)                               # 🔔 Treasure chest sound
  shell.exec(main_folder)                     # 🚪 Open folder
} else {
  message_hello <- paste("Checked at", timestamp, "\nNo new folders found.")
  cat(green(message_hello), "\n")                   # 🟢 Console log
  beepr::beep(1)                               # ✅ Simple beep
}

# ------------------------------------------------------------------------------
#                            💬 Popup Notification
# ------------------------------------------------------------------------------

# Show notification popup
# Create a top-level window
top <- tktoplevel()


# Make it look clean and topmost
tkwm.title(top, "Folder Checker")
tkwm.geometry(top, "+500+300")  # Position on screen
tkfocus(top)                    # Grab focus
tkraise(top)                    # Bring to front

# Show message box
tkmessageBox(title = "Folder Checker", message = message_hello)

tkdestroy(top)  # Clean up

# ------------------------------------------------------------------------------
#                            💡 Tray Balloon Notification
# ------------------------------------------------------------------------------

send_tray_notification <- function(msg) {
  system2("powershell", args = c("-ExecutionPolicy", "Bypass", "-File", ps_script, shQuote(msg)))
}
send_tray_notification(message_hello)


# ------------------------------------------------------------------------------
#                            📝 Logging
# ------------------------------------------------------------------------------

# Append message to log file
write(paste0("\n", message_hello), file = log_file, append = TRUE)

