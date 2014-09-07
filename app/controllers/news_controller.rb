class NewsController < ApplicationController
  load_and_authorize_resource :news, only: [:show, :comment], find_by: :slug
  include NewsHelper

  def new
  end

  def index
    page = params[I18n.t(:page)] || 1
    @news = News.page(page)
  end

  def create
    pp params
  end

  def show
  end

  def comment
    @comment = Comment.build_from( @news, current_user.id, params[:comment][:body] )
    @comment.save!

    return redirect_to news_path(@news.slug)
  end
end
