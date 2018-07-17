class IdeasController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]


    def index
        @ideas = Idea.order(created_at: :desc)
    end

    def new
        @idea = Idea.new
    end

    def create

        @idea =  Idea.new idea_params 
        @idea.user = current_user
        if @idea.save
            flash[:success] = "Idea created!"
            redirect_to idea_path(@idea.id)
        else
            render :new
        end
    end

    def show
        
        #  @idea = Idea.find params[:id]
         @review = Review.new
         @reviews = @idea.reviews.order(created_at: :desc) # Creating the instance of review
    end

    def destroy
        # @idea = Idea.find params[:id]
        @idea.destroy
        redirect_to ideas_path
    end

    def edit
        # @idea = Idea.find params[:id]
    end

    def update
        # @idea = Idea.find params[:id]

        if @idea.update(idea_params)
        redirect_to idea_path(@idea.id)
        else
        render :edit
        end
    end

    private

    def find_idea
        @idea = Idea.find params[:id]
    end

    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def authorize_user!
        unless can?(:manage, @idea)
          flash[:danger] = "Access Denied"
          redirect_to idea_path(@idea) # Idea show page 
        end
    end

end
