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
    if (notification.notifiable["type"] == "Friendship") {
      $('#notifications .dropdown-menu').append(
        "<div class='dropdown-item' id='notification_" + notification.id + "'><small>" + notification.actor + " " + notification.action + " you</small></div>"
      );
    } else if (notification.notifiable["type"] == "Drawer") {
      $('#notifications .dropdown-menu').append(
        "<div class='dropdown-item' id='notification_" + notification.id + "'><small>" + notification.actor + " " + notification.action + " of a drawer</small></div>"
      );
    } else if (notification.notifiable["type"] == "FavoriteCodetool") {
      $('#notifications .dropdown-menu').append(
        "<div class='dropdown-item'id='notification_" + notification.id + "'><small>" + notification.actor + " " + notification.action + " one of your codetools</small></div>"
      );
    } else if (notification.notifiable["type"] == "User") {
      $('#notifications .dropdown-menu').append(
        "<div class='dropdown-item'id='notification_" + notification.id + "'><small> Welcome to notifications! </small></div>"
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
