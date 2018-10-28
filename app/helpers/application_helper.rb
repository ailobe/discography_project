module ApplicationHelper
  def current?(path, style)
  unless !current_page?(path)
    style
  end
  end
end
