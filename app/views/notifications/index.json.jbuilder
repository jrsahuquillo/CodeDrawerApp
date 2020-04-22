json.array! @notifications do |notification|
  json.id           notification.id
  json.actor        notification.actor.username
  json.actor_path   user_public_codetools_path(notification.actor.id)
  json.recipient    notification.recipient.username
  json.action       notification.action
  json.created_at   notification.created_at
  json.notifiable do
    json.type   notification.notifiable.class.to_s
    json.path   notifiable_path(notification.notifiable)
    json.title  notifiable_title(notification.notifiable)
  end
end

def notifiable_path(item)
  type = item.class.to_s
  return drawer_codetool_path(item.codetool.drawer, item.codetool) if type == "FavoriteCodetool"
  return drawer_codetools_path(item) if type == "Drawer"
end

def notifiable_title(item)
  type = item.class.to_s
  return item.codetool.title if type == "FavoriteCodetool"
  return item.title if type == "Drawer"
end