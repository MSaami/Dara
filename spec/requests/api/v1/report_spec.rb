require 'rails_helper'
include JalaliTime

RSpec.describe 'Api::V1::Report', type: :request do

  describe "GET wallet/:wallet_id/report/budget" do
    it 'returns general report related to budget' do
      wallet = create(:wallet)
      transactions_amount = 0
      budgets_spend_amount = 0
      budgets_amount = 0
      categories = create_list(:category, 10) do |c|
        budget = create(:budget, category: c, month: current_month, wallet: wallet, spend: 0)
        wallet_transactions = create_list(:wallet_transaction, rand(5..30), amount: -5, category: c, wallet: wallet)
        transactions_amount += wallet_transactions.sum(&:amount).abs
        budgets_spend_amount += budget.reload.spend
        budgets_amount += budget.amount
        wallet_transaction = create(:wallet_transaction, amount: -100, category: c, wallet: wallet, at_date: 35.days.ago)
      end

      get "/api/v1/wallet/#{wallet.id}/report/budget"
      expect(response).to have_http_status(200)
      expect(json['data']['spend_budget_based_transaction']).to eq(transactions_amount)
      expect(json['data']['spend_budget_based_budget']).to eq(budgets_spend_amount)
      expect(json['data']['budget']).to eq(budgets_amount)
    end
  end
end
