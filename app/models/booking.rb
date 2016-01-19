class Booking < ActiveRecord::Base
    validates :user_id, :gig_id, presence: true

    belongs_to :user
    belongs_to :gig

    def self.group_bookings(bookings)
        return_bookings = {}
        bookings.each do |booking|
            if return_bookings.has_key?(booking.gig_id)
                return_bookings[booking.gig_id].push(booking)
            else
                return_bookings[booking.gig_id] = [booking]
            end
        end
        return return_bookings
    end
end
