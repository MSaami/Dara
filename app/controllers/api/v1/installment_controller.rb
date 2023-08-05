class Api::V1::InstallmentController < ApplicationController
  before_action :set_loan, only: [:index]
  before_action :set_installment, only: [:pay, :destroy, :update]


  def index
    render json: {data: @loan.installments}
  end

  def pay
    @installment.pay!
  end

  def destroy
    @installment.destroy!
    @installment.loan.remove_installment
  end

  def update
    @installment.update!(update_params)
  end

  private
  def set_loan
    @loan = Loan.find(params[:loan_id])
  end

  def set_installment
    @installment = Installment.find(params[:id])
  end

  def update_params
    params.require(:installment).permit(:amount, :due_date)
  end
end
