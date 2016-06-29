$(document).ready(function() {
  defineEvents();
  displayIdeas();
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

function defineEvents() {
  $("#save-idea").on('submit', function(event) {
    event.preventDefault();
    createIdea();
    clearFields();
  });

  $(document).on('click', ".delete-idea", function() {
    deleteIdea($(this).data('id'));
  });

  // $(document).on('click', function() {
  //   updateIdea
  // });
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

  return '<li class="list-group-item" id="idea-' + id + '">' +
        '<h4 class="list-group-item-heading" data-title-id="' + id + '">' + title + '</h4>' +
        '<p class="list-group-item-text" data-body-id="' + id + '">' + body + '</p>' +
        '<p class="list-group-item-text">A <i>' + quality + '</i> idea!</p>' +
        '<div class="btn btn-primary" id="upvote-idea">Upvote</div>' +
        '<div class="btn btn-primary" id="downvote-idea">Downvote</div>' +
        '<button class="btn btn-primary delete-idea" data-id="' + id + '">Delete</button>' +
        '</li>';
}

function createIdea() {
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
}

function clearFields() {
  $('#IdeaTitle').val('');
  $('#IdeaBody').val('');
}


function deleteIdea(id) {
  $.ajax({
    method: "DELETE",
    url: '/api/v1/ideas/' + id,
    dataType: "JSON",
    success: function(id) {
      $('#idea-' + id).slideUp();
    }
  });
}

function editTitle() {
  $('#idea-body-show').on('click', function(event) {
    $(this).setAttribute("contenteditable"=false);
      editContent(this, { body: $(this).text(), id: $(this).data('body-id')});

  });

    // if (event.type === "blur" || event.type === keyCode 13) {
    // }

function editBody() {
  $('#idea-body-show').on('blur keydown', function(event) {
    if (event.type === "blur" || event.type === keyCode 13) {
      editContent(this, { body: $(this).text(), id: $(this).data('body-id')});
    }
  });
}
// edit/updateIdea
// setAttribute("contenteditable"=false) to title and body
// - on click: set to true
// - on enter (keyCode 13): set to false

// $('div').blur(function () {
//     $(this).attr('contenteditable', false);
// });
// $('div[contenteditable="true"]').attr('contenteditable', false);
