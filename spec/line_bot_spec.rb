require 'app'

describe '#client' do
  let(:client) { LineBot.client }

  it 'initializes a bot client' do
    expect(client).to be_instance_of(Line::Bot::Client)
  end
end

describe '#is_keyword_in_message?' do
  context 'Message with an accepted keyword' do
    it 'returns true' do
      expect(LineBot.is_keyword_in_message?(LineBot::ACCEPTED_KEYWORDS.keys, 'hi!')).to be true
    end
  end

  context 'Message with an unaccepted keyword' do
    it 'returns false' do
      expect(LineBot.is_keyword_in_message?(LineBot::ACCEPTED_KEYWORDS.keys, 'random')).to be false
    end
  end
end

describe '#bot_reply_to' do
  context 'Message with an accepted keyword' do
    it 'returns true' do
      expect(LineBot.bot_reply_to('hi!')).to include('Hello! Kamusta na 2mb mong brains?')
    end
  end

  context 'Message with an unaccepted keyword' do
    it 'returns false' do
      expect(LineBot.bot_reply_to('random')).to eq('')
    end
  end
end

describe '#get_keyword' do
  context 'Message with an accepted keyword' do
    it 'returns the correct reply' do
      expect(LineBot.get_keyword(LineBot::ACCEPTED_KEYWORDS.keys, 'hi!')).to eq(:hi)
    end
  end

  context 'Message with an unaccepted keyword' do
    it 'returns an empty string' do
      expect(LineBot.get_keyword(LineBot::ACCEPTED_KEYWORDS.keys, 'random')).to eq(nil)
    end
  end
end
