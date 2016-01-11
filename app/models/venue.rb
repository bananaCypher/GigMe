class Venue < ActiveRecord::Base
    validates :name, :location, :capacity, presence: true
    validates :name, :location, length: { in: 2..200 }
    validates :capacity, numericality: {greater_than_or_equal_to: 0}

    has_many :gigs
    has_many :acts, through: :gigs
end
