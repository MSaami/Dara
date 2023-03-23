FactoryBot.define do
  factory :wallet do
    name { Faker::Name.name }
    balance { Faker::Number.number(digits: 6)}
  end
end
