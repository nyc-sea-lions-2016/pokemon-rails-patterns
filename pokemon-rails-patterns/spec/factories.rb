FactoryGirl.define do
  factory :pokemon do
    name Faker::Name.first_name
    type { Pokemon::TYPES.sample }
  end
end
