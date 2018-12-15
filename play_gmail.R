suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(gmailr))
# .httr-oauth added to .gitignore
# https://github.com/jimhester/gmailr 
# multiple emails: https://github.com/jennybc/send-email-with-r/blob/master/send-email-with-r.R

use_secret_file('~/.secrets/aabor-ubuntu-alert.json')

test_email <- mime(
  To = "aaborochkin@gmail.com",
  From = "aaborochkin@gmail.com",
  Subject = "this is just a gmailr test",
  body = "Can you hear me now?")

safe_send_message <- safely(send_message)
safe_send_message(test_email)
