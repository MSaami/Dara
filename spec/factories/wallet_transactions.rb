FactoryBot.use_parent_strategy = false
FactoryBot.define do
  factory :wallet_transaction do
    category {Category.first || create(:category)}
    wallet
    amount {Faker::Number.within(range: -99999...999999 )}
    description {Faker::Lorem.sentence(word_count: 3)}
    at_date {Date.today.to_s}
  end
end
