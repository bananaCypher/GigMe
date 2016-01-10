class GigsController < ApplicationController
  load_and_authorize_resource
  
  def index
    #@gigs = Gig.all
    @gigs = Gig.all.upcoming.order(start_time: :asc)
    @booking = Booking.new
  end

  def show
    @gig = Gig.find(params[:id])
    @booking = Booking.new
  end

  def new
    @gig = Gig.new
  end

  def create
    gig = Gig.create(gig_params)
    redirect_to gig_path(gig)
  end

  def edit
    @gig = Gig.find(params[:id])
  end

  def update
    gig = Gig.find(params[:id])
    gig.update(gig_params)
    redirect_to gig_path(gig)
  end

  def destroy
    gig = Gig.find(params[:id])
    gig.destroy
    redirect_to gigs_path
  end

  def search
    @gigs = Gig.search(params[:term])
    @booking = Booking.new
    render 'index'
  end

  private
  def gig_params
    params.require(:gig).permit(:price, :start_time, :end_time, :capacity, :act_id, :venue_id)
  end
end
