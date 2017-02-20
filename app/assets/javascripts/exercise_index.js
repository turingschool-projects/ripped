$(document).ready(function(){

  $('.tag_buttons').click(function(e){
    e.preventDefault();
    // alert(this.name);
    var tag = this.name;
    $('#all-exercises div').each(function(){
      var tags = $(this).attr('data-exercise').split(',');
      if(tags.includes(tag)) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });
  });
});
