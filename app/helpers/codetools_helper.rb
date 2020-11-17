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
    "<div class='h4 text codetool-breadcrumb'>#{'Edition:' if action_name == "edit"}
      <a href='#{drawer_codetools_path(@drawer)}' class='creator-badge'><span class='h5'> #{@drawer.title} </span>
        <strong><small> (#{@drawer.user.username}) </small></strong></a>
      #{octicon "chevron-right", height: 18}
      <a href='#{drawer_codetool_path(@drawer, @codetool)}' class='creator-badge'> <span class='h5'>#{@codetool.title} </span>
        <strong><small> (#{@codetool.user.username}) </small></strong></a>
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

  def favorite_codetools_page?
    controller_name == "favorite_codetools"
  end

  def index_codetools_page?
    controller_name == "codetools" && action_name == "index"
  end

  def display_data(codetool_data)
    if params[:search]
      split_character = params[:search]&.include?('&') ? '&' : ','
      markdown(highlight(codetool_data, params[:search]&.split(split_character).collect(&:strip)))
    else
      markdown(codetool_data)
    end
  end

end
