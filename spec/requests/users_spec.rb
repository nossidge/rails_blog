require 'rails_helper'


shared_examples_for 'with invalid fields' do
  fields = %w[name email password password\ confirmation]
  fields.each do |field|
    it "should fail if the #{field} is missing" do
      fill_in field.capitalize, with: ""
      expect { submit }.to_not change(User, :first)
      expect { submit }.to_not change(User, :count)
      is_expected.to have_content('error')
    end
  end

  it "should fail if the email does not contain @" do
    fill_in "Email", with: "personatexample.com"
    expect { submit }.to_not change(User, :first)
    expect { submit }.to_not change(User, :count)
    is_expected.to have_content('error')
  end

  it "should fail if the password is too short" do
    fill_in "Password", with: "a" * 7
    fill_in "Password confirmation", with: "a" * 7
    expect { submit }.to_not change(User, :first)
    expect { submit }.to_not change(User, :count)
    is_expected.to have_content('error')
  end
end


describe "User pages" do
  before(:all) { User.delete_all }
  after (:all) { User.delete_all }

  subject { page }


  describe "index" do
    before(:all)  { 5.times { FactoryGirl.create(:user) } }
    before(:each) { visit users_path }
    let   (:user) { User.first }

    it { is_expected.to have_link('Show', href: user_path(user)) }
    it { is_expected.to have_link('Edit', href: edit_user_path(user)) }
    it { is_expected.to have_link('Destroy', href: user_path(user)) }

    it "should be able to delete a user" do
      expect { click_link('Destroy', :match => :first)}.to (
        change(User, :count).by(-1) )
    end
  end


  describe "show" do
    before(:all)  { FactoryGirl.create(:user) }
    before(:each) { visit user_path(user) }
    let   (:user) { User.first }

    it { is_expected.to have_link('Edit', href: edit_user_path(user)) }
    it { is_expected.to have_link('Back', href: users_path) }

    it { is_expected.to have_content("Name:") }
    it { is_expected.to have_content("Email:") }

    it { is_expected.to have_content(user.name) }
    it { is_expected.to have_content(user.email) }
  end


  describe "new" do
    before(:all)  { FactoryGirl.create(:user) }
    before(:each) { visit new_user_path }

    describe "when cancelling the form" do
      let(:cancel) { click_link "Cancel" }
      it { expect { cancel }.to_not change(User, :last) }
      it { expect { cancel }.to_not change(User, :count) }
      it { cancel; is_expected.to have_current_path(users_path) }
    end

    describe "when submitting the form" do
      let(:submit) { click_button "Submit" }
      before do
        fill_in "Name",                  with: "Example User"
        fill_in "Email",                 with: "person@example.com"
        fill_in "Password",              with: "foobarbaz"
        fill_in "Password confirmation", with: "foobarbaz"
      end

      describe "with valid fields" do
        it { expect { submit }.to change(User, :last) }
        it { expect { submit }.to change(User, :count).by(1) }
        it { submit; is_expected.to have_current_path(user_path(User.last)) }
        it { submit; is_expected.to have_selector('p#notice', text: 'User was successfully created') }
      end

      it_behaves_like "with invalid fields"
    end
  end


  describe "edit" do
    let(:user)    { FactoryGirl.create(:user) }
    before(:each) { visit edit_user_path(user) }

    it { is_expected.to have_current_path(edit_user_path(user)) }

    describe "when cancelling the form" do
      let(:cancel) { click_link "Cancel" }
      it { expect { cancel }.to_not change{ user } }
      it { expect { cancel }.to_not change(User, :count) }
      it { cancel; is_expected.to have_current_path(users_path) }
    end

    describe "when submitting the form" do
      let(:submit) { click_button "Submit" }

      describe "with valid fields" do
        let(:new_name)     { "New User" }
        let(:new_email)    { "new@example.com" }
        let(:new_password) { "bazbarfoo" }
        before do
          fill_in "Name",                  with: new_name
          fill_in "Email",                 with: new_email
          fill_in "Password",              with: new_password
          fill_in "Password confirmation", with: new_password
          click_button "Submit"
        end
        it { is_expected.to have_current_path(user_path(user)) }
        it { is_expected.to have_selector('p#notice',text: 'User was successfully updated') }
        it { expect(user.reload.name).to  eq new_name }
        it { expect(user.reload.email).to eq new_email }
      end

      it_behaves_like "with invalid fields"
    end
  end
end
