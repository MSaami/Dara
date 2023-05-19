class WalletTransaction < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :category
  belongs_to :wallet


  validates_presence_of :category
  validates_presence_of :wallet
  validates_presence_of :amount


  before_save :set_defaults
  after_save :update_wallet_balance, if: Proc.new {amount_previously_changed?}
  after_destroy :update_wallet_balance_for_destroy

  private
  def update_wallet_balance
    old_amount = amount_previous_change[0].to_i
    new_amount = amount_previous_change[1].to_i
    wallet.increment!(:balance, new_amount - old_amount)
  end

  def update_wallet_balance_for_destroy
    wallet.increment!(:balance, -self.amount)
  end

  def set_defaults
    self.at_date ||= Date.today.to_s
  end

end
