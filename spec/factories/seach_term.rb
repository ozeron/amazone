FactoryGirl.define do
  factory :search_term do
    term { Faker::Lorem.sentence(2, false, 1) }
    product

    trait :with_ranks do
      after(:create) do |instance|
        create_list :rank, 5, search_term: instance
      end
    end

    trait :with_data do
      with_ranks
    end

    factory :search_term_with_data, traits: [:with_data]
  end
end
