# language: en
Feature: Logging
  In order to log time on basecamp
  As an user
  I should be able to log time using different params

  @cur @hide_config
  Scenario: Log as default task
    When I run `basedump log`
    Then the output should contain "No credentials given."
