class Installment < ApplicationRecord
  belongs_to :loan

  enum status: {unpaid: 0, paid: 1}
end
