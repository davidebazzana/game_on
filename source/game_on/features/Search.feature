Feature: Search a game by its name or by its category or both

Scenario: Search by name
	  Given I am on the Game-on home page
	  And there are many games uploaded
          And I type "cat" in the search area
          When I click on the search button
	  Then I should only see the games with the word "cat" in their name

Scenario: Search by category
	  Given I am on the Game-on home page
	  And there are many games uploaded
          And I choose "Casual" as category
          When I click on the search button
	  Then I should only see the games with category "Casual"

Scenario: Search by name and category
	  Given I am on the Game-on home page
	  And there are many games uploaded
          And I type "cat" in the search area
          And I choose "Casual" as category
          When I click on the search button
          Then I should only see the games with the word "cat" in their name and with category "Casual"
