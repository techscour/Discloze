require 'rubygems'
require 'faker'
require 'factory_girl'

FactoryGirl.define do

	factory :app_of_public do
		public
		partner_app
	end

	factory :invitation do
		public
		partner
		headline  "abcde"
		list  "abcde"
		html  "abcde"
		posted  Time.now.utc
		effective  Time.now.utc
		expires  Time.now.utc
	end

	factory :listable do
		name  "abcde"
		topic  "abcde"
		description  "abcde"
		html  "abcde"
	end

	factory :list do
		public
		name  "abcde"
		visibility  "abcde"
		values  "abcde"
		last_activity  Time.now.utc
		created  Time.now.utc
	end

	factory :login do
		public
		last_activity  Time.now.utc
		remember  false
	end

	factory :notice do
		public
		headline  "abcde"
		html  "abcde"
		posted  Time.now.utc
	end

	factory :offer do
		public
		partner
		list  "abcde"
		headline  "abcde"
		html  "abcde"
		posted  Time.now.utc
		effective  Time.now.utc
		expires  Time.now.utc
	end

	factory :partner_app do
		partner
		name  "abcde"
		description  "abcde"
		url  "abcde"
		html  "abcde"
	end

	factory :partner_site do
		partner
		name  "abcde"
		description  "abcde"
		url  "abcde"
		html  "abcde"
	end

	factory :partner do
		stormpath_id "abcde"
		name  "abcde"
		description  "abcde"
		url  "abcde"
		html  "abcde"
	end

	factory :public do
		stormpath_id   "abcde"
		last_login  Time.now.utc
	end

	factory :site_of_public do
		public
		partner_site
	end

	factory :token do
		partner
		token_value  "abcde"
		last_login  Time.now.utc
		last_activity  Time.now.utc
	end

	factory :update do
		public
		partner
		list  "abcde"
		headline  "abcde"
		html  "abcde"
		posted  Time.now.utc
		effective  Time.now.utc
		expires  Time.now.utc
	end
end