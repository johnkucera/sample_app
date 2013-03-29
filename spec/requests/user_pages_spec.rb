require 'spec_helper'
@pageName='Sign up'

describe "User pages" do
  subject {page}

  #WILL NEED TO REFACTOR TO BE ADMIN ONLY LATER
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:all) { 30.times { FactoryGirl.create(:user) } }
    after(:all)  { User.delete_all }
    
    before(:each) do
      log_in user
      visit users_path
    end
    
    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }
    

    describe "pagination" do

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end
    
    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          log_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end #as an admin user
    end #delete links
  end #index

  describe "signup pages" do
    before { visit signup_path }
    it { should have_selector('h1',	text: @pageName) }
    #it { should have_selector('title', text: full_title(@pageName))}
  end #signup pages

  describe "profile page" do
  	#code to make a user variable
  	let(:user) { FactoryGirl.create(:user) } #this creates a user using factories.rb
  	before { visit user_path(user) }

  	it { should have_selector('h1',		text: user.name) }
  	it { should have_selector('title', 	text: user.name) }
  end #profile page

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    
    before do 
      log_in user
      visit edit_user_path(user) 
    end #before

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
    end #page

    describe "with invalid information" do
      before { click_button "Save changes" }

      #it { should have_content('error') }
    end #with invalid information

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end #before

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Log out', href: logout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end # with valid info
  end #edit
end #user pages

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
      end #after submission
    end #with invalid information

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end #before

      describe "after saving the user" do
      	before {click_button submit }
      	let(:user) { User.find_by_email('user@example.com') }

        #    	it { should have_selector('title', text: user.name) }
      	#tests that there's a welcome alert
        #    	it { should have_selector('div.alert.alert-success', text: "Welcome to the RSU Helper App!") } 
        #      it { should have_link('Log out') }
      end #after saving the user

  	#Confirm that submitting with valid info DOES create a user (increment count by 1)
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end #it should create a user
  end #describe valid info
end #describe User Pages