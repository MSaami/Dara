class Wallet < ApplicationRecord
  has_many :wallet_transactions
  has_many :budgets

  def budgets_by_filter(year: JalaliDate.new(Date.today).year, month: JalaliDate.new(Date.today).month)
    budgets.where(year: year, month: month)
  end

end
