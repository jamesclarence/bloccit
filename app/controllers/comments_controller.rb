class CommentsController < ApplicationController
  def create
    # create a new comment associated with a post and the current_user who created it
      @comment = Comment.new(params[:post_id])
      @comment = current_user.comments.build
  end
end
