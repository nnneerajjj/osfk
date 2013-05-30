class ForumController < ApplicationController

  def index
    @topics = Topic.order('updated_at DESC')
  end

  def new
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
end