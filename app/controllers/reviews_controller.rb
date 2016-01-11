class ReviewsController < ApplicationController
    def new
        @review = Review.new
    end

    def create
        review = Review.new(review_params)
        review.user_id = current_user.id
        review.save
        redirect_to gig_path(Gig.find(review.gig_id))
    end

    private
    def review_params
        params.require(:review).permit(:gig_id, :rating, :content)
    end
end
