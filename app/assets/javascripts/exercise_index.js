$(document).ready(function(){



$('.ruby-button').click(function(){
  $("#js_exercises").hide()
  $("#exercises #ruby_exercises").toggle();
});

$('.js-button').click(function(){
  $("#ruby_exercises").hide();
  $("#exercises #js_exercises").toggle();
});



});
