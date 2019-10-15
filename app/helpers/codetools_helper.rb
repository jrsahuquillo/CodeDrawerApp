module CodetoolsHelper

  def markdown(content)
    Redcarpet::Markdown.new(CustomRender, fenced_code_blocks: true).render(content).html_safe
  end

end
