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

  def edit_text_tags(instance, attribute)
    if can? :access, :admin
      "class='text-edit' data-type='#{instance.class.to_s.downcase}' data-id='#{instance.id}' data-attr='#{attribute}'".html_safe
    end
  end
end
