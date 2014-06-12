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

  def letter_variable_content(letter, user)
    content = letter.content

    content.scan(/__.*?__/).each do |var|
      val = user.send(var.gsub('_', '')).to_s
      content = content.gsub(var, val)
    end

    content
  end
end
