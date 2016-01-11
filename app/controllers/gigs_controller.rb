class GigsController < ApplicationController
    load_and_authorize_resource

    def index
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
        gig = Gig.new(gig_params)
        potential_clashes = gig.venue.gigs
        potential_clashes.each do |g|
            if gig.start_time >= g.start_time and gig.end_time <= g.end_time
                raise ArgumentError.new("Failed to create Gig: Another gig is already scheduled at this venue for that time.")
            end
        end
        if gig.valid?
            gig.save
        else
            raise ArgumentError.new("Failed to create Gig: " + gig.errors.full_messages.join(", ")) 
        end
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
