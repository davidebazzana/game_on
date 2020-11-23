Feature: Search a game by both its name and its category

Scenario: Search by name and category
	  Given I am on the Game-on home page
	  And there are many games uploaded
          And I type "cat" in the search area
          And I choose "Casual" as category
          When I click on "Search"
          Then I should only see the games with the word "cat" in their name and with category "Casual"
