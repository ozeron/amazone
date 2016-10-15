class Product < ActiveRecord::Base
  belongs_to :user
  has_many :search_terms, dependent: :destroy

  validates :asin, presence: true, length: { minimum: 10 }
  validates :user, presence: true

  def name
    metadata.fetch('title')
  end
end
