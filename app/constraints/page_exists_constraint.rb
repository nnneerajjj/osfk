class PageExistsConstraint
  def matches?(request)
    @slugs = Page.pluck(:slug)
    path = request.path
    path.slice!(0)
    @slugs.include?(path)
  end
end
