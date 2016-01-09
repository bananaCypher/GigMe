class BookingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @bookings = current_user.bookings
  end

  def show
    @booking = Booking.find(params[:id])
  end

  # def new
  #   @booking = Booking.new
  # end

  def create
    booking = Booking.new(booking_params)
    booking.user = current_user
    booking.save
    redirect_to bookings_path
  end

  # def edit
  #   @booking = Booking.find(params[:id])
  # end

  # def update
  #   booking = Booking.find(params[:id])
  #   booking.update(booking_params)
  #   redirect_to booking_path(booking)
  # end

  def destroy
    booking = Booking.find(params[:id])
    booking.destroy
    redirect_to bookings_path
  end

  private
  def booking_params
    params.require(:booking).permit(:gig_id)
  end
end