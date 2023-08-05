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

  describe "POST" do
    it 'create a loan with installments' do
      wallet = create(:wallet)

      payload = {title: 'Mellat Bank', due_date: '2023-12-10', installments: [{number_of_installment: 1, amount: 15000}, {number_of_installment: 10, amount: 14000}]}

      post "/api/v1/wallet/#{wallet.id}/loan", params: {loan: payload}

      expect(response).to have_http_status(:no_content)
      expect(Loan.first.title).to eq('Mellat Bank')
      expect(Installment.count).to eq(11)
    end
  end

  describe "DELETE" do
    it 'deletes a loan' do
      loan = create(:loan)
      installments = create_list(:installment, 5, loan: loan)

      expect {
        delete "/api/v1/loan/#{loan.id}"
      }.to change {Loan.count}.by(-1)
        .and change {Installment.count}.by(-5)
    end
  end

  describe 'UPDATE' do
    it 'update a loan' do
      loan = create(:loan, title: 'My Loan', amount: 1000)

      expect {
        put "/api/v1/loan/#{loan.id}", params: {loan: {title: 'New Loan', amount: 2000}}
      }.to change {loan.reload.title}.from('My Loan').to('New Loan')
        .and change {loan.amount}.from(1000).to(2000)
    end
  end
end
