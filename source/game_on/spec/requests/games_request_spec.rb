require 'spec_helper'

RSpec.describe "Games", type: :request do
  games = [{:title => "Pet em all", :category => "Other"},
           {:title => "Cats island", :category => "Other"},
           {:title => "Dogcatcher simulator", :category => "Other"},
           {:title => "Sleeping cat", :category => "Other"},
           {:title => "Cat race", :category => "Racing"},
           {:title => "Purring cat", :category => "Casual"},
           {:title => "Mreow", :category => "Casual"}]

  all_games = Array.new()
  cats_games = Array.new()
  casual_games = Array.new()
  casual_cats_games = Array.new()
  
  FactoryBot.create(:user, :username => "Thelonious", :email => "thelonious@email.com")
  games.each do |game|
    new_game = FactoryBot.create(:game, :title => game[:title], :category => game[:category])
    all_games.append(new_game)
    if(game[:title].downcase().include?("cat"))
      cats_games.append(new_game)
    end
    if(game[:category].include?("Casual"))
      casual_games.append(new_game)
    end      
    if(game[:title].downcase().include?("cat") && game[:category].include?("Casual"))
      casual_cats_games.append(new_game)
    end
  end

  describe "Search by name" do
    it "Search for all the games with 'cat' in their name" do
      allow(Game).to receive(:search).and_return(cats_games)
      get '/games', :params => {:game => {:title => "cat", :category => "Any", :sort_criterion => "Any"}}
      expect(response).to be_successful
      expect(response).to have_http_status(:success)
      cats_games.each do |game|
        expect(response.body).to include(game[:title])
      end
    end
  end

  describe "Search by category" do
    it "Search for all the games with category 'Casual'" do
      allow(Game).to receive(:search).and_return(casual_games)
      get '/games', :params => {:game => {:title => "", :category => "Casual", :sort_criterion => "Any"}}
      expect(response).to be_successful
      expect(response).to have_http_status(:success)
      casual_games.each do |game|
        expect(response.body).to include(game[:title])
      end
    end
  end

  describe "Search by name and category" do
    it "Search for all the games" do
      allow(Game).to receive(:search).and_return(all_games)
      get '/games', :params => {:game => {:title => "", :category => "Any", :sort_criterion => "Any"}}
      expect(response).to be_successful
      expect(response).to have_http_status(:success)
      all_games.each do |game|
        expect(response.body).to include(game[:title])
      end
    end
    
    it "Search for all the games with 'cat' in their name and with category 'Casual'" do
      allow(Game).to receive(:search).and_return(casual_cats_games)
      get '/games', :params => {:game => {:title => "cat", :category => "Casual", :sort_criterion => "Any"}}
      expect(response).to be_successful
      expect(response).to have_http_status(:success)
      casual_cats_games.each do |game|
        expect(response.body).to include(game[:title])
      end
    end
  end
end
