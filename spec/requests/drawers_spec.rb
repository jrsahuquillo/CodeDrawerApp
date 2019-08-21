require 'rails_helper'

RSpec.describe "Drawers", type: :request do
  before do
    @user1 = User.create(email: "example_user1@example.com", password: "password")
    @user2 = User.create(email: "example_user2@example.com", password: "password")
    @drawer1 = Drawer.create!(title: "Title One", description: "Description of drawer one", user: @user1)
    @drawer2 = Drawer.create!(title: "Title One", description: "Description of drawer one", user: @user2)
  end

  describe 'GET /drawers/:id' do
    context 'with existing drawer' do
      before do
        login_as(@user1)
        get "/drawers/#{@drawer1.id}"
      end

      it "handles existing drawer" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing drawer' do
      before do
        login_as(@user1)
        get "/drawers/xxx"
      end

      it "handles non-existing drawer" do
        expect(response.status).to eq 302
        flash_message = "The drawer you are looking for could not be found"
        expect(flash[:warning]).to eq flash_message
      end
    end
  end

  describe 'GET /drawers/:id/edit' do
    context 'with non-signed in user' do
      before do
        get "/drawers/#{@drawer2.id}/edit"
      end

      it "redirects to sign in page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@user2)
        get "/drawers/#{@drawer1.id}/edit"
      end

      it "redirects to the home page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own drawer."
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user as owner gets successful destroy' do
      before do
        login_as(@user1)
        get "/drawers/#{@drawer1.id}/edit"
      end

      it "successfully edits drawer" do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /drawers/:id/destroy' do
    context 'with non-signed in user' do
      before do
        delete "/drawers/#{@drawer2.id}"
      end

      it "redirects to sign in page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@user2)
        delete "/drawers/#{@drawer1.id}"
      end

      it "displays alert message" do
        expect(response.status).to eq 302
        flash_message = "You can only delete your own drawer."
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user as owner deletes' do
      before do
        login_as(@user1)
        delete "/drawers/#{@drawer1.id}"
      end

      it "redirects to the home page" do
        expect(response.status).to eq 302
      end
    end
  end

end
