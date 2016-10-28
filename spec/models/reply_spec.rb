require 'rails_helper'

RSpec.describe Reply, type: :model do


# Model test for data input
  describe 'Reply to be valid' do

    let(:reply) {Reply.new(
      body: 'Cookies are on the client-side(browser) and sessions are on the server-side',
      user_id: 4,
      post_id: 8,
    )}

    it 'Rspec is present' do
      expect(true).to be true
    end

    it 'Reply to be saved to db' do
      expect(reply.save).to be true
    end

  end




# ActiveRecord Tests
  describe 'ActiveRecord associations' do

    it 'Reply belongs to users' do
      expect(Reply.reflect_on_association(:user).macro).to be (:belongs_to)
    end

    it 'Reply has many user\'s in plural name' do
      expect(Reply.reflect_on_association(:user).plural_name).to eq ("users")
    end

    it 'Reply belongs to posts' do
      expect(Reply.reflect_on_association(:post).macro).to be (:belongs_to)
    end

    it 'Reply has many post\'s in plural name' do
      expect(Reply.reflect_on_association(:post).plural_name).to eq ("posts")
    end
  end


  it "is valid with a body, user_id, and post_id" do
    reply = Reply.new(
      body: 'Cookies are on the client-side(browser) and sessions are on the server-side',
      user_id: 2,
      post_id: 8)
    expect(reply).to be_valid
  end

  it "is invalid without a body" do
    reply = Reply.new(body: nil)
    reply.valid?
    expect(reply.errors[:body]).to include("can't be blank")
  end

  it "is invalid without a user_id" do
    reply = Reply.new(user_id: nil)
    reply.valid?
    expect(reply.errors[:user_id]).to include("can't be blank")
  end

  it "is invalid without a post_id" do
    reply = Reply.new(post_id: nil)
    reply.valid?
    expect(reply.errors[:post_id]).to include("can't be blank")
  end

  it "returns a reply's body as a string" do
    reply = Reply.new(body: 'Google Devise documentation')
    expect(reply.body).to be_a_kind_of(String)
  end

  it "returns user_id as an integer" do
    reply = Reply.new(user_id: 2)
    expect(reply.user_id).to be_a_kind_of(Integer)
  end

  it "returns post_id as an integer" do
    reply = Reply.new(post_id: 8)
    expect(reply.post_id).to be_a_kind_of(Integer)
  end

end
