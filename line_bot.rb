require 'line/bot'
require 'dotenv/load'

class LineBot
	BOT_NAME = /(mr\.?\s?resibo|resibo)/i
	ACCEPTED_KEYWORDS = [
		'sureball',
		'ganda',
		'sorry',
		'hi',
		'hello'
	]   

	def self.client
		@client ||= Line::Bot::Client.new { |config|
		config.channel_id = ENV["LINE_CHANNEL_ID"]
		config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
		config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
		}
	end

	def self.bot_reply_to(message, user_name)
		message = message.downcase

		return '' unless BOT_NAME.match?(message) || ACCEPTED_KEYWORDS.any? { |keyword| message.include?(keyword) }

		if message.include?('hello') || message.include?('hi')
			"Hello #{user_name}, kamusta na 2mb mong brains?"
		elsif message.include?('sureball')
			"Oh SUREBALL daw!"
		elsif message.include?('sorry')
			'Ganito lang talaga ako'
		elsif message.include?('ganda')
			['Ang GANDA! 😍', 'Talaga!'].sample
		else
			'Di ko gets masyadong pang low level.'
		end
	end

	def self.send_bot_message(message, client, event)
		# Log prints for debugging
		p 'Bot message sent!'
		p event['replyToken']
		p client

		message = { type: 'text', text: message }
		p message

		client.reply_message(event['replyToken'], message)
		'OK'
	end
end