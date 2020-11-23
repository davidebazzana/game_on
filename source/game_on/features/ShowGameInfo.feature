Feature: A visitor can see a game's infos

Scenario Outline: Show a game's infos
	  Given I am on the Game-on home page
	  And the game "<game>" exists
	  When I follow "More about <game>"
	  Then I should be on "<game>"'s page
 	  And I should see "<game>"'s infos

Examples:
	|game	 |
	|Pac-Man |
	|Tennis  |
	|Crash	 |