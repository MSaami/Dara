class Loan < ApplicationRecord
  belongs_to :wallet
  has_many :installments, :dependent => :destroy

  def increase_number_of_paid(amount)
    if number_of_paid.to_i < number_of_installment.to_i
      increment!(:number_of_paid)
      wallet.update_balance_by(-amount)
    end
  end

  def remove_installment
    if(number_of_paid == number_of_installment)
      increment!(:number_of_paid, -1)
    end
    increment!(:number_of_installment, -1)
  end
end
