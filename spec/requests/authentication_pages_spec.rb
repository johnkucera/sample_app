require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }
  @pageName='Log in'

  describe "login page" do
  	before { visit login_path }
  	it { should have_selector('h1', text: "Log in") }
  	it { should have_selector('title', text: "Log in") }
  end

  describe "login" do
  	before { visit login_path}

  	it { should have_selector('title', text: "Log in") }
  	it { should have_selector('div.alert.alert-error', text:'Invalid') }
  
	  describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
    	click_button "Log in"
  	  end

  		it { should have_selector('title', text: user.name) }
  		#header link to profile page
  		it { should have_link('Profile', href: user_path(user)) }
  		#header link to profile page
  		it { should have_link('Log out', href: logout_path) }
  		it { should_not have_link("Log in", href: login_path) }
  	end
	
	  describe "with invalid information" do
      before { click_button "Log in" }

      it { should have_selector('title', text: "Log in") }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
	  
		  describe "after visiting another page" do
  			before { click_link "Home" }
  			it { should_not have_selector('div.alert.alert-error') }
  		end
	  end
  end
end
