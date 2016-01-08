class Act < ActiveRecord::Base
  has_many :gigs
  has_many :venues, through: :gigs
  has_and_belongs_to_many :keywords, uniq: true
end
