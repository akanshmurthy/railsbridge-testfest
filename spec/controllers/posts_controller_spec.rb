require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "PostsController" do
    let(:posts) { [ Post.new(
      title: 'What is the difference between a cookie and a session?',
      user_id: 8,
      content: 'What are the diffences with these key/value pairs?',
      ), Post.new(
      title: 'What is the difference between a monster and a princess?',
      user_id: 9,
      content: 'What are the diffences with these banana/apple fruits?')
      ] }

    let(:post) { [ Post.new(
      title: 'What is the difference between a cookie and a session?',
      user_id: 10,
      content: 'What are the diffences with these key/value pairs?',
      ) ] }

    describe '#index' do

      it "renders the index view" do
        get :index
        expect(response).to render_template("index")
      end

      it "renders html" do
        get :index
        expect(response.content_type).to eq "text/html"
      end

    end

    describe '#new' do

      it "renders the new view" do
        get :new
        expect(response).to render_template("new")
      end

      it "assigns a new post to @post" do
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "renders html" do
        get :new
        expect(response.content_type).to eq "text/html"
      end
    end

    describe '#show' do
      let(:created_post) { [ Post.create(
        title: 'What is the difference between a cookie and a session?',
        user_id: 10,
        content: 'What are the diffences with these key/value pairs?',
        ) ] }

      it "renders the show view" do
        get :show, id: created_post
        expect(response).to render_template("show")
      end

      it "assigns a new post to @post" do
        get :show, id: created_post
        expect(assigns(:post)).to eq(created_post)
      end
    end

    describe '#delete' do
      before :each do
        @deleted_post = Post.create(
          title: 'What is the between a cookie and a session?',
          user_id: 11,
          content: 'What are the with these key/value pairs?',
          )
      end

      it "should delete the post" do
        expect{
          delete :destroy, id: @deleted_post
        }.to change(Post,:count).by(-1)
      end

      it "should redirect to posts index" do
        delete :destroy, id: @deleted_post
        expect(response).to redirect_to posts_url
      end
    end

  end
end
