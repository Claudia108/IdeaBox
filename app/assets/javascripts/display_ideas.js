$(document).ready(function() {
  displayIdeas();
  createSubmitEventOnForm();
});


function displayIdeas() {
  $.ajax({
    method: "GET",
    url: "/api/v1/ideas",
    dataType: "JSON",
    success: function(response) {
      printIdeas(response);
    }
  });
}

function printIdeas(response) {
  response.forEach(function(idea) {
    $('.list-group').append(renderIdea(idea));
  });
}

function renderIdea(idea) {
  var title = idea.title;
  var body = idea.body;
  var quality = idea.quality;
  var id = idea.id;

  return '<li class="list-group-item">' +
        '<h4 class="list-group-item-heading">' + title + '</h4>' +
        '<p class="list-group-item-text">' + body + '</p>' +
        '<p class="list-group-item-text">A <i>' + quality + '</i> idea!</p>' +
        '<div class="btn btn-primary" id="upvote-idea">Upvote</div>' +
        '<div class="btn btn-primary" id="downvote-idea">Downvote</div>' +
        '<div class="btn btn-primary delete-idea" data-id="' + id + '">Delete</div>' +
        '</li>';
}

  function createSubmitEventOnForm() {
    $("#save-idea").on('submit', function(event) {
      event.preventDefault();

    var title = $('#IdeaTitle').val();
    var body = $('#IdeaBody').val();
      $.ajax({
        method: "POST",
        url: "/api/v1/ideas",
        dataType: "JSON",
        data: {
          idea: {
            title: title,
            body: body
          }
        },
        success: function(idea){
          $('.ideas').prepend(renderIdea(idea));
        }
      });
  });
  }
