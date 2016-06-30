$(document).ready(function() {
  updateTitle();
  defineEvents();
  displayIdeas();
  updateBody();
  upvoteQuality();
  downvoteQuality();
  searchIdeas();
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
  var body = shorten(idea.body);
  var quality = idea.quality;
  var id = idea.id;

  return '<li class="list-group-item" id="idea-' + id + '">' +
        '<h3 class="list-group-item-heading">' +
        '<div class="title" data-title-id="' + id + '">' + title +
        '</div></h3>' +
        '<h4 class="list-group-item-text">' +
        '<div class="body" data-body-id="' + id + '">'+ body +
        '</div></h4><br>' +
        '<p class="list-group-item-text">' +
        'What a <b>' + quality + '</b> idea! ' +

        '<a><span class="glyphicon glyphicon-thumbs-up upvote"' +
        'data-quality-id="' + id + '" data-quality="' + quality +
        '" aria-hidden="true"></span>' + ' ' +
        '<span class="glyphicon glyphicon-thumbs-down downvote"' +
        'data-quality-id="' + id + '" data-quality="' + quality +
        '" aria-hidden="true"></span></a></p>' + '<br>' +
        '<button class="btn btn-primary delete-idea" data-id="' + id +
        '">Delete</button>' +
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
      $('.list-group').prepend(renderIdea(idea));
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

function updateTitle() {
  $('.list-group').on('click', '.title', function(event) {
    $(this).attr('contenteditable', 'true');
    $(this).on('blur keydown', function(event) {
      if(event.type === "blur" || event.keyCode === 13) {
        updateIdea({ title: $(this).text(), id: $(this).data('title-id')});
      }
    });
  });
}

function updateBody() {
  $('.list-group').on('click', '.body', function(event) {
    $(this).attr('contenteditable', 'true');
    $(this).on('blur keydown', function(event) {
      if(event.type === "blur" || event.keyCode === 13) {
        updateIdea( { body: $(this).text(), id: $(this).data('body-id')});
      }
    });
  });
}

function updateIdea(updatedContent) {
  $.ajax({
    method: "PATCH",
    url: '/api/v1/ideas/' + updatedContent.id,
    dataType: "JSON",
    data: {
      idea: {
        title: updatedContent.title,
        body: updatedContent.body
      }
    },
    success: function(data) {
      $("#idea-" + data.id).replaceWith(renderIdea(data));
    }
  });
}

function upvoteQuality() {
  $('.list-group').on('click', '.upvote', function(event) {
    var ideaId = $(this).data('quality-id');
    var currentQuality = $(this).data('quality');
    var newQuality = upQuality(currentQuality);
    updateQuality(ideaId, newQuality);
  });
}

function upQuality(currentQuality) {
  if (currentQuality === "swill") {
    return 1;
  } else if ( currentQuality === "plausible") {
    return 2;
  } else if ( currentQuality === "genius") {
    return 2;
  }
}


function downvoteQuality() {
  $('.list-group').on('click', '.downvote', function(event) {
    var ideaId = $(this).data('quality-id');
    var currentQuality = $(this).data('quality');
    var newQuality = downQuality(currentQuality);
    updateQuality(ideaId, newQuality);
  });
}

function downQuality(currentQuality) {
  if (currentQuality === "swill") {
    return 0;
  } else if ( currentQuality === "plausible") {
    return 0;
  } else if ( currentQuality === "genius") {
    return 1;
  }
}


function updateQuality(ideaId, newQuality) {
  $.ajax({
    method: "PATCH",
    url: '/api/v1/ideas/' + ideaId,
    data: {
      idea: {quality: newQuality }
    },
    success: function(data) {
      $("#idea-" + data.id).replaceWith(renderIdea(data));
    }
  });
}

function searchIdeas(){
  $('#search-text').on('keyup', function(){
    var searchTerm = $(this).val().toLowerCase();

    $(".list-group-item").each(function(_index, idea){
      var title = $(this).children().children('.title').text().toLowerCase();
      var body = $(this).children().children('.body').text().toLowerCase();

      if (title.match(searchTerm) || body.match(searchTerm)) {
        $(idea).show();
      } else {
        $(idea).hide();
      }
    });
  });
}

function shorten(body) {
  var shortened = body.substring(0, 100).split(' ').slice(0, -1).join(' ');
  if (body.length >= 100) {
    return shortened + ' ...';
  } else {
    return body;
  }
}
