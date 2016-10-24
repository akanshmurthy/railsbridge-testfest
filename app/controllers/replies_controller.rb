class RepliesController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @reply = Reply.new
    render :new
  end

  def create
    @post = Post.find(params[:post_id])
    @reply = Reply.new(reply_params)
    @reply.user_id = current_user.id
    @reply.post_id = params[:post_id]
    if @reply.save
      redirect_to post_url(params[:post_id])
    else
      render @reply.errors.full_messages
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:body)
  end
end
