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


  describe 'Syncing busget spends by expenses' do
    before :each do
      category1 = create(:category)
      category2 = create(:category)
      category3 = create(:category)
      category4 = create(:category)
      category5 = create(:category)
      wallet = create(:wallet)
      wallet_transaction1  = create_list(:wallet_transaction, 5, amount: -24000, category: category1, wallet: wallet)
      positive_wallet_transaction1 = create(:wallet_transaction, amount: 2000, category: category1, wallet: wallet)
      wallet_transaction2  = create_list(:wallet_transaction, 7, amount: -10000, category: category2, wallet: wallet)
      wallet_transaction3  = create_list(:wallet_transaction, 3, amount: -2000, category: category3, wallet: wallet)
      wallet_transaction4 = create_list(:wallet_transaction, 4, amount: -10000, category: category1, wallet: wallet, at_date: 45.days.ago)
      positive_wallet_transaction5 = create(:wallet_transaction, amount: 1000, category: category5, wallet: wallet)

      @budget1 = create(:budget, category: category1, wallet: wallet, month: current_month, spend: 0)
      @budget2 = create(:budget, category: category2, wallet: wallet, month: current_month, spend: 0)
      @budget3 = create(:budget, category: category3, wallet: wallet, month: current_month, spend: 0)
      @budget4 = create(:budget, category: category4, wallet: wallet, month: current_month, spend: 0)
      @budget5 = create(:budget, category: category5, wallet: wallet, month: current_month, spend: 0)
    end

    it 'syncs all the budgets after expenses' do
      expect {
        described_class.sync Wallet.last.id
      }.to change {@budget1.reload.spend}.from(0).to(5*24000)
        .and change {@budget2.reload.spend}.from(0).to(7*10000)
        .and change {@budget3.reload.spend}.from(0).to(3*2000)
        .and change {@budget4.reload.spend}.by(0)
        .and change {@budget5.reload.spend}.by(0)
    end
  end

end
