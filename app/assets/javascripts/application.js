// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require_tree .

$(function(){
  var recipeArray = [];
  var id = parseInt($(".js-next").attr("data-id"));

  if ($("#recipesInfo").length) {
    loadAllRecipes();
  }

  function loadAllRecipes(){
    $.ajax({
      url: "/recipes.json",
      method: 'GET'
    })
    .then(function(data){
       recipeArray = data;
       $.each(
         recipeArray, function(index, recipe){
           var recipeData = "<h4><a href='/recipes/" + recipe.id + "'>"
            + recipe.name + "</a>, " + recipe.upvotes + " upvotes</h4>"
            + "<div id='description-" + recipe.id + "'>"
            + recipe.description.substring(0, 120) + "..."
            + "<a href='#' data-id='" + recipe.id + "' class='js-more'>Read More</a></div><br>";
           $('#recipesInfo').append(recipeData);
         }
       )
     });
  }

  $("#recipesInfo").on('click', '.js-more', function(e){
    e.preventDefault();
    var id = this.dataset.id;
    $.get("/recipes/" + id + ".json", function(data){
      $("#description-" + id).html(data.description)
    });
  });


  function loadRecipe(data){
      history.pushState({}, "", "/recipes/" + data.id)
      var recipeReviewPath = '/recipes/' + data.id + '/reviews/';
      $("#new_review").attr('action', recipeReviewPath);
      $(".recipeName").text(data["name"]);
      $(".recipeUpvotes").text(data["upvotes"]);
      $(".recipeUser").text(data["user"]["name"]);
      $(".recipeDescription").text(data["description"]);
      $(".recipeDirections").text(data["directions"]);
      // $("#recipe-ingredients-list").empty();
      // data["ingredient_list"].forEach(function(element){
      //   var ri = new RecipeIngredient(element);
      //   ri.renderDisplay
      // })
      $(".js-next").attr("data-id", data["id"]);
      $(".js-previous").attr("data-id", data["id"]);
      $("#submitted-reviews").empty();
      data["review_list"].forEach(function(element){
        var review = new Review(element);
        review.renderDisplay();
      });

  }


  $(".js-next").on("click", function(e){
    var id = $(".js-next").attr("data-id")
    $.get("/recipes/" + id + "/next", function(data){
      console.log(data)
      loadRecipe(data);
    });
    e.preventDefault();
  });

  $(".js-previous").on("click", function(e){
    var id = $(".js-previous").attr("data-id")
    $.get("/recipes/" + id + "/previous", function(data){
      console.log(data)
      loadRecipe(data);
    });
    e.preventDefault();

  });

});


function Review(data){
  this.id = data.id;
  this.title = data.title;
  this.content = data.content;
  this.user = data.user;
}

Review.prototype.renderDisplay = function(){
  var html = "" ;
  html += "<div class=\'well well-white\' id=\'review-\' + review.id + '\'>" + '<h4>' + this.title + '</h4>' + '<p>' + this.content + '</p>' + '<strong>' + '- ' + 'Me'+ '</strong>' + "</div>";
    $("#submitted-reviews").append(html);
}

$(function() {
  $("form#new_review").on("submit", function(e){
    e.preventDefault();
    var $form = $(this);
    var action = $form.attr("action");
    var params = $form.serialize();
    $.ajax({
      url: action,
      data: params,
      dataType: "json",
      method: "POST"
    })
    .success(function(json){
      $(".reviewBox").val("");
      var review = new Review(json);
      review.renderDisplay();
    })
  })
})
