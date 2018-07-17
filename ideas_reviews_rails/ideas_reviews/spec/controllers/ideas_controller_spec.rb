require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    let(:current_user) { FactoryBot.create :user }
    let(:idea) { FactoryBot.create :idea }
    let(:current_users_idea) do 
        FactoryBot.create(:idea, user: current_user)
    end


    describe "#new" do
        context "with no user signed in" do
            it "redirects to the sign up page" do
                get :new
        
                expect(response).to redirect_to new_user_path
            end
        end

        context "with user signed in" do
            before do
                session[:user_id] = current_user.id
            end
            it "renders the new template" do
                
                get :new
                expect(response).to render_template(:new)
            end
        
            it "sets an instance variable with a new idea" do
                    get :new
                    expect(assigns(:idea)).to be_a_new(Idea)
            end
        end
    

    end

    describe "#create" do

        def valid_request
            post :create, params: {
                idea: FactoryBot.attributes_for(:idea)
            }
        end
        context "with no user signed in" do
            
            it "redirects to the sign up page" do
            valid_request

            expect(response).to redirect_to new_user_path
            end
        end

        context "with user signed in" do
            before do
            session[:user_id] = current_user.id
            end

            context "with valid parameters" do
                def valid_request
                    post :create, params: {
                    idea: FactoryBot.attributes_for(:idea)
                    }
                end

                it "creates a new idea in the db" do
                    # Given: An empty database
                    count_before = Idea.count #It should be zero as it has to be cleaned up always.

                    # When: A valid idea is made to create
                    valid_request

                    # Then: There is one more idea in the db
                    count_after = Idea.count
                    expect(count_after).to eq(count_before + 1)
                end
            
        

                it "redirects to the show page of that idea" do
                    valid_request

                    expect(response).to redirect_to(idea_path(Idea.last))
                end

                it "associates the idea with the signed in user" do
                    valid_request
                    expect(Idea.last.user).to eq(current_user)
                end

                it "sets a flash success" do
                    valid_request

                    expect(flash[:success]).to be
            
                end

            end
        end

    end





end
