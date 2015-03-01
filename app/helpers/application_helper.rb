module ApplicationHelper

  def markdown_to_html(markdown)
    renderer = Redcarpet::Renderer::HTML.new
    extensions = { fenced_code_blocks: true}
    redcarpet = Redcarpet::Mardown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

end
