require 'rails_helper'

RSpec.describe Post, type: :model do


# Model test for data input
  describe 'Post to be valid' do

    let(:post) {Post.new(
      title: 'What is the difference between a cookie and a session?',
      user_id: 8,
      content: 'What are the diffences with these key/value pairs?',
    )}

    it 'Rspec is present' do
      expect(true).to be true
    end

    it 'Post to be saved to db' do
      expect(post.save).to be true
    end

  end




# ActiveRecord Tests
  describe 'ActiveRecord associations' do

    it 'Post belongs to users' do
      expect(Post.reflect_on_association(:user).macro).to be (:belongs_to)
    end

    it 'Post has many user\'s in plural name' do
      expect(Post.reflect_on_association(:user).plural_name).to eq ("users")
    end

    it 'Post has_many replies' do
      expect(Post.reflect_on_association(:replies).macro).to be (:has_many)
    end

    it 'Post has replies in plural_name' do
      expect(Post.reflect_on_association(:replies).plural_name).to eq ("replies")
    end

  end


  it "is valid with a title, user_id, and content" do
    post = Post.new(
      title: 'What is the difference between a cookie and a session?',
      user_id: 8,
      content: 'What are the diffences with these key/value pairs?')
    expect(post).to be_valid
  end

  it "is invalid without a title" do
    post = Post.new(title: nil)
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a user_id" do
    post = Post.new(user_id: nil)
    post.valid?
    expect(post.errors[:user_id]).to include("can't be blank")
  end

  it "is invalid without a content" do
    post = Post.new(content: nil)
    post.valid?
    expect(post.errors[:content]).to include("can't be blank")
  end

  it "returns a post's title as a string" do
    post = Post.new(title: 'Where may I find information on how to use the Devise gem')
    expect(post.title).to be_a_kind_of(String)
  end

  it "returns user_id as an integer" do
    post = Post.new(user_id: 8)
    expect(post.user_id).to be_a_kind_of(Integer)
  end

  it "returns a post's content as a string" do
    post = Post.new(content: 'Is there any good tutorials out there?')
    expect(post.content).to be_a_kind_of(String)
  end

end
