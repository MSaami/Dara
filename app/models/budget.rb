class Budget < ApplicationRecord
  extend JalaliTime
  belongs_to :wallet
  belongs_to :category

  scope :for_category, ->(category_id) { where(category_id: category_id) }
  scope :currents, ->{ where(year: current_year, month: current_month) }
  scope :for_wallet, ->(wallet_id) {where(wallet_id: wallet_id) }
  scope :current_budget,->(wallet_id:, category_id:) { currents.for_wallet(wallet_id).for_category(category_id) }



  def self.sync(wallet_id)
    budgets = Budget.where(wallet_id: wallet_id, year: current_year, month: current_month)
    grouped_data = WalletTransaction
      .unscoped
      .current_month_transactions
      .where(wallet_id: wallet_id, category_id: budgets.pluck(:category_id))
      .where('amount < ?', 0)
      .group(:category_id)
      .sum(:amount)
    grouped_data.each do |row|
      budget = budgets.find_by_category_id row[0]
      budget.spend = row[1].abs
      budget.save
    end
  end
end

