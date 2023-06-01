FactoryBot.define do
  factory :budget do
    wallet { Wallet.first || create(:wallet) }
    month { Faker::Number.within(range: 1..12) }
    year { 1402 }
    category_id { Category::ids.sample || create(:category).id }
    amount { Faker::Number.within(range: 1000...999999 ) }
  end
end
