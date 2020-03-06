json.array! @notifications do |notification|
  json.id           notification.id
  json.actor        notification.actor.username
  json.recipient    notification.recipient.username
  json.action       notification.action
  json.created_at   notification.created_at
  json.notifiable do
    json.type notification.notifiable.class.to_s
  end
  # json.url          root_path

end
