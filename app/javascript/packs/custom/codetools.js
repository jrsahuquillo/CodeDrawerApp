$(document).on('turbolinks:load', function () {

  // Rotate arrow icon when collapse codetools
  collapseShowAfterEdit();
  cursorAtEnd();
  $('.toast').toast({ delay: 3000 });
  $('.toast').toast('show')

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

  // Drag and drop codetools sorting
  $('#codetools-list').sortable({
    axis: "y",
    cursor: "move",
    opacity: 0.7,
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

  // Warning when a codetools is made public
  $publicCheckbox = $('#public_checkbox')
  $publicCheckbox.change(function(){
    if($publicCheckbox.prop('checked')) {
      message = confirm("Are you sure to make this Codetool public?");
      if(message) {
        return true;
      } else {
       return false;
      }
   } else {
     return true;
   }
  });

  // Copy codetools url to clipboard
  $('.link-codetool-icon').click(function(e){
    e.preventDefault;
    value = $(this).data('clipboard-text');
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val(value).select();
    document.execCommand("copy");
    $codetoolLink = $(this).children('.codetool-link')
    $codetoolCheck = $(this).children('.codetool-check')
    $codetoolLink.hide();
    $codetoolCheck.removeAttr('hidden');
    $(function () {
      setTimeout(function () {
        $codetoolLink.show();
        $codetoolCheck.attr('hidden', true);
      }, 1000);
    })
    $temp.remove();
  });

  // Put cursor at the end of textarea content when quick update.
  function cursorAtEnd() {
    var input = $('.edit_codetool textarea');
    if (input.length > 0) {
        var len = input.val().length;
        input[0].focus();
        input[0].setSelectionRange(len, len);
        input.animate({ scrollTop: input.prop("scrollHeight") }, 1000);
    }
  }

  $('.codetool-content').hover(function() {
    $(this).children('.extra-buttons').attr('hidden', false);
  }, function () {
    $(this).children('.extra-buttons').attr('hidden', true);
  })

});
