require 'rails_helper'


RSpec.describe DrawersController, type: :controller do

  describe "GET #index" do
    it "returns http redirection" do
      get :index

      expect(response.code).to eq("302")
      expect(response.body).to have_content("You are being redirected.")
    end
  end

end
