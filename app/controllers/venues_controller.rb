class VenuesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @venues = Venue.all
  end

  def new
    @venue = Venue.new
  end

  def create
    venue = Venue.new(venue_params)
    if venue.valid?
      venue.save
    else
      raise ArgumentError.new("Failed to create Venue: " + venue.errors.full_messages.join(", ")) 
    end
    redirect_to venues_path
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    venue = Venue.find(params[:id])
    venue.update(venue_params)
    redirect_to venue_path(venue)
  end

  def destroy
    venue = Venue.find(params[:id])
    venue.destroy
    redirect_to venues_path
  end

  private
  def venue_params
    params.require(:venue).permit(:name, :location, :capacity)
  end
end