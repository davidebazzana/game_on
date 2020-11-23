require 'spec_helper'

RSpec.describe Game, type: :model do
  games = [{:title => "Pet 'em all", :category => "Other"},
           {:title => "Cats island", :category => "Other"},
           {:title => "Dogcatcher simulator", :category => "Other"},
           {:title => "Sleeping cat", :category => "Other"},
           {:title => "Cat race", :category => "Racing"},
           {:title => "Purring cat", :category => "Casual"},
           {:title => "Mreow", :category => "Casual"}]
  
  FactoryBot.create(:user, :username => "Abigail", :email => "abigail@email.com")
  games.each do |game|
    FactoryBot.create(:game, :title => game[:title], :category => game[:category])
  end
  
  describe "Search by name" do
    it "Search for all the games with 'cat' in their name" do
      search_game_params = {:title => "cat", :category => "Any", :sorting_criterion => "Any"}
      search_result = Game.search(search_game_params)
      res = Array.new()
      search_result.each{|entry| res.append(entry[:title])}
      expect(res).to eq(["Cats island", "Dogcatcher simulator", "Sleeping cat", "Cat race", "Purring cat"])      
    end

    it "Search for all the games with 'Dog Simulator' in their name" do
      search_game_params = {:title => "Dog Simulator", :category => "Any", :sorting_criterion => "Any"}
      search_result = Game.search(search_game_params)
      res = Array.new()
      search_result.each{|entry| res.append(entry[:title])}
      expect(res).to eq(["Dogcatcher simulator"])
    end

    it "Search for all the games with 'The island of cats' in their name" do
      search_game_params = {:title => "The island of cats", :category => "Any", :sorting_criterion => "Any"}
      search_result = Game.search(search_game_params)
      res = Array.new()
      search_result.each{|entry| res.append(entry[:title])}
      expect(res).to eq(["Cats island"])
    end 
  end

  describe "Search by category" do
    it "Search for all the games with category 'Casual'" do
      search_game_params = {:title => "", :category => "Casual", :sorting_criterion => "Any"}
      search_result = Game.search(search_game_params)
      res = Array.new()
      search_result.each{|entry| res.append(entry[:title])}
      expect(res).to eq(["Purring cat", "Mreow"])
    end

    it "Search for all the games with category 'Other'" do
      search_game_params = {:title => "", :category => "Other", :sorting_criterion => "Any"}
      search_result = Game.search(search_game_params)
      res = Array.new()
      search_result.each{|entry| res.append(entry[:title])}
      expect(res).to eq(["Pet 'em all", "Cats island", "Dogcatcher simulator", "Sleeping cat"])
    end

    it "Search for all the games with category 'Racing'" do
      search_game_params = {:title => "", :category => "Racing", :sorting_criterion => "Any"}
      search_result = Game.search(search_game_params)
      res = Array.new()
      search_result.each{|entry| res.append(entry[:title])}
      expect(res).to eq(["Cat race"])
    end
  end

  describe "Search by name and category" do
    it "Search for all the games with 'cat' in their name and category 'Casual'" do
      search_game_params = {:title => "cat", :category => "Casual", :sorting_criterion => "Any"}
      search_result = Game.search(search_game_params)
      res = Array.new()
      search_result.each{|entry| res.append(entry[:title])}
      expect(res).to eq(["Purring cat"])
    end

    it "Search for all the games with 'cat purr' in their name and category 'Casual'" do
      search_game_params = {:title => "cat purr", :category => "Casual", :sorting_criterion => "Any"}
      search_result = Game.search(search_game_params)
      res = Array.new()
      search_result.each{|entry| res.append(entry[:title])}
      expect(res).to eq(["Purring cat"])
    end   
  end
end
