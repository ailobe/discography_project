module ApplicationHelper
  def not_current?(path, style)
    style unless !current_page?(path)
  end
end
