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

  /////////////////////////////////////////////
  // ------- JS FOR RECIPE INDEX PAGE -------//
  /////////////////////////////////////////////


  // only loads all recipes if there are any
  if ($("#recipesInfo").length) {
    loadAllRecipes();
  }

  // Loads all the recipes with descriptions
  function loadAllRecipes(){
    $.ajax({ //Perform an asynchronous HTTP (Ajax) request.
      url: "/recipes.json",
      method: 'GET'
    })
    .then(function(data){
       let recipeArray = data;
       $.each(recipeArray, function(index, recipe){
           let recipeData = `<h4><a href='/recipes/${recipe.id}'> ${recipe.name}</a>,
                            ${recipe.upvotes} upvotes</h4><div id='description-${recipe.id}'>
                            <p>${recipe.description.substring(0, 120)}...
                            <a href='#' data-id=${recipe.id} class='js-more'>Read More</a>
                            </p></div><br>`
           $('#recipesInfo').append(recipeData);
         })
     });
  }

  // Displays the whole description when "read more" is clicked
  $("#recipesInfo").on('click', '.js-more', function(e){
    e.preventDefault();
    let id = this.dataset.id;
    $.get(`/recipes/${id}.json`, function(data){
      $(`#description-${id}`).html(data.description)
    });
  });


  ////////////////////////////////////////////
  // ------- JS FOR RECIPE SHOW PAGE -------//
  ////////////////////////////////////////////

  // Loads all the data from JS to the DOM
  function loadRecipe(data){
      // history.pushState({}, "", `/recipes/${data.id}`)

      $(".recipeName").text(data["name"]);
      $(".recipeUpvotes").text(data["upvotes"]);
      $(".recipeUser").text(data["user"]["name"]);
      $(".recipeDescription").text(data["description"]);
      $(".recipeDirections").text(data["directions"]);
      $(".js-next").attr("data-id", data["id"]);
      $(".js-previous").attr("data-id", data["id"]);

      $("#ri-original").empty();
      $("#ri-list").empty();
      data["recipe_ingredients"].forEach(function(recipeIngredient){
        let newRecipeIngredient = new RecipeIngredient(recipeIngredient);
        let recipeIngredientHtml = newRecipeIngredient.renderDisplay();
        $("#ri-list").append(recipeIngredientHtml);
      })

      let recipeReviewPath = `/recipes/${data.id}/reviews/`;
      $("#new_review").attr('action', recipeReviewPath);
      $("#submitted-reviews").empty();
      data["review_list"].forEach(function(review){
        let newReview = new Review(review);
        let reviewHtml = newReview.renderDisplay();
        $("#submitted-reviews").append(reviewHtml);
      });

  }

  // ES6 RecipeIngredient class (model object) initialized using constructor method
  class RecipeIngredient{
    constructor(data){
      this.id = data.id;
      this.name = data.name;
      this.quantity = data.quantity;
    }
  }

  // JS model object custom function for rendering display of RecipeIngredient
  RecipeIngredient.prototype.renderDisplay = function(){
    return (`<h4><a href='/ingredients/${this.id}'> ${this.name}</a>, ${this.quantity}</h4>`)
  }

  // NEXT button
  $(".js-next").on("click", function(e){
    let id = $(".js-next").attr("data-id")
    $.get(`/recipes/${id}/next`, function(data){
      loadRecipe(data);
    });
    e.preventDefault();
  });

  // PREVIOUS button
  $(".js-previous").on("click", function(e){
    let id = $(".js-previous").attr("data-id")
    $.get(`/recipes/${id}/previous`, function(data){
      loadRecipe(data);
    });
    e.preventDefault();
  });

  // ES6 Review class (model object) initialized using constructor method
  class Review{
    constructor(data){
    this.id = data.id;
    this.title = data.title;
    this.content = data.content;
    this.user = data.user;
    }
  }

  // JS model object custom function for rendering display of Review
  Review.prototype.renderDisplay = function(){
    return (`<div class="well well-white" id="review-${this.id}"><h4>${this.title}</h4><p>${this.content}</p><strong>- ${this.user.name}</strong></div>`)
  }

  // Form submitted throguh AJAX
  $(function() {
    $("form#new_review").on("submit", function(e){
      e.preventDefault();
      let $form = $(this);
      let action = $form.attr("action");
      let params = $form.serialize();
      $.ajax({
        url: action,
        data: params,
        method: "POST"
      })
      .success(function(review){
        let newReview = new Review(review);
        let reviewHtml = newReview.renderDisplay();
        $("#submitted-reviews").append(reviewHtml);
      })
    });
  })

});
