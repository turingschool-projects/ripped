$(document).ready(function(){

  $('.tag_buttons').click(function(e){
    e.preventDefault();
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
      var match = false;
      activeTags.forEach(function(tag){
        if(tags.includes(tag)){
          match = true;
        }
      });
      if(match) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });
  });
});
