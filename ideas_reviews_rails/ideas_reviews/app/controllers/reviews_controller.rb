class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user!, only: [:destroy]

    def create
        @idea = Idea.find params[:idea_id] # Finding the particular product. Product_id will come from the url
        @review = Review.new review_params # Will create the review instance with all the information entered by the user
        @review.idea = @idea # Associating review with product
        @review.user = current_user
    
        if @review.save
          redirect_to idea_path(@idea) # redirecting to idea show path
        else
          @reviews = @idea.reviews.order(created_at: :desc) # Creating the new instance so that all the information remain populated as we dont need to go to products show action again
          render "ideas/show"
        end
    end

    def destroy
        @review = Review.find params[:id]
        @review.destroy
    
        redirect_to idea_path(@review.idea) # Although answer is destroyed but still we can get associated question untill answer gets out of scope i.e asoociation still remains .
    end

    # def show
    #   @review = Review.find params[:id]
    #   @review.update(hidden: !@review.hidden)
    #   redirect_to product_path(@review.product) # product show page
    # end

    private
    def review_params
      params.require(:review).permit(:description)
    end

    def authorize_user!
      @review = Review.find params[:id]
  
      unless can?(:manage, @review)
        flash[:danger] = "Access Denied!"
        redirect_to idea_path(@review.idea) # idea show page
      end
    end
end
