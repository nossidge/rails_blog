require 'rails_helper'

describe Comment do

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
    @post.save
    @comment = Comment.new( {
      :name => "Dave A. Commenter",
      :body => "Test comment body",
      :post_id => @post.id
    } )
  end


  describe "object instance" do
    subject { @comment }
    it { is_expected.to be_valid }
    it { is_expected.to be_an_instance_of Comment }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:body) }
    it { is_expected.to respond_to(:post_id) }
    it { is_expected.to respond_to(:post) }
  end


  describe "#post" do
    it "should be an instance of Post" do
      expect(@comment.post).to be_an_instance_of Post
    end

    it "should have the correct id" do
      expect(@comment.post_id).to eql(@post.id)
    end
  end


  describe "name validation" do
    subject { @comment }

    it "should require a name" do
      @comment.name = ""
      expect(@comment).to_not be_valid
    end

    it "should reject names longer than 100 chars" do
      @comment.name =  "a" * 99
      expect(@comment).to be_valid

      @comment.name =  "a" * 100
      expect(@comment).to be_valid

      @comment.name =  "a" * 101
      expect(@comment).to_not be_valid
    end
  end


  describe "body validation" do
    subject { @comment }

    it "should require a body" do
      @comment.body = ""
      expect(@comment).to_not be_valid
    end

    it "should reject text longer than 500 chars" do
      @comment.body =  "a" * 499
      expect(@comment).to be_valid

      @comment.body =  "a" * 500
      expect(@comment).to be_valid

      @comment.body =  "a" * 501
      expect(@comment).to_not be_valid
    end
  end

end
