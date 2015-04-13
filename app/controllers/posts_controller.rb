class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

# new method instantiates an empty instance of Post
# the empty instance of Post is presented to the user on the app/views/posts/new.html.erb
# new is associated with the HTTP GET action. It's just getting and displaying some data
  def new
    @post = Post.new
  end

    def create
      @post = current_user.posts.build(params.require(:post).permit(:title, :body))
      if @post.save # Active Record method that updates db with our @post object
        flash[:notice] = "Post was saved."
        redirect_to @post
      else
        flash[:error] = "There was an error saving the post. Please try again."
        render :new
      end
    end

  def edit
    @post = Post.find(params[:id])
  end

    def update
      @post = Post.find(params[:id])
      if @post.update_attributes(params.require(:post).permit(:title, :body))
        flash[:notice] = "Post was updated."
        redirect_to @post
      else
        flash[:error] = "There was an error saving the post. Please try again."
        render :edit
      end
  end
end