module CodetoolsHelper
  require 'markdown_checkboxes'

  def markdown(content)
    parser = CheckboxMarkdown.new(
                        CustomRender,
                        fenced_code_blocks: true,
                        tables: true
                        )
    parser.render(content).html_safe
  end

  def codetool_breadcrumb_title
    "<div class='h3 text codetool-form'> Editing:
      <span class='h6'> #{@drawer.title}
        <small class='badge badge-secondary'> #{@drawer.user.username} </small>
      / #{@codetool.title}
        <small class='badge badge-secondary'> #{@codetool.user.username} </small>
      </span>
    </div>".html_safe
  end

end
