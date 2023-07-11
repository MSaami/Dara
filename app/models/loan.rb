class Loan < ApplicationRecord
  belongs_to :wallet
  has_many :installments
end
