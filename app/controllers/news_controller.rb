class NewsController < ApplicationController
  load_and_authorize_resource :news, except: [:new, :create], find_by: :slug
  before_filter :load_roles, only: [ :new, :edit ]
  include NewsHelper

  def new
    @news = News.new
  end

  def index
    page = params[t(:page)] || 1
    @news = @news.includes(:image_uploads).page(page)
  end

  def edit
  end

  def create
    news = News.new(role_params(:news))
    news.save
    flash[:notice] = "Du skapade nyheten #{news.subject}"
    render json: news
  end

  def update
    if @news.update_attributes(role_params(:news))
      flash[:notice] = "Du sparade nyheten"
    end
    render json: @news
  end

  def destroy
    @news.destroy
    flash[:notice] = "Du tog bort nyheten."
    redirect_to action: :index
  end

  def create_letter
    letter = Letter.new
    letter.subject = @news.subject
    letter.content = @news.content
    letter.user = current_user
    letter.link = news_url(@news)
    letter.save!
    flash[:notice] = "Du skapade upp brevet från nyheten."
    return redirect_to letter_path(letter)
  end

  def show
  end

  def comment
    @comment = Comment.build_from( @news, current_user.id, params[:comment][:body] )
    @comment.save!

    flash[:notice] = "Du kommenterade nyheten #{@news.subject}"

    return redirect_to news_path(@news.slug)
  end
end
