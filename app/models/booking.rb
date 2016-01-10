class Booking < ActiveRecord::Base
  validates :user_id, :gig_id, presence: true

  belongs_to :user
  belongs_to :gig

  def self.user_booked_gig?(user, gig)
    user ||= User.new
    Booking.where(gig_id: gig.id, user_id: user.id).count > 0
  end
  def self.is_double_booking?(user, gig)
    user ||= User.new
    overbook = user.bookings.detect {|b| gig.start_time >= b.gig.start_time and gig.start_time <= b.gig.end_time }
    return true if overbook
  end
end
