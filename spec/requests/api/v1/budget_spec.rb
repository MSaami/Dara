require 'rails_helper'

RSpec.describe "Api::V1::Budgets", type: :request do
  describe "POST wallet/:wallet_id/budget" do

    it 'create a budget for category' do
      wallet = create(:wallet, balance: 15000)
      category = create(:category)
      params = attributes_for(:budget)
      post "/api/v1/wallet/#{wallet.id}/budget", params: {budget: params}

      expect(response).to have_http_status(204)
      expect(wallet.budgets.count).to eq(1)
    end
  end

  describe "GET wallet/:wallet_id/budget" do
    it 'returns budget related to the wallet' do
      wallet = create(:wallet)
      budgets = create_list(:budget, 10, wallet: wallet, year: 1402, month: 4)
      get "/api/v1/wallet/#{wallet.id}/budget"
      expect(response).to have_http_status(200)
      expect(json.has_key?('data')).to be true
      expect(json['data'].count).to eq(10)
    end
  end

  describe "DELETE" do
    it 'delete a budget' do
      budget = create(:budget)
      delete "/api/v1/budget/#{budget.id}"
      expect(response).to have_http_status(204)
      expect {budget.reload}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'UPDATE' do
    it 'updates a budget' do
      category = create(:category)
      other_category = create(:category)
      budget = create(:budget, amount: 1000, category: category, month: 5, year: 1402)
      params = {amount: 12000, category_id: other_category.id, year: 1500, month: 4}
      put "/api/v1/budget/#{budget.id}", params: {budget: params}

      expect(response).to have_http_status(204)
      expect(budget.reload.category_id).to eq(other_category.id)
      expect(budget.amount).to eq(12000)
      expect(budget.year).to eq(1500)
      expect(budget.month).to eq(4)
    end
  end

  describe 'SHOW' do
    it 'display a budget' do
      budget = create(:budget)
      get '/api/v1/budget/' + budget.id.to_s
      expect(response).to have_http_status(200)
      expect(json['data']['id']).to eq(budget.id)
    end
  end
end
