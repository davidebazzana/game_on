require 'rails_helper'

RSpec.describe "FavoriteGames", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/favorite_games/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/favorite_games/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
