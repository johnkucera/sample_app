require 'spec_helper'

describe "User pages" do
  subject {page}
  describe "signup pages" do
    before { visit signup_path }
    it { should have_selector('h1',	text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up'))}
  end

  describe "profile page" do
	#code to make a user variable
	let(:user) { FactoryGirl.create(:user) } #this creates a user using factories.rb
	before { visit user_path(user) }

	it { should have_selector('h1',		text: user.name) }
	it { should have_selector('title', 	text: user.name) }
  end
end



describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
      	#Confirm that submitting without anything entered doesnt create a user
        expect { click_button submit }.not_to change(User, :count) 
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

  	#Confirm that submitting with valid info DOES create a user (increment count by 1)
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end #it
    end #describe valid info

end #describe signup
