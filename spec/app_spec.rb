require 'app'

describe 'get /' do
  it 'responds with ok' do
    get '/'

    expect(last_response.body).to eq "Hello World!"
  end
end
