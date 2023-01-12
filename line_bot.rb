require 'line/bot'
# Comment out for development
# require 'dotenv/load'

class LineBot
	BOT_NAME = /(mr\.?\s?resibo|resibo)/i
	KEYWORD_STR_REGEX = "(^|\s|[^[a-zA-Z]])%s($|\s|[^[a-zA-Z]])"
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

		if is_keyword_in_message(["hi", "hello"], message)
			"Hello #{user_name}, kamusta na 2mb mong brains?"
		elsif is_keyword_in_message(["sureball"], message)
			"Oh SUREBALL daw!"
		elsif is_keyword_in_message(["sorry"], message)
			'Ganito lang talaga ako'
		elsif is_keyword_in_message(["ganda"], message)
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

	def self.is_keyword_in_message(keywords, message)
		keywords.each { |keyword|
			has_matched = Regexp.new(KEYWORD_STR_REGEX % keyword).match?(message)
			return true if has_matched
		}
		return false
	end

end