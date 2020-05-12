Feature: The owner of a game can change a game's title

Scenario Outline: Change the title of a game
	  Given I am on the Game-on home page
	  And I log in my account username: "<username>", email: "<email>", password: "<password>"
	  And I am the owner of the game "<old_title>"
	  When I follow "More about <old_title>"
	  And I follow "Edit game"
	  And I change the title of the game to "<new_title>"
	  Then I should be on the Game-on home page
	  And I should see the game's title changed to "<new_title>", not "<old_title>" anymore

Examples:
	|old_title	|new_title	|username	|email			|password	|
	|Pac-Man	|Tetris		|John		|john@email.com		|123456_john	|
	|Tennis		|Football	|Lisa		|lisa@email.com		|tiffany_123	|
	|Crash		|Sonic		|Ugo		|Ugo@email.com		|password_001	|