class PageExistsConstraint
  def initialize
    # FIXME: Cache
    @slugs = Page.pluck(:slug)
  end

  def matches?(request)
    path = request.path
    path.slice!(0)
    @slugs.include?(path)
  end
end
