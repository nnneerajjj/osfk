class TopicController < ApplicationController
  load_and_authorize_resource :topic, except: :create, find_by: :slug

  def index
    page = params[I18n.t(:page)] || 1
    @topics = Topic.order('updated_at DESC').page(page)
  end

  def new
    @topic = Topic.new
  end

  def show

  end

  def create
    @topic = Topic.new(params[:topic])
    @topic.user = current_user
    if @topic.save
      flash[:success] = "Du skapade diskussionstråden #{@topic.subject}"
      return redirect_to topic_index_path
    else
      render :new
    end
  end

  def comment
    @comment = Comment.build_from( @topic, current_user.id, params[:comment][:body] )
    @comment.save!

    return redirect_to topic_path(@topic.slug)
  end
end
