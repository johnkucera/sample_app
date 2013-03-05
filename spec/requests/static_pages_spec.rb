require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do 
    #does the below for all  pages in the describe, 
    #I think that means all in subject {page}
    it { should have_selector('h1', text: heading)}
    it { should have_selector('title',text: full_title(page_title))}
  end
  describe "Home page" do
    before { visit root_path }

    let(:heading) {'Sample App'}
    let(:page_title) {''}
    
    it_should_behave_like "all static pages"  #I think this matches the shared examples "For" above

    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Help page" do
    before { visit help_path }

    let(:heading) {'Help'}
    let(:page_title) {'Help'}
    
    it_should_behave_like "all static pages"  #I think this matches the shared examples "For" above
  end

  describe "About page" do
    before { visit about_path }

    let(:heading) {'About'}
    let(:page_title) {'About Us'}
    
    it_should_behave_like "all static pages"  #I think this matches the shared examples "For" above
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:heading) {'Contact'}
    let(:page_title) {'Contact'}
    
    it_should_behave_like "all static pages"  #I think this matches the shared examples "For" above
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact" 
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link "sample app"
    page.should have_selector 'title', text: 'Sample App' #title doesn't have the | in it
  end
end
