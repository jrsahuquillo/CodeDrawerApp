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

  def collaborated_drawers
    current_user.collaborated_drawers
  end

  def drawer_collaborators
    if @drawer.friends.present?
      drawer_friends = ""
      @drawer.friends.each_with_index do |friend, index|
        drawer_friends << "#{ link_to (content_tag :span, friend.username, class: 'collaborator-badge'), user_public_codetools_path(friend.id)}"
        drawer_friends << ", &nbsp;" if @drawer.friends[index + 1].present?
      end
      "<span> | Collaborators: <strong>#{drawer_friends}</strong></span>".html_safe
    end
  end

  def current_drawer_collaborated?
    collaborated_drawers.map(&:id).include?(params[:drawer_id].to_i)
  end
end
