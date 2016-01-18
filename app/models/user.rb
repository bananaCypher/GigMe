class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
    after_create :send_welcome_email

    has_many :bookings
    has_many :gigs, through: :bookings
    has_many :reviews

    def role?(role_to_check)
        self.role.to_s == role_to_check.to_s
    end

    def booking_warnings(gig)
        message = ""
        if booked_gig? gig
            message = message + "You already have a ticket for this gig. "
        end
        if is_double_booking? gig
            message = message + "You already have a ticket for another gig that clashes with this one. "
        end
        {confirm: message + "Are you sure you want to book this ticket?"}
    end

    def booked_gig?(gig)
        self.bookings.where(gig_id: gig.id).count > 0
    end

    def is_double_booking?(gig)
        self.bookings.detect {|b| gig.start_time >= b.gig.start_time and gig.start_time <= b.gig.end_time and b.gig != gig}
    end

    def cart_items
        self.bookings.where(status: 'unpaid')
    end
    
    def cart_total
        self.cart_items.inject(0){|sum, i| sum += i.gig.price}
    end

    def paid_bookings
        self.bookings.where(status: 'paid')
    end

    def send_welcome_email
        UserMailer.welcome_email(self).deliver
    end
end
