require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers

  # This is needed to simulate a file upload in the #create/Cloudinary test
  include ActionDispatch::TestProcess

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
        process :index, method: :get
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
        get :show, params: {id: created_post}
        expect(response).to render_template("show")
      end

      it "assigns a new post to @post" do
        get :show, params: {id: created_post}
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
          process :destroy, method: :delete, params: {id: @deleted_post}
        }.to change(Post,:count).by(-1)
      end

      it "should redirect to posts index" do
        process :destroy, method: :delete, params: {id: @deleted_post}
        expect(response).to redirect_to posts_url
      end
    end

    describe "#create" do
      # users are defined in the spec/fixtures/ folder
      fixtures :users

      before do
        # Creation requires a signed in user
        sign_in users(:user_1)
      end

      cl_response = {
        "public_id" => "pjxlnrigoijmmeibdi0u",
        "version" => 1371750447,
        "signature" => "bfec72b23487654e964febf8b89fe5f4ce796c8c",
        "width" => 864,
        "height" => 576,
        "format" => "jpg",
        "resource_type" => "image",
        "created_at" => "2013-06-20T17:47:27Z",
        "bytes" => 120253,
        "type" => "upload",
        "url" =>
        "http://res.cloudinary.com/demo/image/upload/v1371750447/pjxlnrigoijmmeibdi0u.jpg",
        "secure_url"=>
        "https://res.cloudinary.com/demo/image/upload/v1371750447/pjxlnrigoijmmeibdi0u.jpg"
      }
      let!(:stub_cl_post) { stub_request(:post, /cloudinary.com/).to_return(
        status: 200, body: cl_response.to_json) }

      bt_response = {
        "data" => {
          "global_hash" => "900913",
          "hash"=> "ze6poY",
          "long_url"=> "http://google.com/",
          "new_hash"=> 0,
          "url"=> "http://bit.ly/ze6poY"
        },
        "status_code"=> 200,
        "status_txt"=> "OK"
      }
      # We expect that the code will generate this APi call.
      let!(:stub_bt_get) { stub_request(:get, /https...api.ssl.bitly.com.v3.shorten.*/).to_return(
        status: 200, body: bt_response.to_json) }

      it 'generates a Cloudinary call if an image is uploaded' do
        # This response format is documented at http://cloudinary.com/documentation/rails_image_upload

        file_io = fixture_file_upload 'files/bridgetroll.svg', 'image/svg'
        params = {post: ({content: 'hello world', title: 'this is great',
                          image: file_io})}

        expect do
          get :create, params: params
        end.to change {Post.count}.by(1)
        assert_requested stub_cl_post
      end

      it 'generates a Bitly call on successful save' do
        # This test uses the Webmock gem, to test for outgoing API calls
        # We need to mimic the API response of Bitly - this is an example response as shown at
        # https://dev.bitly.com/links.html#v3_shorten

        params = {post: ({content: 'hello world', title: 'this is great'})}

        expect do
          get :create, params: params
        end.to change {Post.count}.by(1)
        assert_requested stub_bt_get
      end
    end
  end
end
