$(document).ready(function(){

  $('.show-codetool').click(function () {
    var codetoolId = this.attributes['aria-controls'].value
    $('.octicon.octicon-chevron-down.' + codetoolId).toggleClass('rotated')
  });
  
});
