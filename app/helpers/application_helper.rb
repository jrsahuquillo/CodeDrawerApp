module ApplicationHelper

  def current_device
    agent = request.user_agent
    return "tablet" if agent =~ /(tablet|ipad)|(android(?!.*mobile))/i
    return "mobile" if agent =~ /Mobile/
    return "desktop"
  end

  def current_device_is_mobile?
    agent = request.user_agent
    agent =~ /Mobile/
  end

end
