require 'spec_helper'

RSpec.describe Game, type: :model do
  before(:all) {
    titles = ["Pet 'em all",
              "Cats island",
              "Dogcatcher simulator",
              "Sleeping cat"]
    
    FactoryBot.create(:user)
    FactoryBot.create(:game)
    titles.each do |title|
      FactoryBot.create(:game, :title => title)
    end
  }
  
  it "Search for all the games with 'cat' in their name" do
    search_game_params = {:title => "cat", :category => "Any", :sorting_criterion => "Any"}
    search_result = Game.search(search_game_params)
    res = Array.new()
    search_result.each{|entry| res.append(entry[:title])}
    expect(res).to eq(["Cats island", "Dogcatcher simulator", "Sleeping cat"])
  end
end
