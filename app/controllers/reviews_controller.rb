class ReviewsController < ApplicationController
    def new
        @review = Review.new(gig_id: params['gig_id'])
    end

    def create
        review = Review.new(review_params)
        review.user_id = current_user.id
        if review.valid?
            review.save
        else
            redirect_to new_review_path, alert: ("Failed to create Review: " + review.errors.full_messages.join(", "))
            return
        end
        redirect_to gig_path(Gig.find(review.gig_id))
    end

    private
    def review_params
        params.require(:review).permit(:gig_id, :rating, :content)
    end
end
