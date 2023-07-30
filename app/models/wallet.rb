class Wallet < ApplicationRecord
  has_many :wallet_transactions
  has_many :budgets
  has_many :loans

  def budgets_by_filter(year: JalaliDate.new(Date.today).year, month: JalaliDate.new(Date.today).month)
    budgets.where(year: year, month: month)
  end

  def update_balance_by(amount)
    increment!(:balance, amount)
  end

end
