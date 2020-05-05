module NotificationsHelper

  def parse_notification(notification)
    type = notification&.notifiable_type
    actor = User.find(notification.actor_id) rescue nil
    action = notification&.action
    item_id =notification.notifiable_id
    if type == "Friendship"
      "<div>#{octicon 'calendar'} #{notification.created_at.strftime('%d-%m-%Y')} - <strong><a href='#{search_friends_path}' class='notification-badge'>#{actor&.username}<a></strong> #{action}.</div>".html_safe
    elsif type == "Drawer"
      drawer = Drawer.find(item_id) rescue nil
      "<div>#{octicon 'calendar'} #{notification.created_at.strftime('%d-%m-%Y')} - <strong><a href='#{search_friends_path}' class='notification-badge'>#{actor&.username}<a></strong> #{action} <strong><a href='#{drawer_codetools_path(drawer)}' class='notification-badge'>#{drawer.title}<a></strong></div>".html_safe unless drawer.nil?
    elsif type == "Codetool"
      codetool = Codetool.find(item_id) rescue nil
      "<div>#{octicon 'calendar'} #{notification.created_at.strftime('%d-%m-%Y')} - <strong><a href='#{search_friends_path}' class='notification-badge'>#{actor&.username}<a></strong> #{action} <strong><a href='#{drawer_codetool_path(codetool&.drawer, codetool)}' class='notification-badge'>#{codetool.title}<a></strong></div>".html_safe unless codetool.nil?
    elsif type == "FavoriteCodetool"
      favorite_codetool = FavoriteCodetool.find(item_id) rescue nil
      codetool = Codetool.find(favorite_codetool.codetool_id) rescue nil
      "<div>#{octicon 'calendar'} #{notification.created_at.strftime('%d-%m-%Y')} - <strong><a href='#{search_friends_path}' class='notification-badge'>#{actor&.username}<a></strong> #{action} <strong><a href='#{drawer_codetool_path(codetool&.drawer, codetool)}' class='notification-badge'>#{codetool.title}<a></strong></div>".html_safe unless codetool.nil?
    elsif type == "User"
      "<div>#{octicon 'calendar'} #{notification.created_at.strftime('%d-%m-%Y')} - <strong><a href='#{search_friends_path}' class='notification-badge'>#{actor&.username}<a></strong> #{action} <strong><a href='#{drawer_codetool_path(codetool&.drawer, codetool)}' class='notification-badge'>#{codetool.title}<a></strong></div>".html_safe unless codetool.nil?
    end
  end
end
