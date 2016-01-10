class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :gig

    validates :user_id, :gig_id, :rating, presence: true
    validates :rating, numericality: {greater_than: 0, less_than: 6}
    validates :content, length: {in: 2..2000}
end
