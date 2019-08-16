require 'rails_helper'

RSpec.describe DrawersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      assert_response :success
    end
  end

end
