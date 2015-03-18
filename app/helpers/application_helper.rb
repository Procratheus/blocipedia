module ApplicationHelper

  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

  def can_mark_private?
    (current_user.role == "premium"&& (current_user.id == wiki.user_id || wiki.user_id == nil)) || (current_user.role == "admin")
  end
  

end
