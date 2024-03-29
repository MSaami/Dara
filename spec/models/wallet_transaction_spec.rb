require 'rails_helper'

RSpec.describe WalletTransaction, type: :model do
  describe 'association' do

    it { should belong_to(:category) }
    it { should belong_to(:wallet) }

  end

  describe 'validations' do
    it {should validate_presence_of(:category)}
    it {should validate_presence_of(:amount)}
    it {should validate_presence_of(:wallet)}
  end

  describe 'after save callback' do
    subject(:wallet) {create(:wallet)}
    subject(:first_balance) {wallet.balance}
    it 'increment balance of wallet after creating wallet transaction' do
      wallet_transaction = build(:wallet_transaction, wallet: wallet)
      expect {wallet_transaction.save!}.to change(wallet, :balance)
        .from(first_balance)
        .to(first_balance + wallet_transaction.amount)
    end

    it 'decrement balance if after save wallet transaction if amount is negative' do
      wallet_transaction = build(:wallet_transaction, amount: -1000, wallet: wallet)
      expect {wallet_transaction.save!}.to change(wallet, :balance)
        .from(first_balance)
        .to(first_balance + wallet_transaction.amount)
    end

    it 'rollbacks if callback raises error' do
      allow(wallet).to receive(:increment!).and_raise(ActiveRecord::RecordInvalid)
      wallet_transaction = build(:wallet_transaction, amount: -1000, wallet: wallet)
      expect {wallet_transaction.save! rescue nil}.not_to change(WalletTransaction, :count)
    end
  end

  describe 'set default' do
    it 'set default for at date' do
      wallet_transaction = build(:wallet_transaction, at_date: nil)
      wallet_transaction.save!
      expect(wallet_transaction.reload.at_date).to eq(Date.today)
    end

    it 'skip set default for date if date is specified' do
      wallet_transaction = build(:wallet_transaction, at_date: Date.today.prev_day.to_s)
      wallet_transaction.save!
      expect(wallet_transaction.reload.at_date).to eq(Date.today.prev_day)
    end
  end

  describe 'scope tests' do
    it 'tests current_month scope to return current month transactions' do
      wallet = create(:wallet)
      wallet_transactions = create_list(:wallet_transaction, 5, wallet: wallet)
      pre_wallet_transactions = create_list(:wallet_transaction, 2, wallet: wallet, at_date: 35.days.ago)
      expect(described_class.current_month_transactions.count).to eq(5)
    end
  end
end
