class WalletTransaction < ApplicationRecord
  belongs_to :category
  belongs_to :wallet

  validates_presence_of :category
  validates_presence_of :wallet
  validates_presence_of :amount

  after_save :update_wallet_balance, if: Proc.new {amount_previously_changed?}

  private
  def update_wallet_balance
    old_amount = amount_previous_change[0].to_i
    new_amount = amount_previous_change[1].to_i
    wallet.increment!(:balance, new_amount - old_amount)
  end

end
