class TopicController < ApplicationController
  load_and_authorize_resource :topic, except: :create, find_by: :slug
  before_filter :load_roles, only: [ :new, :edit ]

  def index
    page = params[I18n.t(:page)] || 1
    @topics = @topics.order(updated_at: :desc).page(page)
  end

  def new
    @topic = Topic.new
    @roles = [["Medlemmar", Page::PRIVATE_PAGE_ID]] + current_user.roles.reverse.map { |role| [ role.display_name, role.id ] }
  end

  def show
  end

  def create
    @topic = Topic.new(role_params(:topic))
    @topic.user = current_user
    if @topic.save
      flash[:notice] = "Du skapade diskussionstråden #{@topic.subject}"
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
