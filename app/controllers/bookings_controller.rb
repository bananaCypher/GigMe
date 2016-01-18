class BookingsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
        @bookings = current_user.paid_bookings
    end

    def show
        @booking = Booking.find(params[:id])
    end

    def new
       @booking = Booking.new
       @booking.gig_id = params[:gig_id]
    end

    def create
        tickets = params['booking'][:tickets].to_i
        if Gig.find(params['booking'][:gig_id]).available_spaces < tickets
            redirect_to root_path, alert: ("Failed to create Booking: Unfortunatley there aren't enough tickets left.")
            return
        end
        tickets.times do
            booking = Booking.new(booking_params)
            booking.user = current_user
            booking.status = 'unpaid'
            if booking.valid?
                booking.save
            end
        end
        redirect_to cart_path
    end

    def destroy
        booking = Booking.find(params[:id])
        booking.destroy
        redirect_to cart_path
    end

    def cart
        @items = current_user.cart_items
    end

    def checkout
        items = current_user.cart_items
        amount = (current_user.cart_total * 100).to_i

        customer = Stripe::Customer.create(
            :email => params[:stripeEmail],
            :source  => params[:stripeToken]
        )

        charge = Stripe::Charge.create(
            :customer    => customer.id,
            :amount      => amount,
            :description => 'Rails Stripe customer',
            :currency    => 'gbp'
        )
        items.each {|item| item.update(status: 'paid')}
        redirect_to bookings_path
    end

    private
    def booking_params
        params.require(:booking).permit(:gig_id)
    end
end
