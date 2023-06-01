class Budget < ApplicationRecord
  belongs_to :wallet
  belongs_to :category
end
