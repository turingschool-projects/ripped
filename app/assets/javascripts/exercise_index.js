$(document).ready(function(){

$('.ruby-button').click(function(){
  $("#js_exercises").hide()
  $("#exercises #ruby_exercises").removeAttr("style");
});

$('.js-button').click(function(){
  $("#ruby_exercises").hide();
  $("#exercises #js_exercises").removeAttr("style");
});



});
