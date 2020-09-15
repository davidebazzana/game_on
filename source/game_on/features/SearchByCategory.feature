Feature: Search a game by its category

Scenario: There are some games uploaded, included some with the category that I am looking for
	  Given I am on the Game-on home page
	  And there are many games uploaded
          And I choose "Casual" as category
          When I click on "Search"
	  Then I should only see the games with category "Casual"

Scenario: There are some games uploaded but there are no games with the category that I am looking for
	  Given I am on the Game-on home page
	  And there are many games uploaded
          And I choose "Indie" as category
          When I click on "Search"
	  Then there should be no game in the list

Scenario: There are no games uploaded
	  Given I am on the Game-on home page
	  And there are no games uploaded
          And I choose "Casual" as category
          When I click on "Search"
	  Then there should be no game in the list