require 'line/bot'
# Comment out for development
# require 'dotenv/load'

class LineBot
	BOT_NAME = /(mr\.?\s?resibo|resibo)/i
	KEYWORD_STR_REGEX = "(^|\s|[^[a-zA-Z]])%s($|\s|[^[a-zA-Z]])"
  ACCEPTED_KEYWORDS = {
    'sureball': ['Oh SUREBALL daw!', 'Gawin mo na lang!', 'Pakalbo ka muna!', 'Tokis pa more!'],
    'tokis': ['Tokis talaga yan si Peps!', 'Tawag ka KRISTIAN NOEL PATRICIO!'],
    'prince': ['Prince Tokis!', 'Prince Manyak!', 'Prince Sureball!'],
    'ganda': ['Talaga!', 'Ang GANDA! 😍', 'Ii tenki da ne'],
    'martin': ['Son of G!', 'POGI!', 'Anak ni Mrs. Galang'],
    'barber': ['KRISTIAN NOEL PATRICIO!', 'Tawag ka KRISTIAN NOEL PATRICIO!', 'Pagupit nga KRISTIAN NOEL PATRICIO!'],
    'barbero': ['KRISTIAN NOEL PATRICIO!', 'Tawag ka KRISTIAN NOEL PATRICIO!', 'Pagupit nga KRISTIAN NOEL PATRICIO!'],
    'barbers': ['KRISTIAN NOEL PATRICIO!', 'Tawag ka KRISTIAN NOEL PATRICIO!', 'Pagupit nga KRISTIAN NOEL PATRICIO!'],
    'hi': ['Hello! kamusta na 2mb mong brains?'],
    'hello': ['Hello! kamusta na 2mb mong brains?'],
    'pogi': ['Eguls', 'Tawag ka Martin', 'Tawag ka Renz'],
    'kalbo': ['Kririn!'],
    'tropa': ['Sino tropa nun?', 'Tropa ba talaga?'],
    'focus': ['Focus talaga!','Focus sa goals!', 'Focus sa faith!'],
    'guys': ['The bomb has been planted!', 'Ingat may terrorista!', 'ANO?!'],
    'ベル': ['Ayan ba yung malibog pa sa daga?', 'Kririn!', 'Hi! Kuya Jobs!', 'Yobabs!'],
    'bern': ['Ayan ba yung malibog pa sa daga?', 'Kririn!', 'Hi! Kuya Jobs!', 'Yobabs!'],
    'bye': ['Hug mo ko!'],
    'hug': ['Ano ba yan ang clingy!'],
    'alta': ['Akala ko ba prangka ka?'],
    'mamu': ["I've come to bargain!"],
    'dormamu': ["I've come to bargain!"],
    'sakit': ['Gets ko nararamdaman mo', 'Ginusto mo yan diba!'],
    'masakit': ['Gets ko nararamdaman mo', 'Ginusto mo yan diba!'],
    'yarn': ['Nu ba yarn', 'ANONG YARN?!'],
    'ロイ': ['Nabuhay!', 'Gets ko nararamdaman mo', 'Uwi uwi ding Nagoya!'],
    'titration': ['Bastos mo naman mamsir', 'Ano tagalog niyan?'],
    'rumaragasa': ['Ano pinagsasabi mo?'],
    'clingy': ['Clingy talaga yan si KRISTIAN NOEL PATRICIO', 'Bat ang clingy mo KRISTIAN NOEL PATRICIO?!'],
    'ian': ['Nasan na ang terrorista?', 'TERRORISTA!'],
    'harmony': ['Reunion ng Friends with Harmony?'],
    'loverboy': ['Tawag ka Renz!'],
    'renz':  ['Mr. Loverboy!', 'Pogi!', 'Loooooooooovvvvvvvvveeeeeeeeeeeerrrrrrrrrrbbooooooooooooy!'],
    'ebabs': ['Burger!', 'Uwi uwi ding Nagoya!'],
    'ding': ['Ang bato!'],
    'tag': ['Bat di mo i-tag?'],
    'rawr': ['Ano ka hayop?!', 'MEOW', 'Edi wow!'],
    'ohayo': ['Magandang umaga mga gwapo at magaganda!', 'Ano bang maganda sa umaga?'],
    'ohayou': ['Magandang umaga mga gwapo at magaganda!', 'Ano bang maganda sa umaga?'],
    'bayani': ['Rizal tawag ka!', 'Asan si Rizal?', 'Tapos mo na isulat sequel ng El Fili?'],
    'artist': ['Bawal di artist dito!', 'For artists only!'],
    'shrek': ['Di ako yun', 'Tropa mo yun diba!', 'Shrek mo mukha mo!'],
    'g': ['Oh G daw', 'Gago?', 'Gago ka?', 'Gunggong?']
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

  def self.is_keyword_in_message?(keywords, message)
		keywords.any? { |keyword| Regexp.new(KEYWORD_STR_REGEX % keyword).match?(message) }
	end

  def self.get_keyword(keywords, message)
    keywords.find { |keyword| Regexp.new(KEYWORD_STR_REGEX % keyword).match?(message) }
  end

end
