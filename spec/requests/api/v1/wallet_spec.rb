require 'rails_helper'

RSpec.describe "Api::V1::Wallets", type: :request do
  describe 'POST /create' do
    it 'create wallet' do
      params = attributes_for(:wallet)

      post '/api/v1/wallet', params: {wallet: params}
      expect(response).to have_http_status(204)
    end
  end

  describe 'GET /show' do
    it 'returns wallet details' do
      wallet = create(:wallet)
      get '/api/v1/wallet/' + wallet.id.to_s
      expect(json['data']['name']).to eq(wallet.name)
      expect(json['data']['balance']).to eq(wallet.balance)
    end
  end
end
