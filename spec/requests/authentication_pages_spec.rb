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

	  describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
    	  click_button "Log in"
  	  end

  		it { should have_selector('title', text: user.name) }

      #WILL NEED TO REFACTOR TO BE ADMIN ONLY
      it { should have_link('Users',    href: users_path) }

  		#header link to profile page
  		it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
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

  describe "authorization" do

    describe "for non-logged-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Log in"
        end

        describe "after logging in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit user')
          end
        end
      end #attempting to visit protected page

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Log in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(login_path) }
        end

        #WILL NEED TO MAKE THIS ADMIN ONLY
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_selector('title', text: 'Log in') }
        end
      end
    end #non-logged in users

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { log_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit user')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) } #assumes redirect for unauthorized pages are to root
      end
    end #as wrong user
    
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { log_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }        
      end
    end #as non-admin
  end #authorization
end
