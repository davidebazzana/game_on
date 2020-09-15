games = [{:title => "Pet 'em all", :category => "Other"},
         {:title => "Cats island", :category => "Other"},
         {:title => "Dogcatcher simulator", :category => "Other"},
         {:title => "Sleeping cat", :category => "Other"},
         {:title => "Cat race", :category => "Racing"},
         {:title => "Purring cat", :category => "Casual"},
         {:title => "Mreow", :category => "Casual"}]

Given("the game {string} exists") do |game_title|
  create(:user)
  create(:game, title: game_title)
end

Then("I should be on {string}'s page") do |game_title|
  expect(current_url).to eq("http://www.example.com/games/#{Game.where(:title => game_title)[0][:id]}")
end

Then("I should see {string}'s infos") do |game_title|
  expect(page).to have_content(Game.where(:title => game_title)[0][:info])
end

When("I change the title of the game to {string}") do |new_title|
  fill_in 'Title', :with => new_title
end

Given("I am the owner of the game {string}") do |game_title|
  create(:game, title: game_title, user_id: User.find_by_email(@test_user_email)[:id])
end

Given("I am the owner of the game {string} with info {string}") do |game_title, info|
  create(:game, title: game_title, user_id: User.find_by_email(@test_user_email)[:id], info: info)
end

Given("there are many games uploaded") do
  FactoryBot.create(:user)
  FactoryBot.create(:game)
  games.each do |game|
    FactoryBot.create(:game, :title => game[:title], :category => game[:category])
  end
end

Given("there are no games uploaded") do
  expect(Game.all).to be_empty
end

Given("I type {string} in the search area") do |input|
  fill_in 'game_title', :with => input
end

Then("I should only see the games with the word {string} in their name") do |title|
  check_games games, title, nil
end

Given("I choose {string} as category") do |category|
  select(category)
end

Then("I should only see the games with category {string}") do |category|
  check_games games, nil, category
end


Then("I should only see the games with the word {string} in their name and with category {string}") do |title, category|
  check_games games, title, category
end

Then("there should be no game in the list") do
  games.each do |game|
    expect(page).to have_no_content(game[:title])
  end
end

private

def check_games games, title, category
  test_positive_array = Array.new()
  test_negative_array = Array.new()
  games.each do |entry|
    wanted = false
    if title.nil?
      wanted = entry[:category].include?(category)
    elsif category.nil?
      wanted = entry[:title].downcase().include?(title)
    else
      wanted = entry[:category].include?(category) && entry[:title].downcase().include?(title)
    end
    if wanted
      test_positive_array.append(entry[:title])
    else
      test_negative_array.append(entry[:title])
    end
  end
  test_positive_array.each{|game_title| expect(page).to have_content(game_title)}
  test_negative_array.each{|game_title| expect(page).to have_no_content(game_title)}
end
