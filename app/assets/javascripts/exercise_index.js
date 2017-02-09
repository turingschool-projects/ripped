$(document).ready(function(){


  $('.all-button').click(function(){
    $("#all-exercises").toggle();
    $("#ruby_exercises").hide();
    $("#js_exercises").hide();
  });

  $('.js-button').click(function(){
    $("#js_exercises").toggle();
    $("#ruby_exercises").hide();
    $("#all-exercises").hide();
  });

$('.ruby-button').click(function(){
  $("#ruby_exercises").toggle();
  $("#js_exercises").hide();
  $("#all-exercises").hide();
});





});
