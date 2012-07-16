# language: en
Feature: Configuration
  In order to setup basedump
  As an user using basedump
  I should be able to create basedump config file

  Scenario Outline: Local or global configuration
    And I run `basedump configure <options>` interactively
    And I specify valid basecamp credetials
    Then the stdout should contain "Basedump <config_type> configuration was successfully stored"
    And "<config_file>" should be valid config file
    
  Examples:
    | options  | config_type | config_file |
    |          | local       | .basedump   |
    | --global | global      | ~/.basedump |
    