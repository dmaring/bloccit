class TopicsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_admin_moderator, only: [:edit, :update]
  before_action :authorize_admin, except: [:index, :show, :edit, :update]


  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    # @topic = Topic.new
    # @topic.name = params[:topic][:name]
    # @topic.description = params[:topic][:description]
    # @topic.public = params[:topic][:public]
    # assign above as strong parameters using mass assign and private
    # method located at bottom
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])

    # @topic.name = params[:topic][:name]
    # @topic.description = params[:topic][:description]
    # @topic.public = params[:topic][:public]
    # above attributes assigned via strong parameters by private method
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash.now[:alert] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      # redirect_to action: :index is the same as redirect_to topics_path because topics_path routes to the index action per Rails' resourceful routing.
      redirect_to action: :index
    else
      flash.now[:alert] = "There was ane error deleting the topic."
      render :show
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  def authorize_admin_moderator
    unless current_user.admin? || current_user.moderator?
      flash[:alert] = "You must be an admin or moderator to do that."
      redirect_to topics_path
    end
  end

  def authorize_admin
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to topics_path
    end
  end
end
