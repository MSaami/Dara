require 'rails_helper'

RSpec.describe "Api::V1::Wallets", type: :request do
  describe 'POST /create' do
    it 'create wallet' do
      params = attributes_for(:wallet)

      post '/api/v1/wallet', params: {wallet: params}
      expect(response).to have_http_status(204)
    end
  end
end
