Feature: Baseball Statistics Calculator

	Scenario: Calculate most improved batting average
		Given I have entered 2009 into the statbuilder
		Then the result should be Josh Hamilton

	Scenario: Calculate most improved batting average
		Given I have entered 2008 into the statbuilder
		Then the result should be Felipe Lopez

	Scenario: Calculate the slugging percentage
		Given I have entered 2009 and OAK into the statbuilder
		Then The number of players should be 37
		And Trevor Cahill slugging percentage should be 0.5

	Scenario: Determine if a triple crown exists
		Given I have entered 2012 and AL for triple crown
		Then The answer is Miguel Cabrera

	Scenario: Determine if a triple crown exists
		Given I have entered 2011 and NL for triple crown
		Then The answer is No Winner