FactoryBot.define do
  factory :loan do
    number_of_installment { 10 }
    title { "My First Loan" }
    amount { 15000 }
    number_of_paid { 5 }
    wallet {Wallet.first || create(:wallet)}
  end
end
