import telebot, sys
telebot.TeleBot(token='<telegram bot token>').send_message(chat_id="<channel id>", text=" ".join(sys.argv[1:]))
