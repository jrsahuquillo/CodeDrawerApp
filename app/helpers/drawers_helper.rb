module DrawersHelper
  def persisted_codetools(codetools)
    codetools.reject{ |codetool| codetool.new_record? }
  end

  def check_active_link(drawer_id)
    'active' if params[:drawer_id].to_i == drawer_id
  end

  def sorted_drawers
    current_user.drawers.sort_by(&:position)
  end

  def drawer_title(drawer)
    "#{drawer.title.truncate(50)}&nbsp;&nbsp;#{octicon 'organization' if drawer.friends.present?}".html_safe
  end

  def drawer_collaborators
    if @drawer.friends.present?
      drawer_friends = ""
      @drawer.friends.each do |friend|
        friend = friend.username
        drawer_friends << "#{content_tag :span, friend, class: 'badge badge-secondary'}&nbsp;"
      end
      "<span>Collaborators: #{drawer_friends}</span>".html_safe
    end
  end

end
