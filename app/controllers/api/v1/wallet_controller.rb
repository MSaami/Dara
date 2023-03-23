class Api::V1::WalletController < ApplicationController

  def create
    Wallet.create!(create_params)
  end

  private
  def create_params
    params.require(:wallet).permit(:name, :balance)
  end

end
