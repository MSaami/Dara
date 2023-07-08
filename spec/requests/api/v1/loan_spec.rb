require 'rails_helper'

RSpec.describe "Api::V1::Loans", type: :request do
  describe "GET /index" do
    it 'returns all of the loans belongs to wallet' do
      wallet = create(:wallet)
      loans = create_list(:loan, 20, wallet: wallet)
      get "/api/v1/wallet/#{wallet.id}/loan"
      expect(response).to have_http_status(:ok)
      expect(json['data'].count).to eq(20)
    end
  end
end
