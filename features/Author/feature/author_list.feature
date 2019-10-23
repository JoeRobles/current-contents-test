Feature: CRU authors

  Scenario: List all authors endpoint
    When fetching all author list
    Then at least one author should be received

  Scenario: Create an author endpoint
    Given a list of authors:
      | authorName  | email                 | birthDate  |
      | C. S. Lewis | c.s.lewis@hotmail.com | 11/22/1963 |
    When creating authors
    Then the author has to be in the list

  Scenario: Read an author endpoint
    Then author should be stored

  Scenario: Update an author
    When updating author attributes
    Then should retrieve updated author attributes

#  Scenario: Delete an author
#    When deleting an author
#    Then should not be retrieved