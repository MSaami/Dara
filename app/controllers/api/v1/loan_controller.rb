class Api::V1::LoanController < ApplicationController
  before_action :set_wallet, only: [:index, :create]
  before_action :set_loan, only: [:destroy, :update, :show]

  def index
    render json: {data: @wallet.loans}
  end

  def create
    loan = @wallet.loans.create(title: loan_params[:title])
    date = loan_params[:due_date]
    number_of_installment = 0
    amount = 0
    loan_params['installments'].each do |installment|
      installment[:number_of_installment].to_i.times do
        loan.installments.create(amount: installment[:amount], due_date: date, status: :unpaid)
        date = date.to_date + 1.month
        number_of_installment += 1
        amount += installment[:amount].to_i
      end
    end
    loan.update(number_of_installment: number_of_installment, amount: amount)
  end

  def update
    @loan.update!(update_params)
  end

  def destroy
    @loan.destroy!
  end

  def show
    render json: {data: @loan}
  end

  private
  def set_wallet
    @wallet = Wallet.find(params[:wallet_id])
  end

  def loan_params
    params.require(:loan).permit(:title, :due_date, installments: [:number_of_installment, :amount])
  end

  def set_loan
    @loan = Loan.find(params[:id])
  end
  
  def update_params
    params.require(:loan).permit(:title, :amount)
  end
end

