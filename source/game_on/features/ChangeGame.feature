Feature: The owner of a game can change a game

  Background:
          Given I am a registered user

  Scenario: Change the title of a game
	  Given I am the owner of the game "old_title"
          When I follow "More about old_title"
	  And I follow "Edit game"
	  And I fill in "Title" with "new_title"
	  And I click on "Commit updates"
	  Then I should be on the Game-on home page
	  And I should see "new_title", not "old_title" anymore

  Scenario: Change the description of a game
	  Given I am the owner of the game "game_title" with info "old_info"
	  When I follow "More about game_title"
	  And I follow "Edit game"
	  And I fill in "Info" with "new_info"
	  And I click on "Commit updates"
	  And I follow "More about game_title"
	  Then I should see "new_info", not "old_info" anymore


  Scenario: Change the title and the description of a game
  	  Given I am the owner of the game "old_title" with info "old_info"
	  When I follow "More about old_title"
	  And I follow "Edit game"
	  And I fill in "Title" with "new_title"
	  And I fill in "Info" with "new_info"	  
	  And I click on "Commit updates" 
	  And I follow "More about new_title"
	  Then I should see "new_title", not "old_title" anymore
	  And I should see "new_info", not "old_info" anymore