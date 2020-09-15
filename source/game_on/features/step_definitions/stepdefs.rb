Given("I am on the Game-on home page") do
  visit games_path
end

When("I follow {string}") do |link|
  visit current_url
  click_link(link)
end

Then("I should be on the Game-on home page") do
  expect(current_url).to eq("http://www.example.com/games")
end

When("I click on {string}") do |button|
  click_button(button)
end

Given("I go back to the Game-on home page") do
  visit games_path
end

Then("I should see {string}") do |string|
  expect(page).to have_content(string)
end

When("I fill in {string} with {string}") do |field, content|
  fill_in field, :with => content

  @test_user_email = content if field.eql?("Email")
end
