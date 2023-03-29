class WalletTransactionSerializer < ActiveModel::Serializer
  attributes :id, :wallet_id, :amount, :description, :at_date
  belongs_to :category
end
