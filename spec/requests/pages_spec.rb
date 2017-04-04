require 'rails_helper'

describe "Static pages" do

  describe "Home page", :type => :routing do

    it "should have some welcoming content" do
      visit "/pages/home"
      expect(page).to have_selector('h1',
        :text => "Welcome to Paul's Lovely Rails Blog")
      expect(page).to have_content(
        "Here you can find all sorts of posts about a wide range of subjects")
    end

    it "should link to the blog posts" do
      visit "/pages/home"
      expect(page).to have_link( :href=>"/posts")
    end

    it "should be available from url /home" do
      expect(:get => "home").to route_to(
        :controller => "pages",
        :action => "home"
      )
    end
  end

  describe "About page", :type => :routing do

    # Only test the <hN> tag contents. We can infer the rest from that.
    it "should display the text of the challenge pdf" do
      visit "/pages/about"
      expect(page).to have_selector('h1',
        :text => "POST Recruitment Web Development Challenge")
      expect(page).to have_selector('h2', :text => "Expectations")
      expect(page).to have_selector('h2', :text => "Overview")
      expect(page).to have_selector('h2', :text => "Features")
      expect(page).to have_selector('h2', :text => "Technologies")
    end

    it "should be available from url /about" do
      expect(:get => "about").to route_to(
        :controller => "pages",
        :action => "about"
      )
    end
  end
end
