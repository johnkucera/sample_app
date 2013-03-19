require 'spec_helper'
@pageName='Sign up'

describe "User pages" do
  subject {page}
  describe "signup pages" do
    before { visit signup_path }
    it { should have_selector('h1',	text: @pageName) }
    it { should have_selector('title', text: full_title(@pageName))}
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

      #test error message
      describe "after submission" do
      	before { click_button submit }
		
		#I think this verifies its on the same page
#      	it { should have_selector('title', 'Sign up') } 
#      	it { should have_content('Name can\'t be blank') }
#      	it { should have_content('Email can\'t be blank') }
#      	it { should have_content('Email is invalid') }
#      	it { should have_content('Password is too short') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end

      describe "after saving the user" do
      	before {click_button submit }
      	let(:user) { User.find_by_email('user@example.com') }

  #    	it { should have_selector('title', text: user.name) }
      	#tests that there's a welcome alert
  #    	it { should have_selector('div.alert.alert-success', text: "Welcome to the RSU Helper App!") } 
  #      it { should have_link('Log out') }

      end

  	#Confirm that submitting with valid info DOES create a user (increment count by 1)
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end #it
    end #describe valid info

end #describe signup
