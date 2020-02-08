$(document).ready(function(){
  // CMD + Intro save shortcut
  $(document).keydown(function(e) {
    if(!(e.keyCode == 13 && (e.ctrlKey || e.metaKey))) return;
    var target = e.target;
    if(target.form) {
      target.form.submit();
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

  $('.select2').blur(function(e) {

      $( "#event_friend_ids" ).select2("close");

  });

});
