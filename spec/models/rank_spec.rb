require 'rails_helper'

RSpec.describe Rank, type: :model do
  it { is_expected.to belong_to :search_term }
  it { is_expected.to validate_presence_of(:search_term) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:data) }
end
