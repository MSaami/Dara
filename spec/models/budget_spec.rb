require 'rails_helper'
include JalaliTime

RSpec.describe Budget, type: :model do

  describe 'update spend after save transaction' do
    it 'update spend after create transaction' do
      budget = create(:budget, year: current_year, month: current_month)
      expect {
        create(:wallet_transaction, wallet: budget.wallet, category_id: budget.category_id, amount: -1000)
      }.to change{ budget.reload.spend }.from(0).to(1000)
    end

    it 'has not to change if we create the deposit transaction' do
      budget = create(:budget, year: current_year, month: current_month)
      expect {
        create(:wallet_transaction, wallet: budget.wallet, category_id: budget.category_id, amount: 1000)
      }.not_to change{ budget.reload.spend }
    end

    it 'has to change if we update transaction and increase amount' do
      budget = create(:budget, year: current_year, month: current_month)
      wallet_transaction = create(:wallet_transaction, wallet: budget.wallet, category_id: budget.category_id, amount: -1000)
      expect {
        wallet_transaction.amount = -1200
        wallet_transaction.save
      }.to change{ budget.reload.spend }.from(1000).to(1200)
    end

    it 'has to change if we update transaction and increase amount' do
      budget = create(:budget, year: current_year, month: current_month)
      wallet_transaction = create(:wallet_transaction, wallet: budget.wallet, category_id: budget.category_id, amount: -1000)
      expect {
        wallet_transaction.amount = -800
        wallet_transaction.save
      }.to change{ budget.reload.spend }.from(1000).to(800)
    end
  end

end
