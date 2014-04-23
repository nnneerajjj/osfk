module NewsHelper

  def most_recent_news
    @most_recent_news ||= begin
      scoped_news.limit(3)
    end
  end

  def scoped_news
    can?(:access, :admin) ? News.scoped : News.active
  end

end
