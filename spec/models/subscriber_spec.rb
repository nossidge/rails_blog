require 'rails_helper'

describe Subscriber do

  before(:each) do
    @subscriber = Subscriber.new( {
      :name => "Example Subscriber",
      :email => "user@example.com"
    } )
  end


  describe "attributes" do
    subject { @subscriber }
    it { is_expected.to be_valid }
    it { is_expected.to be_an_instance_of Subscriber }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:email) }
  end


  describe "name validation" do
    subject { @subscriber }

    it "should require a name" do
      @subscriber.name = ""
      expect(@subscriber).to_not be_valid
    end
  end


  describe "email validation" do
    it "should require an email address" do
      @subscriber.email = ""
      expect(@subscriber).to_not be_valid
    end

    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        @subscriber.email = address
        expect(@subscriber).to be_valid
      end
    end

    # We are not doing any pointless email checking, other than an @.
    it "should also ACCEPT invalid email addresses that contain @" do
      addresses = %w[user@foo,com user_at_foo.o@rg example.user@foo.]
      addresses.each do |address|
        @subscriber.email = address
        expect(@subscriber).to be_valid
      end
    end

    it "should reject invalid email addresses with no @ sign" do
      addresses = %w[user.foo,com user_at_foo.org example.userkfoo.]
      addresses.each do |address|
        @subscriber.email = address
        expect(@subscriber).to_not be_valid
      end
    end
  end

end
