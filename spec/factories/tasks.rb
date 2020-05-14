FactoryBot.define do
  factory :task do
    name { "MyString" }
    is_done { false }

    trait :invalid do
      name nil
    end
  end
end
