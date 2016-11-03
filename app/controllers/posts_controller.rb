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
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      # Here is a potential place to add Twilio API call to send text messages 

      # Construct the API URL here, taking care to use Rails.application.secrets.bitly_api_key and
      # Rails.application.secrets.bitly_username, for the login, and Rails route helpers the post's url
      bitly_url = "http://api.bitly.com/..."

      # You can use a simple get call via Net::HTTP like this, once the URL is constructed
      resp = JSON.parse(Net::HTTP.get URI(bitly_url))
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
    if @post.update_attributes(post_params)
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
    params.require(:post).permit(:title, :content)
  end
end
