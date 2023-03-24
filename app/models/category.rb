class Category < ApplicationRecord
  has_many :wallet_transactions

  validates :name, presence: true
end
