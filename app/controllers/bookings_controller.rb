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
        booking = Booking.new(booking_params)
        if !booking.gig.full?
            booking.user = current_user
            booking.status = 'unpaid'
            if booking.valid?
                booking.save
                #@amount = (booking.gig.price * 100).to_i

                #customer = Stripe::Customer.create(
                #    :email => params[:stripeEmail],
                #    :source  => params[:stripeToken]
                #)

                #charge = Stripe::Charge.create(
                #    :customer    => customer.id,
                #    :amount      => @amount,
                #    :description => 'Rails Stripe customer',
                #    :currency    => 'gbp'
                #)
            else
                redirect_to root_path, alert: ("Failed to create Booking: " + booking.errors.full_messages.join(", "))
                return
            end
            redirect_to cart_path
        else 
            raise ArgumentError.new('Unfortunatley that gig is fully booked.') 
        end
    end

    def destroy
        booking = Booking.find(params[:id])
        booking.destroy
        redirect_to bookings_path
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
