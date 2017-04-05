require 'rails_helper'

describe Post do

  before(:each) do
    @user = User.new( {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobarbaz",
      :password_confirmation => "foobarbaz"
    } )
    @user.save
    @post = Post.new( {
      :title => "Example Post",
      :body => "#Test post\nSome lines",
      :user_id => @user.id
    } )
  end


  describe "object instance" do
    subject { @post }
    it { is_expected.to be_valid }
    it { is_expected.to be_an_instance_of Post }
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:body) }
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:user) }
  end


  describe "#user" do
    it "should be an instance of User" do
      expect(@post.user).to be_an_instance_of User
    end

    it "should have the correct id" do
      expect(@post.user_id).to eql(@user.id)
    end
  end


  describe "title validation" do
    subject { @post }

    it "should require a title" do
      @post.title = ""
      expect(@post).to_not be_valid
    end

    it "should reject titles longer than 140 chars" do
      @post.title =  "a" * 139
      expect(@post).to be_valid

      @post.title =  "a" * 140
      expect(@post).to be_valid

      @post.title =  "a" * 141
      expect(@post).to_not be_valid
    end
  end


  describe "body validation" do
    subject { @post }

    it "should require a body" do
      @post.body = ""
      expect(@post).to_not be_valid
    end
  end

end
