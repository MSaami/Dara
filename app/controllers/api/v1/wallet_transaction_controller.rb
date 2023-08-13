class Api::V1::WalletTransactionController < ApplicationController
  before_action :authenticate_devise_api_token!, only: [:index]
  before_action :set_wallet, only: [:create, :index]
  before_action :set_wallet_transaction, only: [:update, :show, :destroy]

  def index
    render json: @wallet.wallet_transactions, root: :data
  end

  def create
    wallet_transaction = @wallet.wallet_transactions.build(wallet_params)
    wallet_transaction.save!
  end

  def update
    @wallet_transaction.update!(wallet_params)
  end

  def show
    render json: {data: @wallet_transaction}
  end

  def destroy
    @wallet_transaction.destroy!
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
