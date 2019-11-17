$(document).ready(function(){
  // CMD + Intro save shortcut
  $(document).keydown(function(e) {
    if(!(e.keyCode == 13 && e.metaKey)) return;
    var target = e.target;
    if(target.form) {
      target.form.submit();
    }
  });

});
