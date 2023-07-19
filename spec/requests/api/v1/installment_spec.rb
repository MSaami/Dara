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

  describe "PUT Pay" do
    it 'pay a installment' do
      loan = create(:loan, number_of_paid: 0)
      installments = create_list(:installment, 4, loan: loan)
      expect {
        put "/api/v1/installment/#{installments.first.id}/pay"
      }.to change {installments.first.reload.status}.from('unpaid').to('paid')
      expect(response).to have_http_status(:no_content)
      expect(loan.reload.number_of_paid).to eq(1)
    end
  end
end
