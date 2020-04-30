module CodetoolsHelper
  require 'markdown_checkboxes'

  def markdown(content)
    parser = CheckboxMarkdown.new(
                        CustomRender,
                        fenced_code_blocks: true,
                        tables: true,
                        strikethrough: true
                        )
    parser.render(content).html_safe
  end


  def codetool_breadcrumb_title
    badge_style = @drawer.user == current_user ? 'warning' : 'secondary'
    "<div class='h3 text codetool-breadcrumb'> #{'Edition:' if params[:action] == "edit"}
      <span class='h6'> #{@drawer.title}
        <small class='badge badge-#{badge_style}'> #{@drawer.user.username} </small>
      / #{@codetool.title}
        <small class='badge badge-#{badge_style}'> #{@codetool.user.username} </small>
      </span>
    </div>".html_safe
  end

  def show_codetool_page?
    params[:controller] == "codetools" && params[:action] == "show"
  end

  def recent_created_or_updated?(codetool)
    params[:show] == codetool.to_param
  end

  def disabled?
    @codetool.persisted? && @codetool.user != current_user
  end

end
