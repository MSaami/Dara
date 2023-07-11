require 'rails_helper'

RSpec.describe "Api::V1::Installments", type: :request do
  describe "GET /index" do
    it 'return all the Installments belongs to loan' do
      loan = create(:loan)
      installments = create_list(:installment, 10, loan: loan)

      get "/api/v1/loan/#{loan.id}/installment"

      expect(response).to have_http_status(:ok)
      expect(json['data'].count).to eq(10)
    end
  end
end
