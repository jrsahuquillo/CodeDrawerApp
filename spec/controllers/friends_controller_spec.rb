require 'rails_helper'

RSpec.describe FriendsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :search_friends
      expect(response).to have_http_status(:success)
    end
  end

end
