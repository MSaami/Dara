class Installment < ApplicationRecord
  belongs_to :loan

  enum status: {unpaid: 0, paid: 1}

  def pay!
    paid!
    loan.increase_number_of_paid(amount)
  end

end
