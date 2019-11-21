$(document).ready(function(){
  $('#drawers-list').sortable({
    update: function(e, ui) {
      console.log($(this).sortable('serialize'));
      $.ajax({
        url: $(this).data("url"),
        type: "PATCH",
        data: $(this).sortable('serialize'),
      });
    }
  });
});
