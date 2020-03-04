$(document).ready(function(){

  //Codedrawer sorting
  $('#drawers-list').sortable({
    update: function(e, ui) {
      // console.log($(this).sortable('serialize'));
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
