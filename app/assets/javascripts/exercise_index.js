$(document).ready(function(){


  $('.all-button').click(function(){
    $("#all-exercises").show();
    $("#ruby_exercises").hide();
    $("#js_exercises").hide();
  });

  $('.js-button').click(function(){
    $("#js_exercises").show();
    $("#ruby_exercises").hide();
    $("#all-exercises").hide();
  });

$('.ruby-button').click(function(){
  $("#ruby_exercises").show();
  $("#js_exercises").hide();
  $("#all-exercises").hide();
});





});
