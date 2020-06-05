$(document).on('turbolinks:load',function(){

  //Codedrawer sorting
  $('#drawers-list').sortable({
    axis: "y",
    cursor: "move",
    opacity: 0.7,
    revert: true,
    update: function(e, ui) {
      $.ajax({
        url: $(this).data("url"),
        type: "PATCH",
        data: $(this).sortable('serialize'),
      });
    }
  })
  .draggable({
    axis: "y",
    opacity: 0.5,
    scroll: true,
    delay: 500
  });

  // Rotate arrow icon when collapse collaborated drawer
  $('#collaborated-drawers-list').click(function () {
    $('.octicon.octicon-chevron-down').toggleClass('rotated')
  });
});
