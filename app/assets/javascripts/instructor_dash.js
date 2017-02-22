$(document).ready(function(){

  $('.cohort_buttons').click(function(e){
    e.preventDefault();
    $(this).toggleClass('active');
    var activeCohorts = $.map($('.cohort_buttons.active'), function(element){
      return element.name;
    });

    $(this).blur();
    if(activeCohorts.length == 0){
      $('#all-solutions div').show();
      return
    }

    $('#all-submitted div').each(function(){
      var cohorts = $(this).attr('data-solution').split(',');
      var match = false;
      activeCohorts.forEach(function(cohort){
        if(cohorts.includes(cohort)){
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
