class Booking < ActiveRecord::Base
    validates :user_id, :gig_id, presence: true

    belongs_to :user
    belongs_to :gig
end
