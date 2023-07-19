class Api::V1::InstallmentController < ApplicationController
  before_action :set_loan, only: [:index]
  before_action :set_installment, only: [:pay]


  def index
    render json: {data: @loan.installments}
  end

  def pay
    @installment.pay!
  end

  private
  def set_loan
    @loan = Loan.find(params[:loan_id])
  end

  def set_installment
    @installment = Installment.find(params[:id])
  end
end
