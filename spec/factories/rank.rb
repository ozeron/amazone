FactoryGirl.define do
  factory :rank do
    search_term
    sequence(:date, 1.years.ago.to_date) { |d| d + 1.day }
    data { { time: date.to_time.to_i, position: Faker::Number.number(4) } }
  end
end
