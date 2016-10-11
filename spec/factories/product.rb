FactoryGirl.define do
  factory :product do
    asin { Faker::Number.number(10) }
    user

    trait :with_seach_terms do
      after(:create) do |instance|
        create_list :search_term, 5, product: instance
      end
    end

    trait :with_data do
      after(:create) do |instance|
        create_list :search_term_with_data, 5, product: instance
      end
    end

    factory :product_with_seach_terms, traits: [:with_data]
    factory :product_with_data, traits: [:with_data]
  end
end
