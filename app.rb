# app.rb
require 'sinatra/base'
require './line_bot'
require 'json'

class App < Sinatra::Base
  post '/callback' do
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    client = LineBot.client
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    events.each do |event|
      # Filter out non-message events
      next if event.class != Line::Bot::Event::Message

      case event.type
      # when receive a text message
      when Line::Bot::Event::MessageType::Text
        user_name = ''
        user_id = event['source']['userId']
        response = client.get_profile(user_id)
        if response.class == Net::HTTPOK
          contact = JSON.parse(response.body)
          user_name = contact['displayName']
        else
          # Can't retrieve the contact info
          p "#{response.code} #{response.body}"
        end

        if event.message['text'].downcase == 'test'
          # Sending a message when LINE tries to verify the webhook
          LineBot.send_bot_message(
            'Everything is working!',
            client,
            event
          )
        else
          # The answer mechanism
          LineBot.send_bot_message(
            LineBot.bot_reply_to(event.message['text']),
            client,
            event
          )
        end
      end
    end
    'OK'
  end
end
