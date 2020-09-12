Feature: The owner of a game can change a game's title and/or its description

Scenario Outline: Change the title of a game
	  Given I am on the Game-on home page
	  And I log in my account username: "<username>", email: "<email>", password: "<password>"
	  And I am the owner of the game "<old_title>"
	  When I follow "More about <old_title>"
	  And I follow "Edit game"
	  And I change the title of the game to "<new_title>"
	  And I click on "Commit updates"
	  Then I should be on the Game-on home page
	  And I should see the game's title changed to "<new_title>", not "<old_title>" anymore

Examples:
	|old_title	|new_title	|old_info            |new_info           |username	|email			|password	|
	|Pac-Man	|Tetris		|Funny arcade game   |Even funnier       |John		|john@email.com		|123456_john	|
	|Tennis		|Football	|This game is boring |Another sport game |Lisa		|lisa@email.com		|tiffany_123	|
	|Crash		|Sonic		|Funniest game ever  |Crash was better   |Ugo		|Ugo@email.com		|password_001	|

Scenario Outline: Change the description of a game
	  Given I am on the Game-on home page
	  And I log in my account username: "<username>", email: "<email>", password: "<password>"
	  And I am the owner of the game "<old_title>"
	  When I follow "More about <old_title>"
	  And I follow "Edit game"
	  And I change the description of the game to "<new_info>"
	  And I click on "Commit updates"
	  Then I should be on the Game-on home page
	  When I follow "More about <old_title>"
	  Then I should see the game's description changed to "<new_info>", not "<old_info>" anymore

Examples:
	|old_title	|new_title	|old_info            |new_info           |username	|email			|password	|
	|Pac-Man	|Tetris		|Funny arcade game   |Even funnier       |John		|john@email.com		|123456_john	|
	|Tennis		|Football	|This game is boring |Another sport game |Lisa		|lisa@email.com		|tiffany_123	|
	|Crash		|Sonic		|Funniest game ever  |Crash was better   |Ugo		|Ugo@email.com		|password_001	|

Scenario Outline: Change the title and the description of a game
	  Given I am on the Game-on home page
	  And I log in my account username: "<username>", email: "<email>", password: "<password>"
	  And I am the owner of the game "<old_title>"
	  When I follow "More about <old_title>"
	  And I follow "Edit game"
	  And I change the title of the game to "<new_title>"
	  And I change the description of the game to "<new_info>"
	  And I click on "Commit updates"
	  Then I should be on the Game-on home page
	  And I should see the game's title changed to "<new_title>", not "<old_title>" anymore
	  When I follow "More about <new_title>"
	  Then I should see the game's description changed to "<new_info>", not "<old_info>" anymore

Examples:
	|old_title	|new_title	|old_info            |new_info           |username	|email			|password	|
	|Pac-Man	|Tetris		|Funny arcade game   |Even funnier       |John		|john@email.com		|123456_john	|
	|Tennis		|Football	|This game is boring |Another sport game |Lisa		|lisa@email.com		|tiffany_123	|
	|Crash		|Sonic		|Funniest game ever  |Crash was better   |Ugo		|Ugo@email.com		|password_001	|