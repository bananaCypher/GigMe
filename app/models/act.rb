class Act < ActiveRecord::Base
    validates :name, presence: true, length: { in: 2..200 }
    validates :description, length: { in: 2..1000 }
    validates :image, length: { in: 2..500 }

    has_many :gigs
    has_many :venues, through: :gigs
    has_and_belongs_to_many :keywords, uniq: true
    has_many :reviews, through: :gigs

    def average_rating
        return 0 if self.reviews.count == 0
        self.reviews.inject(0) {|sum, review| sum += review.rating} / self.reviews.count
    end

    def avg_rating_stars_range
        (1..self.average_rating)
    end

    def avg_rating_no_stars_range
        (1..(5 - self.average_rating)) 
    end
end
