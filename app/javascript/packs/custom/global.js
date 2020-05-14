$(document).ready(function(){

  // CMD + Intro -> Quick save shortcut OR drawer-search scope
  $(document).keydown(function(e) {
    if(!(e.keyCode == 13 && (e.ctrlKey || e.metaKey))) return;
    var targetField = document.activeElement
    let target = e.target;
    if (targetField.attributes.name && targetField.attributes.name.value == "search") {
      $('.drawer-search').click();
    } else if (targetField.form) {
      if ($('.drawer-form').length > 0) {
        $("input:submit").click();
      } else {
        $("input:submit[value='Quick Save']").click();
      }
    }
  });

  // CRTL + F Search shortcut
  $(document).keydown(function(e) {
    if(!(e.keyCode == 70 && e.ctrlKey)) return;
    $('#search').val("").focus();
  });


  // Select2
  $( "#event_friend_ids" ).select2({
    placeholder: 'Select collaborators of your drawer',
    allowClear: true,
    multiple: true,
    theme: 'bootstrap'
  });

  $('.select2').blur(function() {
      $( "#event_friend_ids" ).select2("close");
  });

});
