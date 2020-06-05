Feature: A user can play any game

Scenario Outline: Gameplay
	  Given I am on the Game-on home page
	  And I log in my account username: "<username>", email: "<email>", password: "<password>"
	  And the game "<game>" exists
	  When I follow "More about <game>"
	  Then I should be able to play the game "<game>"

Examples:
	|game		|username	|email			|password	|
	|Pac-Man	|John		|john@email.com		|123456_john	|
	|Tennis		|Lisa		|lisa@email.com		|tiffany_123	|
	|Crash		|Ugo		|Ugo@email.com		|password_001	|