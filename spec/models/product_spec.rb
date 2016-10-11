require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to have_many(:search_terms).dependent(:destroy) }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:asin)}
  it { is_expected.to validate_presence_of(:user)}
  it { is_expected.to validate_length_of(:asin).is_equal_to(10) }
end
