class BookingsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
        @bookings = current_user.upcoming_bookings.includes(:gig).order("gigs.start_time")
        @past_bookings = current_user.passed_bookings.includes(:gig).order("gigs.start_time")
        @bookings = Booking.group_bookings(current_user.upcoming_bookings.includes(:gig).order("gigs.start_time"))
        @past_bookings = Booking.group_bookings(current_user.passed_bookings.includes(:gig).order("gigs.start_time"))
    end

    def new
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
        @items = Booking.group_bookings(current_user.cart_items)
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
        UserMailer.reciept_email(current_user, items, amount.to_f / 100).deliver
        redirect_to bookings_path
    end

    def calendar
        if params['month'] and params['year']
            @month_date = Time.new(params['year'], params['month'], 1)
        else
            @month_date = Time.now
        end

    
        last_month = @month_date - 1.months
        @last_month = last_month.month
        @last_year = last_month.year

        next_month = @month_date + 1.months
        @next_month = next_month.month
        @next_year = next_month.year

        @events = current_user.bookings
        @month_name = I18n.t("date.month_names")[@month_date.month]
        month_days = Time.days_in_month(@month_date.month, @month_date.year)
        first_day = @month_date.beginning_of_month.strftime("%A")
        case first_day
            when 'Monday'
                offset = 0
            when 'Tuesday'
                offset = 1
            when 'Wednesday'
                offset = 2
            when 'Thursday'
                offset = 3
            when 'Friday'
                offset = 4
            when 'Saturday'
                offset = 5
            when 'Sunday'
                offset = 6
        end
        @month_array = []
        offset.times do 
            @month_array.push(nil)
        end
        month_days.times do |day|
            @month_array.push(Time.new(@month_date.year, @month_date.month, day + 1))
        end
    end

    
    private
    def booking_params
        params.require(:booking).permit(:gig_id)
    end
end
