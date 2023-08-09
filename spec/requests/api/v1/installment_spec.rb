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

  describe 'Delete Installments' do
    it 'deletes a installment' do
      loan = create(:loan, number_of_paid: 0)
      installments = create_list(:installment, 5, loan: loan)

      expect {
        delete "/api/v1/installment/#{installments.first.id}"
      }.to change {loan.reload.number_of_installment}.by(-1) 
      expect(response).to have_http_status(:no_content)
    end

    it 'remove number of paid if they were equeal' do
      loan = create(:loan, number_of_paid: 10, number_of_installment: 10)
      installments = create_list(:installment, 10, loan: loan)
      expect {
        delete "/api/v1/installment/#{installments.first.id}"
      }.to change {loan.reload.number_of_paid}.by(-1) 
        .and change {loan.reload.number_of_installment}.by(-1)
    end
  end

  describe 'Update installment' do
    it 'updates installment' do
      installment = create(:installment, amount: 1000, due_date: '2023-02-01')
      put '/api/v1/installment/' + installment.id.to_s, params: {installment: {amount: 2000, due_date: '2023-01-01'}}

      expect(response).to have_http_status(:no_content)
      expect(installment.reload.amount).to eq(2000)
      expect(installment.reload.due_date.to_s).to eq('2023-01-01')
    end
  end
  describe 'SHOW' do
    it 'shows a installment' do
      installment = create(:installment)
      get '/api/v1/installment/' + installment.id.to_s
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body['data']['id']).to eq(installment.id)
    end
  end
end
