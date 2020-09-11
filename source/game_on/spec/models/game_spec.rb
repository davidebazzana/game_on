require 'spec_helper'

RSpec.describe Game, type: :model do
  describe ".search" do
    context "There are some games in the list" do
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

      it "Search for all the games with 'cat' in their name" do
        search_game_params = {:title => "cat", :category => "Any", :sorting_criterion => "Any"}
        search_result = Game.search(search_game_params)
        res = Array.new()
        search_result.each{|entry| res.append(entry[:title])}
        expect(res).to eq(["Cats island", "Dogcatcher simulator", "Sleeping cat", "Cat race", "Purring cat"])
      end

      it "Search for all the games with category 'Casual'" do
        search_game_params = {:title => "", :category => "Casual", :sorting_criterion => "Any"}
        search_result = Game.search(search_game_params)
        res = Array.new()
        search_result.each{|entry| res.append(entry[:title])}
        expect(res).to eq(["Purring cat", "Mreow"])
      end

      it "Search for all the games with 'cat' in their name and category 'Casual'" do
        search_game_params = {:title => "cat", :category => "Casual", :sorting_criterion => "Any"}
        search_result = Game.search(search_game_params)
        res = Array.new()
        search_result.each{|entry| res.append(entry[:title])}
        expect(res).to eq(["Purring cat"])
      end
    end
  end
end
