class PostsController < ApplicationController

  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
  end

# new method instantiates an empty instance of Post
# the empty instance of Post is presented to the user on the app/views/posts/new.html.erb
# new is associated with the HTTP GET action. It's just getting and displaying some data
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

    def create
      @topic = Topic.find(params[:topic_id])
      @post = current_user.posts.build(post_params)
      @post.topic = @topic
      authorize @post

      if @post.save # Active Record method that updates db with our @post object
        flash[:notice] = "Post was saved."
        redirect_to [@topic, @post]
      else
        flash[:error] = "There was an error saving the post. Please try again."
        render :new
      end
    end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

    def update
      @topic = Topic.find(params[:topic_id])
      @post = Post.find(params[:id])
      authorize @post
      
      if @post.update_attributes(post_params)
        flash[:notice] = "Post was updated."
        redirect_to @post
      else
        flash[:error] = "There was an error saving the post. Please try again."
        render :edit
      end
    end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end