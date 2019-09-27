module CodetoolsHelper

  def markdown(content)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(content).html_safe
  end

end
