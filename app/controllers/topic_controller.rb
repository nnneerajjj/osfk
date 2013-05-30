class TopicController < ApplicationController
  load_and_authorize_resource :topic

  def index
    @topics = Topic.order('updated_at DESC')
  end

  def new
  end

  def show

  end

  def create
    @topic = Topic.new(params[:topic])
    @topic.user = current_user
    if @topic.save
      return redirect_to topic_index_path
    else
      render action: :new
    end
  end

  def comment
    @comment = Comment.build_from( @topic, @current_user.id, params[:comment][:body] )
    @comment.save!

    return redirect_to topic_path(@topic.id)
  end
end