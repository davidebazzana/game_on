Feature: The owner of a game can change a game

  Background:
            Given I am on the Game-on home page
	    And I follow "Sign up"
            When I fill in "Email" with "pippo@example.com"
	    And I fill in "Username" with "pippo"
	    And I fill in "Password" with "password_001"
	    And I fill in "Password confirmation" with "password_001"
            And I click on "Sign up"
            And "pippo@example.com" should receive an email
            When I open the email
            Then I should see "Confirm my account" in the email body
            When I follow "Confirm my account" in the email
            Then I should see "Your email address has been successfully confirmed."

  Scenario: Change the title of a game
	  Given I am the owner of the game "old_title"
	  And I am on the Game-on home page
          When I follow "More about old_title"
	  And I follow "Edit game"
	  And I fill in "Title" with "new_title"
	  And I click on "Commit updates"
	  Then I should be on the Game-on home page
	  And I should see the game's title changed to "new_title", not "old_title" anymore

  Scenario: Change the description of a game
	  Given I am the owner of the game "game_title" with info "old_info"
	  And I am on the Game-on home page
	  When I follow "More about game_title"
	  Then I should see "old_info"
	  When I follow "Edit game"
	  And I fill in "Info" with "new_info"
	  And I click on "Commit updates"
	  Then I should be on the Game-on home page
	  When I follow "More about game_title"
	  Then I should see the game's description changed to "new_info", not "old_info" anymore


  Scenario: Change the title and the description of a game
  	  Given I am the owner of the game "old_title" with info "old_info"
	  And I am on the Game-on home page
	  When I follow "More about old_title"
	  Then I should see "old_info"
	  When I follow "Edit game"
	  And I fill in "Title" with "new_title"
	  And I fill in "Info" with "new_info"	  
	  And I click on "Commit updates"
	  Then I should be on the Game-on home page
	  And I should see the game's title changed to "new_title", not "old_title" anymore
	  When I follow "More about new_title"
	  Then I should see the game's description changed to "new_info", not "old_info" anymore