class WalletTransaction < ApplicationRecord
  default_scope { order(at_date: :desc) }
  belongs_to :category
  belongs_to :wallet


  validates_presence_of :category
  validates_presence_of :wallet
  validates_presence_of :amount


  before_save :set_defaults
  after_save :update_wallet_balance, if: Proc.new {amount_previously_changed?}
  after_destroy :update_wallet_balance_for_destroy
  after_save :update_spend

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

  def update_spend
    return if amount.positive?
    old_amount = amount_previous_change[0].to_i
    new_amount = amount_previous_change[1].to_i
    budget = Budget.current_budget(category_id: category_id, wallet_id: wallet_id).first
    if budget
      budget.increment!(:spend, old_amount - new_amount)
    end
  end

end
