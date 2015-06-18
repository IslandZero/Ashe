module ApplicationHelper

  def li_link(link_text, link_path, &block)
    if link_text.nil?
      content_tag(:li, class: ('active' if current_page?(link_path)) ) do
        link_to link_path, &block
      end
    else
      content_tag(:li, class: ('active' if current_page?(link_path)) ) do
        link_to link_text, link_path
      end
    end
  end

end
