class Api::V1::InstallmentController < ApplicationController
  before_action :set_loan, only: [:index]


  def index
    render json: {data: @loan.installments}
  end

  private
  def set_loan
    @loan = Loan.find(params[:loan_id])
  end

end
