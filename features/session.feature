
Feature: Discolose Session
  In order to use Discloze
  As a public user
  I should be able to establish an account and access servies

  Scenario: Site is Available
  	When I visit "/"
  	Then I should see "Welcome To Discloze"

  Scenario: Sign Up
    Given that I'm not signed in
    When I visit "/"
    When I click the "Sign Up" link
    Then I should see "Tell Us About Yourself"

 Scenario: Create User
    Given that I'm not signed in
    And I don't have an account
    When I click the "Sign Up" link
    And I fill in the new account page
    And I click the "Create Your Account" button
    Then I should see "Your account confirmation email is on the way."

  Scenario: Sign In
    Given that I'm not signed in
    When I visit "/session/signin"
    And I sign in
    Then I should see "Sign Out"

  Scenario: Sign Out
    Given that I'm signed in
    When I visit "/"
    And I click the "Sign Out" link
    Then I should see "Sign In"

 Scenario: Authentication Required to Access Account Information
    Given that I'm not signed in
    When I visit "/session/update"
    Then I should see "You must be logged in to access this section."

 Scenario: Password Reset Request 1
    Given that I'm not signed in
    When I visit "/session/signin"
    And I click the "forgot your password?" link
    Then I should see "Request Password Reset"
 
 Scenario: Password Reset Request 2
    Given that I'm not signed in
    When I visit "/session/preset"
    And I fill in my password
    And I click the "Request" button
    Then I should see "Your password reset email is on the way."

 Scenario: Update Account Information
    Given that I'm signed in
    When I visit "/session/update"
    And I update my account information
    And I click the "Update Your Information" button
    Then I should see "Your account has been updated."
  
 Scenario: Change Account Password
    Given that I'm signed in
    When I visit "/session/passup"
    And I update my password
    And I click the "Change Password" button
    Then I should see "You password has been changed."

 Scenario: Delete Account
    Given that I'm signed in
    When I visit "/session/update"
    And I click the "Delete My Account" button
    Then I should see "Your account has been deleted."


