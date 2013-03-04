require 'spec_helper'

describe "StaticPages" do
  ##
  #describe "GET /static_pages" do
  #  it "works! (now write some real specs)" do
  #     Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #    get static_pages_index_path
  #    response.status.should be(200)
  #  end
  #end #Get StaticPages

  let(:base_title) {"Ruby on Rails Tutorial Sample App"}

  describe "Home page" do #Home Page is just an id for the test.  Doesn't have to match anything.
    it "should have the h1 'Sample App'" do #"shoudl have the content 'Sample App'" = more comments to be human readable.  not required
      visit '/static_pages/home' #Simulates visiting the URI /static_pages/home in the browser
      page.should have_selector('h1',:text=>'Sample App') #tests the resulting page to see if it has the right content
    end
    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title',:text => "Ruby on Rails Tutorial Sample App")
    end
    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => '| Home')
    end
  end #Home Page

  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1',:text=>'Help')
    end
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title',
                        :text => "#{base_title} | Help")
    end

  end #Help Page

  describe "About" do
  	it "should have the content 'About Us'" do
  		visit '/static_pages/about'
  		page.should have_selector('h1', :text=>'About Us')
  	end
    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title',
                    :text => "#{base_title} | About Us")
    end
  end#About

  describe "Contact" do 
    it "should have the content 'Contact'" do 
      visit '/static_pages/contact' 
      page.should have_selector('h1',:text=>'Contact') 
    end
    it "should have the right title" do
      visit '/static_pages/contact' 
      page.should have_selector('title',:text => "#{base_title} | Contact")
    end
  end #Contact

end #StaticPages
