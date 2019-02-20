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

  // RECIPE index

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
       recipeArray.sort()
     });
  }

  $("#recipesInfo").on('click', '.js-more', function(e){
    e.preventDefault();
    var id = this.dataset.id;
    $.get("/recipes/" + id + ".json", function(data){
      $("#description-" + id).html(data.description)
    });
  });

// RECIPE show

  function loadRecipe(data){
      history.pushState({}, "", "/recipes/" + data.id)
      var recipeReviewPath = '/recipes/' + data.id + '/reviews/';
      $("#new_review").attr('action', recipeReviewPath);
      $(".recipeName").text(data["name"]);
      $(".recipeUpvotes").text(data["upvotes"]);
      // // $("#author").empty();
      // var author = new Author(data["user"])
      // author.renderDisplay
      $(".recipeUser").text(data["user"]["name"]);
      $(".recipeDescription").text(data["description"]);
      $(".recipeDirections").text(data["directions"]);
      $("#ri-original").empty();
      $("#ri-list").empty();
      data["recipe_ingredients"].forEach(function(element){
        var ri = new RecipeIngredient(element);
        ri.renderDisplay();
      })
      $(".js-next").attr("data-id", data["id"]);
      $(".js-previous").attr("data-id", data["id"]);
      $("#submitted-reviews").empty();
      data["review_list"].forEach(function(element){
        var review = new Review(element);
        review.renderDisplay();
      });
  }

  // function Author(data){
  //   this.author = data.name;
  // }
  //
  // Author.prototype.renderDisplay = function(){
  //   var authorHtml = "";
  //   authorHtml += "this.author"
  //   $("#author").append(authorHtml)
  // }

  function RecipeIngredient(data){
    this.id = data.id;
    this.name = data.name;
    this.quantity = data.quantity;
  }

  RecipeIngredient.prototype.renderDisplay = function(){
    var html = "" ;
    html += "<h4>" + "<a href='/ingredients/" + this.id + "'>" + this.name + "</a>"+ ", " + this.quantity+"</h4>"
    // "<div class=\"ri\"><h4><a href=\"ingredients/" + this.id + ">" + this.name + "</a> heheh</h4></div>";
      $("#ri-list").append(html);
  }

// NEXT button

  $(".js-next").on("click", function(e){
    var id = $(".js-next").attr("data-id")
    $.get("/recipes/" + id + "/next", function(data){
      console.log(data)
      loadRecipe(data);
    });
    e.preventDefault();
  });

// PREVIOUS button
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
  html += "<div class=\'well well-white\' id=\'review-\' + review.id + '\'>" + '<h4>' + this.title + '</h4>' + '<p>' + this.content + '</p>' + '<strong>' + '- ' + "<a href='/users/" + this.user.id + "/recipes'>" + this.user.name + "</a>" + '</strong>' + "</div>";
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
