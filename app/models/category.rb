class Category < ApplicationRecord
  default_scope { order(created_at: :desc) }

  has_many :wallet_transactions

  validates :name, presence: true
end
