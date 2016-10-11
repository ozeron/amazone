class Rank < ActiveRecord::Base
  belongs_to :search_term
  validates :search_term, presence: true
  validates :date, presence: true
  validates :data, presence: true
end
