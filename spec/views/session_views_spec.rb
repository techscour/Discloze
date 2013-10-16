require 'spec_helper'

describe "mobiles/mobile" do
  it "renders contains Welcome to Discloze" do
    render
    expect(rendered).to include("Welcome to Discloze")
  end
end
describe "session/landing" do
	it "renders contains Welcome to Discloze" do
		render
    	expect(rendered).to include("Welcome To Discloze")
  	end
end
describe "session/about" do
	it "contains It's Your Very Own Smart Internet" do
		render
    	expect(rendered).to include("It's Your Very Own Smart Internet")
  	end
end
describe "session/signin" do
	it "contains Sign In" do
		render
    	expect(rendered).to include("Sign In")
  	end
end
describe "session/signup" do
	it "contains Tell Us About Yourself" do
		values = {'email' => "a@b.com", 'first' => "first", 'last' => "last",\
			'zip' => "12345", 'year' => "1984", 'gender' => "male"}
		# view, controller, template, request, and reply are instance variables
		view.stub(:values) { values }
		render
    	expect(rendered).to include("Tell Us About Yourself")
  	end
end
describe "session/update" do
	it "contains Update Your Information" do
		values = {'email' => "a@b.com", 'first' => "first", 'last' => "last",\
			'zip' => "12345", 'year' => "1984", 'gender' => "male"}
		view.stub(:values) { values }
		render
    	expect(rendered).to include("Update Your Information")
  	end
end
describe "session/passup" do
	it "contains Change Your Password" do
		render
    	expect(rendered).to include("Change Your Password")
  	end
end
describe "session/preset" do
	it "contains Request Password Reset" do
		render
    	expect(rendered).to include("Request Password Reset")
  	end
end
describe "layouts/application" do
	it "contains Discloze" do
		render
    	expect(rendered).to include("Discloze")
  	end
end