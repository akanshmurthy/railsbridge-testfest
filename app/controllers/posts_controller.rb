require 'posts_helper'

class PostsController < ApplicationController
  include PostsHelper

  def index
    @posts = Post.all
    render :index
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params.permit(:title, :content))
    @post.user_id = current_user.id
    if @post.save
      # Here is a potential place to add Twilio API call to send text messages

      # If a file was uploaded, we expect its IO stream to be in params[:post][:image], and
      # will store it in Cloudinary
      if post_params[:image].present?
        auth = {
          cloud_name: Rails.application.secrets.cloudinary_cloud_name,
          api_key:    Rails.application.secrets.cloudinary_api_key,
          api_secret: Rails.application.secrets.cloudinary_api_secret
        }
        
        #cl_resp = Cloudinary::Uploader.upload(params[:post][:image], auth)
      end
      
      # Construct the API URL here, taking care to use Rails.application.secrets.bitly_api_key and
      # Rails.application.secrets.bitly_username, for the login, and Rails route helpers the post's url
      bitly_url = "http://api.bitly.com/..."

      # Once the URL is constructed, you can use the simple GET call below, via the Net::HTTP library, to pass the test.
      # Note that in general, when using Net::HTTP, you have to think about handling all of its possible exceptions. An
      # easier option might be to investigate the use of a Bitly gem, for example, https://github.com/philnash/bitly
      # which abstracts out errors for you in a more readable way.
      
      # resp = JSON.parse(Net::HTTP.get URI(bitly_url))

      redirect_to posts_url
    else
      render @post.errors.full_messages
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params.permit(:title, :content))
      flash[:success] = "Post updated"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
