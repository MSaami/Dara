class Api::V1::ReportController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :set_wallet

  def budget
    spend_budget_based_budget = Budget.currents.for_wallet(@wallet.id).sum(:spend)
    spend_budget_based_transaction = WalletTransaction.current_month_transactions.where('amount < ?', 0).sum(:amount).abs
    budget = Budget.currents.sum(:amount)
    render json: {data: {
      spend_budget_based_transaction_in_human: number_to_currency(spend_budget_based_transaction, unit: '', precision: 0),
      spend_budget_based_budget_in_human: number_to_currency(spend_budget_based_budget, unit: '', precision: 0),
      budget_in_human: number_to_currency(budget, unit: '', precision: 0),
      spend_budget_based_budget: spend_budget_based_budget,
      spend_budget_based_transaction: spend_budget_based_transaction,
      budget: budget
    }
    }
  end

  private
  def set_wallet
    @wallet = Wallet.find(params[:wallet_id])
  end

end
