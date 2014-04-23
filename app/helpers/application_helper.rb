module ApplicationHelper

  def page(title)
    Page.find_by_title(title.downcase)
  end

  def in_commentable(commentable)
    return I18n.t(:in_thread) if commentable.kind_of? Topic

    I18n.t(:in_news)
  end

  def fix_number(number)
    return "" unless number.present?
    return "&nbsp;#{number}".html_safe if number < 10
    number.to_s.html_safe
  end
end
