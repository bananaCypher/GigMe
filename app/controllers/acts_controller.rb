class ActsController < ApplicationController
    def index
        @acts = Act.all
    end

    def new
        @act = Act.new
    end

    def create
        act = Act.new(act_params)
        keywords = params[:act][:keywords]
        keywords.delete_at(0)
        act.keywords << keywords.map {|k| Keyword.find(k)}
        if act.valid?
            act.save
        else
            raise ArgumentError.new("Failed to create Act: " + act.errors.full_messages.join(", ")) 
        end
        redirect_to acts_path
    end

    def show
        @act = Act.find(params[:id])
        @booking = Booking.new
    end

    def edit
        @act = Act.find(params[:id])
    end

    def update
        act = Act.find(params[:id])
        act.update(act_params)
        keywords = params[:act][:keywords]
        keywords.delete_at(0)
        act.keywords.clear
        act.keywords << keywords.map {|k| Keyword.find(k)}
        if act.valid?
            act.save
        else
            raise ArgumentError.new("Failed to update Act: " + act.errors.full_messages.join(", ")) 
        end
        redirect_to act_path(act)
    end

    def destroy
        act = Act.find(params[:id])
        act.destroy
        redirect_to acts_path
    end

    private
    def act_params
        params.require(:act).permit(:name, :description, :image)
    end
end
