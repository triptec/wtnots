$('document').ready(function(){
  $('form#new_comment').hide();
  $('#toggle_new_comment').click(function() {
    $('form#new_comment').toggle("slow");
    return false;
  });
  $('.reply').live("click",function(event){
      if ($(this).next().attr("id") == "new_reply"){
        $(this).next().toggle("fast");
      }
      else{
      var p = $(this)
      var request = '/songs/' + p.attr("song_id") + '/comments/' + p.attr("comment_id") + '/reply';
      $.get(request, function(data){
        $(p).after(data);
        $(p).next().hide();
        $(p).next().toggle("fast");
        },'script');


      }
      event.preventDefault();
      return false;
    }
  );
  $('#new_comment').live("submit",function(){
    $.post($(this).attr('action'),$(this).serialize(),null,'script');
    $('form#new_comment').toggle("slow");
    $('textarea#comment_body').val("");
    return false;
  });
  $('#new_reply').live("submit", function(){
    $.post($(this).attr('action'),$(this).serialize(),null,'script');
    $(this).hide("fast",function(){$(this).remove();});
    return false;
  });
});
