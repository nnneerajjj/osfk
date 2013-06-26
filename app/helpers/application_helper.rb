module ApplicationHelper
  def page(title)
    Page.find_by_title(title.downcase)
  end

  def in_commentable(commentable)
    return I18n.t(:in_thread) if commentable.kind_of? Topic

    I18n.t(:in_news)
  end
end
