require 'rails_helper'

RSpec.describe "Drawers", type: :request do
  before do
    @drawer = Drawer.create(title: "Title One", description: "Description of drawer one")
  end

  describe 'GET /drawers/:id' do
    context 'with existing drawer' do
      before { get "/drawers/#{@drawer.id}" }

      it "handles existing drawer" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing drawer' do
      before { get "/drawers/XXX" }

      it "handles non-existing drawer" do
        expect(response.status).to eq 302
        flash_message = "The drawer you are looking for could not be found"
        expect(flash[:warning]).to eq flash_message
      end
    end

  end
end
