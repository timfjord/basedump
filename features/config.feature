# language: en
Feature: Configuration
  In order to setup basedump
  As an user using basedump
  I should be able to create basedump config file

  Scenario: Local configuration with correct data
    And I run `basedump configure` interactively
    And I specify valid basecamp credetials
    Then the stdout should contain "Basedump local configuration was successfully stored"
    And a file named ".basedump" should exist
    And ".basedump" should be valid config file
    
    
    