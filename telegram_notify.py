import telebot
import sys
bot = telebot.TeleBot(token='<telegram bot token>')
bot.send_message(chat_id="<channel id>", text=" ".join(sys.argv[1:]))
