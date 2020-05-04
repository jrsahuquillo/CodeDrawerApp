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
    "<div class='h4 text codetool-breadcrumb'> #{'Edition:' if action_name == "edit"}
      <span class='h6'> #{@drawer.title}: </span>
        <strong><small class='creator-badge'> #{@drawer.user.username} </small></strong>
      #{octicon "chevron-right", height: 18}
      <span class='h6'>#{@codetool.title}: </span>
        <strong><small class='creator-badge'> #{@codetool.user.username} </small></strong>
    </div>".html_safe
  end

  def show_codetool_page?
    controller_name == "codetools" && action_name == "show"
  end

  def recent_created_or_updated?(codetool)
    params[:show] == codetool.to_param
  end

  def disabled?
    @codetool.persisted? && @codetool.user != current_user
  end

end
