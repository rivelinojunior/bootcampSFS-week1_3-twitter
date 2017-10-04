require 'rails_helper'

RSpec.describe TweetsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "get assigns a new Tweet do @tweet" do
      get :new
      Tweet.should_receive(:new).and_return(Tweet.new)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end


#
# require 'rails_helper'
# require 'spec_helper'
#
#
# RSpec.describe TweetsController, :type => :controller do
#   describe "GET #new" do
#     it "assigns a new Tweet to @tweet" do
#       get :new
#       Tweet.should_receive(:new).and_return(Article.new)
#     end
#     # it "renders the :new template" do
#     #    get :new
#     #    response.should render_template :new
#     # end
#   end
#   # describe "creates a tweet" do
#   #     it "saves the new contact in the database"
#   #     it "redirects to the home page"
#   # end
# end
