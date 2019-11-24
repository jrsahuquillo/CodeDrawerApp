$(document).ready(function(){

  collapseShowAfterEdit();

  $('.show-codetool').click(function () {
    var codetoolId = this.attributes['aria-controls'].value
    $('.octicon.octicon-chevron-down.' + codetoolId).toggleClass('rotated')
  });

  function collapseShowAfterEdit(){
    var params_referrer = document.referrer.split('/').slice(-2)
    if(params_referrer[1] == 'edit'){
      var codetoolItem = '#codetool' + params_referrer[0]
      $(codetoolItem).addClass('show')
      $('.octicon.octicon-chevron-down.codetool' + params_referrer[0]).addClass('rotated')
    }
  }

  $('#codetools-list').sortable({
    revert: true,
    cancel: ".ui-sortable-handle .codetool-content",
    update: function(e, ui) {
      $.ajax({
        url: $(this).data("url"),
        type: "PATCH",
        data: $(this).sortable('serialize'),
      });
    }
  });

});
