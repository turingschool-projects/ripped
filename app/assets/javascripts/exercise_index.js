$(document).ready(function(){

  $('.tag_buttons').click(function(event){
    event.preventDefault();
    $(this).toggleClass('active');
    var activeTags = $.map($('.tag_buttons.active'), function(element){
      return element.name;
    });

    $(this).blur();
    if(activeTags.length == 0){
      $('#all-exercises div').show();
      return
    }

    $('#all-exercises div').each(function(){
      var tags = $(this).attr('data-exercise').split(',');
      if ($(activeTags).not(tags).length === 0) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });
  });
});
