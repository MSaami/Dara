FactoryBot.define do
  factory :wallet_transaction do
    category {Category.first || create(:category)}
    wallet
    amount {Faker::Number.within(range: -99999...999999 )}
    description {Faker::Lorem.sentence(word_count: 3)}
  end
end
