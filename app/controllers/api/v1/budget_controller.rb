class Api::V1::BudgetController < ApplicationController
  before_action :set_wallet, only: [:create, :index]
  before_action :set_budget, only: [:destroy, :update, :show]
  def create
    @wallet.budgets.create!(create_params)
  end

  def index
    render json: {data: @wallet.budgets_by_filter}
  end

  def destroy
    @budget.destroy!
  end

  def update
    @budget.update!(create_params)
  end

  def show 
    render json: {data: @budget}
  end

  private
  def create_params
    params.require(:budget).permit(:amount, :month, :category_id, :year)
  end

  def set_wallet
    @wallet = Wallet.find(params[:wallet_id])
  end

  def set_budget
    @budget = Budget.find(params[:id])
  end
end
