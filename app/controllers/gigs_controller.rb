class GigsController < ApplicationController
  def index
    @gigs = Gig.all
  end

  def show
    @gig = Gig.find(params[:id])
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

  private
  def gig_params
    params.require(:gig).permit(:price, :start_time, :end_time, :capacity, :act_id, :venue_id)
  end
end