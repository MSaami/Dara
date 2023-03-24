class Api::V1::WalletController < ApplicationController
  before_action :set_wallet, only: [:show]

  def create
    Wallet.create!(create_params)
  end

  def show
    render json: {data: @wallet}
  end

  private
  def create_params
    params.require(:wallet).permit(:name, :balance)
  end

  def set_wallet
    @wallet = Wallet.find(params[:id])
  end
end
