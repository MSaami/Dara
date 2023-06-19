class Budget < ApplicationRecord
  extend JalaliTime
  belongs_to :wallet
  belongs_to :category

  scope :for_category, ->(category_id) { where(category_id: category_id) }
  scope :currents, ->{ where(year: current_year, month: current_month) }
  scope :for_wallet, ->(wallet_id) {where(wallet_id: wallet_id) }
  scope :current_budget,->(wallet_id:, category_id:) { currents.for_wallet(wallet_id).for_category(category_id) }
end
