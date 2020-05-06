$(document).on('turbolinks:load',function(){
  //GET notifications
  $.get('/notifications.json', function(data, status) {
    displayNotifications(data);
  });

  function displayNotifications(data) {
    if (data.length > 0) {
      var total_notifications = data.length
      $('.notifications-badge').text(total_notifications);

      for(var i = 0; i < total_notifications; i++) {
        filterNotifications(data[i]);
      };
    };
  };

  function filterNotifications(notification) {
    var common_html = "<div class='dropdown-item' id='notification_" + notification.id + "'><small><strong><a href=" + notification.actor_path + " class='notification-badge'> " + notification.actor + "</a></strong> " + notification.action

    if (notification.notifiable["type"] == "Friendship") {
      $('#notifications .dropdown-menu').append(
        common_html + " you</small></div>"
      );
    } else if (notification.notifiable["type"] == "Drawer") {
      if (notification.action == "added you as collaborator of") {
        $('#notifications .dropdown-menu').append(
          common_html + "<a href=" + notification.notifiable['path'] + " class='notification-badge'> " + notification.notifiable['title'] + "</a></small></div>"
        );
      } else {
        $('#notifications .dropdown-menu').append(
          common_html + " <strong>" + notification.notifiable['title'] + "</strong></small></div>"
        );
      }
    } else if (notification.notifiable["type"] == "FavoriteCodetool") {
      $('#notifications .dropdown-menu').append(
        common_html + "<strong><a href=" + notification.notifiable['path'] + " class='notification-badge'> " + notification.notifiable['title'] + "</a></strong></small></div>"
      );
    } else if (notification.notifiable["type"] == "Codetool") {
      $('#notifications .dropdown-menu').append(
        common_html + "<strong><a href=" + notification.notifiable['path'] + " class='notification-badge'> " + notification.notifiable['title'] + "</a></strong></small></div>"
      );
    } else if (notification.notifiable["type"] == "User") {
      $('#notifications .dropdown-menu').append(
        "<div class='dropdown-item' id='notification_" + notification.id + "'><small> Welcome to notifications! </small></div>"
      );
    }
  };

  //POST read notifications
  $('#notifications').on('click', function() {
    $.post('/notifications/mark_as_read');
    setTimeout(function() {
      $('.notifications-badge').hide();
    }, 2000);
  });
});
