$(document).ready(function(){
  $("#edit_post").on("click", function(event){
    event.preventDefault();

    var url = $(this).attr("href");
    var request = $.ajax({
      url: url,
      method: "get"});

    request.done(function(response) {
      $("#edit_post").hide();
      $("#edit_post_form").html(response);
    });

    request.error(function(response) {
      console.log("error");
      console.log(response);
    });
  });

  $(document).on("submit", ".edit_post", function(){
    event.preventDefault();

    console.log("bound");
    var url = $(this).attr("action");
    var data = $(this).serialize();

    var request = $.ajax({
      url: url,
      method: "put",
      data: data});

    request.done(function(response) {
      $("#edit_post").show();
      $("#edit_post_form").empty();

      $("#title").text(response.title);
      $("#body").text(response.body);
      $("#tags").empty();

      $.each(response.tags, function(index, tag){
        $("#tags").append("<li>" + tag.text + "</li>");
      });
    });

    request.error(function(response) {
      console.log("error");
      console.log(response);
    });
  });
});