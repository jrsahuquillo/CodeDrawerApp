$(document).on('turbolinks:load',function(){

  //Codedrawer sorting
  $('#drawers-list').sortable({
    axis: "y",
    cursor: "move",
    opacity: 0.7,
    delay: 300,
    scroll: true,
    handle: '.drawer-list-icon',
    update: function(e, ui) {
      $.ajax({
        url: $(this).data("url"),
        type: "PATCH",
        data: $(this).sortable('serialize'),
      });
    }
  });

  // Rotate arrow icon when collapse collaborated drawer
  $('#collaborated-drawers-list').click(function () {
    $('.octicon.octicon-chevron-down').toggleClass('rotated')
  });
});
