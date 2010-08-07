require 'breadcrumb_list'

module ApplicationHelper
  def bread_crumbs
    @breadcrumbs ||= BreadcrumbList.new
  end
end
