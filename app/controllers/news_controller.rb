class NewsController < ApplicationController
  load_and_authorize_resource :news, only: :show
  include NewsHelper

  def index
    @news = scoped_news
  end

  def show
  end

  def comment
    @news = News.find_by_slug(params[:id])
    @comment = Comment.build_from( @news, current_user.id, params[:comment][:body] )
    @comment.save!

    return redirect_to news_path(@news.slug)
  end
end
