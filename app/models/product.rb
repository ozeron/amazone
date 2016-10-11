class Product < ActiveRecord::Base
  belongs_to :user
  has_many :search_terms, dependent: :destroy

  validates :asin, presence: true, length: { is: 10 }
  validates :user, presence: true
end
