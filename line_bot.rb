require 'line/bot'
# Comment out for development
# require 'dotenv/load'

class LineBot
	BOT_NAME = /(mr\.?\s?resibo|resibo)/i
	KEYWORD_STR_REGEX = "(^|\s|[^[a-zA-Z]])%s($|\s|[^[a-zA-Z]])"
  ACCEPTED_KEYWORDS = {
    'sureball': ['Oh SUREBALL daw!', 'Gawin mo na lang!', 'Pakalbo ka muna!', 'Tokis pa more!'],
    'ganda': ['Talaga!', 'Ang GANDA! 😍'],
    'martin': ['Son of G!', 'POGI!', 'Anak ni Mrs. Galang'],
    'barber': ['KRISTIAN NOEL PATRICIO!'],
    'barbers': ['KRISTIAN NOEL PATRICIO!'],
    'hi': ['Hello! kamusta na 2mb mong brains?'],
    'hello': ['Hello! kamusta na 2mb mong brains?'],
    'pogi': ['Eguls'],
    'kalbo': ['Kririn!'],
    'tropa': ['Sino tropa nun?', 'Tropa ba talaga?'],
    'focus': ['Focus talaga!','Focus sa goals!', 'Focus sa faith!']
  }

	def self.client
		@client ||= Line::Bot::Client.new { |config|
		config.channel_id = ENV["LINE_CHANNEL_ID"]
		config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
		config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
		}
	end

	def self.bot_reply_to(message)
		message = message.downcase

    return '' unless BOT_NAME.match?(message) || is_keyword_in_message?(ACCEPTED_KEYWORDS.keys, message)

    keyword = get_keyword(ACCEPTED_KEYWORDS.keys, message)

    if keyword
			ACCEPTED_KEYWORDS[keyword].sample
    end

		'Di ko gets masyadong pang low level.'
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

  def self.is_keyword_in_message?(keywords, message)
		keywords.any? { |keyword| Regexp.new(KEYWORD_STR_REGEX % keyword).match?(message) }
	end

  def self.get_keyword(keywords, message)
    keywords.find { |keyword| Regexp.new(KEYWORD_STR_REGEX % keyword).match?(message) }
  end

end
