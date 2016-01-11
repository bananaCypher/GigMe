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
        if !gig.valid?
            redirect_to new_gig_path, alert: ("Failed to create Gig: " + gig.errors.full_messages.join(", "))
            return
        end
        potential_clashes = gig.venue.gigs
        potential_clashes.each do |g|
            if gig.start_time >= g.start_time and gig.start_time <= g.end_time
                redirect_to new_gig_path, alert: ("Failed to create Gig: The start time clashes with another gig at this venue")
                return
            end
        end
        gig.save
        redirect_to gig_path(gig)
    end

    def edit
        @gig = Gig.find(params[:id])
    end

    def update
        gig = Gig.find(params[:id])
        gig.update(gig_params)
        if !gig.valid?
            redirect_to edit_gig_path(gig), alert: ("Failed to create Gig: " + gig.errors.full_messages.join(", "))
            return
        end
        potential_clashes = gig.venue.gigs
        potential_clashes.each do |g|
            if gig.start_time >= g.start_time and gig.start_time <= g.end_time and g != gig
                redirect_to edit_gig_path(edit), alert: ("Failed to update Gig: The start time clashes with another gig at this venue")
                return
            end
        end
        gig.save
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
