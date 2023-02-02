require 'app'

describe '#client' do
  let(:client) { LineBot.client }

  it 'initializes a bot client' do
    expect(client).to be_instance_of(Line::Bot::Client)
  end
end

context 'Message with an accepted keyword' do
  describe '#is_keyword_in_message?' do
    it { expect(LineBot.is_keyword_in_message?(LineBot::ACCEPTED_KEYWORDS.keys, 'hi!')).to be true }
  end

  describe '#bot_reply_to' do
    it { expect(LineBot.bot_reply_to('hi!')).to include('Hello! Kamusta na 2mb mong brains?') }
  end

  describe '#get_keyword' do
    it 'returns the correct reply' do
      expect(LineBot.get_keyword(LineBot::ACCEPTED_KEYWORDS.keys, 'hi!')).to eq(:hi)
    end
  end
end

context 'Message with an unaccepted keyword' do
  describe '#is_keyword_in_message?' do
    it { expect(LineBot.is_keyword_in_message?(LineBot::ACCEPTED_KEYWORDS.keys, 'random')).to be false }
  end

  describe '#bot_reply_to' do
    it { expect(LineBot.bot_reply_to('random')).to eq('') }
  end

  describe '#get_keyword' do
    it { expect(LineBot.get_keyword(LineBot::ACCEPTED_KEYWORDS.keys, 'random')).to be_nil }
  end
end
