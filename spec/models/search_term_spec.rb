require 'rails_helper'

RSpec.describe SearchTerm, type: :model do
  it { is_expected.to have_many(:ranks).dependent(:destroy) }
  it { is_expected.to belong_to :product }
  it { is_expected.to validate_presence_of(:product) }


end
