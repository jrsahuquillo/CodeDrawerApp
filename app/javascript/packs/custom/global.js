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

});
