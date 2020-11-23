Feature: Search a game by its name

Scenario: There are some games uploaded, included the one that I am looking for
	  Given I am on the Game-on home page
	  And there are many games uploaded
          And I type "cat" in the search area
          When I click on "Search"
	  Then I should only see the games with the word "cat" in their name

Scenario: There are some games uploaded but not the one that I am looking for
	  Given I am on the Game-on home page
	  And there are many games uploaded
          And I type "cucumbers" in the search area
          When I click on "Search"
	  Then there should be no game in the list

Scenario: There are no games uploaded
	  Given I am on the Game-on home page
	  And there are no games uploaded
          And I type "cat" in the search area
          When I click on "Search"
	  Then there should be no game in the list