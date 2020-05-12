Given("the game {string} exists") do |game_title|
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
  click_button("Commit updates")
end

Then("I should see the game's title changed to {string}, not {string} anymore") do |new_title, old_title|
  expect(page).to have_content(new_title)
  expect(page).to have_no_content(old_title)
end

Given("I am the owner of the game {string}") do |game_title|
  create(:game, title: game_title, user_id: @test_user[:id])
end
