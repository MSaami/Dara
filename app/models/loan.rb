class Loan < ApplicationRecord
  belongs_to :wallet
  has_many :installments

  def increase_number_of_paid(amount)
    if number_of_paid.to_i < number_of_installment.to_i
      increment!(:number_of_paid)
      wallet.update_balance_by(-amount)
    end
  end
end
