
include SessionHelpers

When(/^I visit "(.*?)"$/) do |arg1|
  visit arg1
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_content(arg1)
end

Given(/^that I'm not signed in$/) do
  visit '/session/abandon'
end

When(/^I sign in$/) do
  sign_in
end

Given(/^that I'm signed in$/) do
  sign_in
end

When(/^I click the "(.*?)" button$/) do |arg1|
  click_button arg1
end

When(/^I fill in the new account page$/) do
  fill_in_sign_up
  #pending # express the regexp above with the code you wish you had
end

When(/^I click the "(.*?)" link$/) do |arg1|
  click_link arg1
end

When(/^I update my account information$/) do
  fill_in_update
  #pending # express the regexp above with the code you wish you had
end

When(/^I update my password$/) do
  fill_in_passup
  #pending # express the regexp above with the code you wish you had
end

When(/^I fill in my password$/) do
  fill_in_preset
  #pending # express the regexp above with the code you wish you had
end

Given(/^I don't have an account$/) do
  ensure_no_test_account
  #pending # express the regexp above with the code you wish you had
end
