module ApplicationHelper
  def active_class(options)
    current_page?(options) ? 'active' : nil
  end

  def link_with_icon(name, path, icon:)
    link_to path do
      fa_icon icon, text: name
    end
  end
end

