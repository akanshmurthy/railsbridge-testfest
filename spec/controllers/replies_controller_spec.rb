require 'rails_helper'

RSpec.describe RepliesController, type: :controller do
  describe "RepliesController" do

    let(:reply) { Reply.new(
      body: 'ahahahahahahah',
      user_id: 10,
      post_id: 1,
      ) }

    let(:post) { Post.create(
      title: 'What is the difference between a cookie and a session?',
      user_id: 10,
      content: 'What are the diffences with these key/value pairs?',
      ) }

    describe '#new' do

      it "renders the new view" do
        get :new, :post_id => post.id
        expect(response).to render_template("new")
      end

      it "assigns a new reply to @reply" do
        get :new, :post_id => post.id
        expect(assigns(:reply)).to be_a_new(Reply)
      end

      it "renders html" do
        get :new, :post_id => post.id
        expect(response.content_type).to eq "text/html"
      end
    end

  end
end
