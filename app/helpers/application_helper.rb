module ApplicationHelper

  def current_device
    agent = request.user_agent
    return "tablet" if agent =~ /(tablet|ipad)|(android(?!.*mobile))/i
    return "mobile" if agent =~ /Mobile/
    return "desktop"
  end

  def current_device_is_mobile?
    agent = request.user_agent
    return false if agent =~ /iPad/
    agent =~ /Mobile/
  end

  def set_item_time(item)
    if item.updated_at == item.created_at
      state = "Created"
      time_ago = item.created_at
    else
      state = "Updated"
      time_ago = item.updated_at
    end
    render inline: "#{state} #{time_ago_in_words(time_ago)} ago by #{item.user.username}"
  end

  def type_of_container
    devise_page? ? "container" : "container-fluid"
  end

  def devise_page?
    controller_name == "sessions" || controller_name == "registrations" || controller_name == "passwords"
  end

  def avatar(user)
    if user.image.present?
      image_tag "#{user.image}", class: 'avatar'
    else
      octicon 'person', height: 24, class: 'avatar'
    end
  end

end
