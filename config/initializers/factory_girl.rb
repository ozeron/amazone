if Rails.env.development? || Rails.env.test?
  FactoryGirl.find_definitions
end
