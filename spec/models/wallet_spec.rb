require 'rails_helper'

RSpec.describe Wallet, type: :model do

  describe '.budgets_by_filter' do

    it 'returns data related to current time' do
      jdate = JalaliDate.new(Date.today)
      current_year = jdate.year
      current_month = jdate.month
      wallet = create(:wallet)
      budgets = create_list(:budget, 5, wallet: wallet, year: current_year, month: current_month)
      budgets = create_list(:budget, 2, wallet: wallet, year: current_year + 1, month: current_month)
      budgets = create_list(:budget, 2, wallet: wallet, year: current_year + 1, month: current_month + 1)

      expect(wallet.budgets_by_filter.count).to eq(5)
    end


  end

end
