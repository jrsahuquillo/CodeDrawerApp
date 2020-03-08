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
        "<div class='dropdown-item' id='notification_" + notification.id + "'>" + notification.actor + " " + notification.action + " you</div>"
      );
    } else if (notification.notifiable["type"] == "Drawer") {
      $('#notifications .dropdown-menu').append(
        "<div class='dropdown-item' id='notification_" + notification.id + "'>" + notification.actor + " " + notification.action + " of a drawer</div>"
      );
    } else if (notification.notifiable["type"] == "User") {
      $('#notifications .dropdown-menu').append(
        "<div class='dropdown-item'id='notification_" + notification.id + "'> Welcome to notifications! </div>"
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
