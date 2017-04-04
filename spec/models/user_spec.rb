require 'rails_helper'

# This is based on:
# https://github.com/railstutorial/sample_app/blob/master/spec/models/user_spec.rb

describe User do

  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobarbaz",
      :password_confirmation => "foobarbaz"
    }
  end

  it "should create a new instance given a valid attribute" do
    valid_user = User.new(@attr)
    expect(valid_user).to be_valid
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    expect(no_name_user).to_not be_valid
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    expect(no_email_user).to_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      expect(valid_email_user).to be_valid
    end
  end

  # We are not doing any pointless email checking, other than an @.
  it "should also ACCEPT invalid email addresses that contain @" do
    addresses = %w[user@foo,com user_at_foo.o@rg example.user@foo.]
    addresses.each do |address|
      invalid_email_user_with_at = User.new(@attr.merge(:email => address))
      expect(invalid_email_user_with_at).to be_valid
    end
  end

  it "should reject invalid email addresses with no @ sign" do
    addresses = %w[user.foo,com user_at_foo.org example.userkfoo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      expect(invalid_email_user).to_not be_valid
    end
  end


  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      expect(@user).to respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      expect(@user).to respond_to(:password_confirmation)
    end

  end


  describe "password validations" do

    it "should require a password" do
      user_with_no_password = User.new(
        @attr.merge(:password => "", :password_confirmation => ""))
      expect(user_with_no_password).to_not be_valid
    end

    it "should require a matching password confirmation" do
      user_with_wrong_password_confirmation = User.new(
        @attr.merge(:password_confirmation => "invalid"))
      expect(user_with_wrong_password_confirmation).to_not be_valid
    end

    it "should reject passwords shorter than 8 chars" do
      short = "a" * 7
      hash = @attr.merge(:password => short, :password_confirmation => short)
      user_with_short_password = User.new(hash)
      expect(user_with_short_password).to_not be_valid
    end

  end

end
