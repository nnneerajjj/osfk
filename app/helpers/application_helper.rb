module ApplicationHelper
  def page(title)
    Page.find_by_title(title.downcase)
  end
end
