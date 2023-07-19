class Loan < ApplicationRecord
  belongs_to :wallet
  has_many :installments

  def increase_number_of_paid
    if number_of_paid < number_of_installment
      increment!(:number_of_paid)
    end
  end
end
