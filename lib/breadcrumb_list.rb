class BreadcrumbList
  def list 
    @crumbs ||= []  # FIXME this persists between requests! OMGWTFBBQ!
  end
  def list=(val)
    @crumbs = val
  end
end

