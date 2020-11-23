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

Then("I should see {string}, not {string} anymore") do |new_value, old_value|
  expect(page).to have_content(new_value)
  expect(page).to have_no_content(old_value)
end

When("I fill in {string} with {string}") do |field, content|
  fill_in field, :with => content

  @test_user_email = content if field.eql?("Email")
end

Given("I am a registered user") do
  visit "http://www.example.com/signup"
  fill_in "Email", :with => "test_user@example.com"
  fill_in "Username", :with => "test_user"
  fill_in "Password", :with => "password_001"
  fill_in "Password confirmation", :with => "password_001"
  click_button("Sign up")
  open_email("test_user@example.com")
  visit_in_email("Confirm my account", "test_user@example.com")

  @test_user_email = "test_user@example.com"
end
