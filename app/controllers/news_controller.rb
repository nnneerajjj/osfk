class NewsController < ApplicationController
  load_and_authorize_resource :news, only: [:show, :edit, :update, :comment], find_by: :slug
  include NewsHelper

  def new
    @news = News.new
  end

  def index
    page = params[I18n.t(:page)] || 1
    @news = News.page(page)
  end

  def edit
  end

  def create
    news = News.new(params[:news])
    news.save
    flash[:notice] = "Du skapade nyheten #{news.subject}"
    render json: news
  end

  def update
    if @news.update_attributes(params[:news])
      flash[:notice] = "Du sparade nyheten"
    end
    render json: @news
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
