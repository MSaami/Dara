FactoryBot.define do
  factory :installment do
    due_date { (Date.today + 1.month).to_s }
    amount { 1000 }
    loan { Loan.first || create(:loan) }
    status { 1 }
  end
end
