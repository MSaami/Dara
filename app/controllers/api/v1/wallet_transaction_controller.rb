class Api::V1::WalletTransactionController < ApplicationController
  before_action :set_wallet, only: [:create]
  before_action :set_wallet_transaction, only: [:update]

  def create
    wallet_transaction = @wallet.wallet_transactions.build(wallet_params)
    wallet_transaction.save!
  end

  def update
    @wallet_transaction.update!(wallet_params)
  end

  private
  def wallet_params
    params.require(:wallet_transaction).permit(:category_id, :description, :amount, :at_date)
  end


  def set_wallet
    @wallet = Wallet.find(params[:wallet_id])
  end

  def set_wallet_transaction
    @wallet_transaction = WalletTransaction.find(params[:id])
  end

end
