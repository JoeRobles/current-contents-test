Feature: CRU authors

  Scenario: Test author list endpoint
    When fetching all author list
    Then at least one author should be received

  Scenario: Create, list edit and delete authors
    Given a list of authors:
      | authorName  | email                 | birthDate  |
      | C. S. Lewis | c.s.lewis@hotmail.com | 11/22/1963 |
    When creating authors
    Then the author has to be in the list
    When updating author attributes
    Then should retrieve updated author attributes
