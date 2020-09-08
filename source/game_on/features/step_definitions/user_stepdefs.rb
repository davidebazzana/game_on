Given("I am {string}") do |user|
  @test_user = create(:user, username: user)
end

Given("I log in my account") do
  click_link "Login"
  puts @test_user[:email]
  fill_in 'Email', :with => @test_user[:email]
  puts @test_user[:password]
  fill_in 'Password', :with => @test_user[:password]
  click_button("Login")
end
=begin
Given("I log in my account \({string}, {string})") do |email, password|
  click_link "Login"
  puts email
  puts password
  fill_in 'Email', :with => email
  fill_in 'Password', :with => password
  click_button("Login")
end
=end

Given("I log in my account username: {string}, email: {string}, password: {string}") do |username, email, password|
  @test_user = create(:user, username: username, email: email, password: password)
  visit "http://www.example.com/login"
  puts email
  puts password
  fill_in 'Email', :with => email
  fill_in 'Password', :with => password
  click_button("Log in")
end
