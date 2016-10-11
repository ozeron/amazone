class SearchTerm < ActiveRecord::Base
  belongs_to :product
  has_many :ranks, dependent: :destroy

  validates :product, presence: true
end
