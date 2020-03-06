$(document).on('turbolinks:load',function(){

  //GET notifications
  $.get('/notifications.json', function(data, status) {
    if(data.length > 0) {
      var total_notifications = data.length
      $('.notifications-badge').text(total_notifications);
      for(var i = 0; i < total_notifications; i++) {
        if (data[i].notifiable["type"] == "Friendship") {
          $('#notifications .dropdown-menu').append(
            "<div class='dropdown-item' id='notification_" + data[i].id + "'>" + data[i].actor + " " + data[i].action + " you</div>"
          );
        } else if (data[i].notifiable["type"] == "Drawer") {
          $('#notifications .dropdown-menu').append(
            "<div class='dropdown-item' id='notification_" + data[i].id + "'>" + data[i].actor + " " + data[i].action + " of a drawer</div>"
          );
        }

      }
    }
  });

  //POST read notifications
  $('#notifications').on('click', function() {
    $.post('/notifications/mark_as_read');
    setTimeout(function() {
      $('.notifications-badge').hide();
    }, 2000);
  });
});
