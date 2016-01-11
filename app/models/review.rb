class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :gig

    validates :user_id, :gig_id, :rating, presence: true
    validates :rating, numericality: {greater_than: 0, less_than: 6}
    validates :content, length: {in: 2..2000}

    def stars_range
        (1..self.rating)
    end

    def no_stars_range
        (1..(5 - rating))
    end
end
