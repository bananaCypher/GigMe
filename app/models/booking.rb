class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :gig

  def self.user_booked_gig?(user, gig)
    user ||= User.new
    Booking.where(gig_id: gig.id, user_id: user.id).count > 0
  end
end
