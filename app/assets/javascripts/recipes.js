$(document).ready(function(){
  $("a.load_reviews").on("click", function(e){
    $.get(this.href).success(function(response){
      $("div.reviews").html(response)
    })
    e.preventDefault();
  });
})
