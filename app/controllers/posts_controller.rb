class PostsController < ApplicationController
  # the before_action filter calls require_sign_in before each
  # controller action except for :show
  before_action :require_sign_in, except: :show

  before_action :authorize_user, except: [:show, :new, :create]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    # @post = Post.new
    # @post.title = params[:post][:title]
    # @post.body = params[:post][:body]
    @topic = Topic.find(params[:topic_id])
    # @post.topic = @topic
    # above @post parameters mass assigned below
    # post_params is a private method def at bottom
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    # @post.title = params[:post][:title]
    # @post.body = params[:post][:body]
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render(:edit)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    # we call destroy on @post, if that call is successufl, we set a flash message and redirect the user to the posts index view. if destroy fails then we redirect the user to the show view using render :show
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to(@post.topic)
    else
      flash.now[:alert] = "There was an error deleting the post."
      render(:show)
    end
  end

  # private methods go below this line
  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user
    post = Post.find(params[:id])
    # We redirect the user unless they own the post they're attempting to modify, or they're an admin
    unless current_user == post.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to [post.topic, post]
    end
  end
end
