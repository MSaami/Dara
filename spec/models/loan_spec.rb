require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe "increase_number_of_paid" do
    it 'update number of paid of loan and update wallet balance' do
      loan = create(:loan, number_of_paid: 0)
      installments = create_list(:installment, 10, loan: loan, amount: 2000)
      expect {
        loan.increase_number_of_paid(2000)
      }.to change { loan.wallet.balance }.by(-2000)
    end

    it 'not update if number of paid equal to installment count' do
      loan = create(:loan, number_of_paid: 10, number_of_installment: 10)
      installments = create_list(:installment, 11, loan: loan)
      expect {
        loan.increase_number_of_paid(2000)
      }.not_to change {loan.wallet.balance}
    end
  end
end
