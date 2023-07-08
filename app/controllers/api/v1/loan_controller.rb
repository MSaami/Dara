class Api::V1::LoanController < ApplicationController
  before_action :set_wallet, only: [:index]

  def index
    render json: {data: @wallet.loans}
  end


  private
  def set_wallet
    @wallet = Wallet.find(params[:wallet_id])
  end


end
