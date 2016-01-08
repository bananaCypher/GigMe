class Venue < ActiveRecord::Base
  has_many :gigs
  has_many :acts, through: :gigs
end
