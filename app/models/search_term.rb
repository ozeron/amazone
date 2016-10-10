class SearchTerm < ActiveRecord::Base
  belongs_to :product
  has_many :ranks
end
