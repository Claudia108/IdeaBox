$(document).ready(function() {
  displayIdeas();
  // createIdea();
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
  response.forEach(function(singleIdea) {
    var title = singleIdea.title;
    var body = singleIdea.body;
    var quality = singleIdea.quality;

    $('.ideas').append('<h2>' + title + '</h2>');
    $('.ideas').append('<p>' + body + '</p>');
    $('.ideas').append('<p>What a <i>' + quality + '</i> idea!</p>');
  });
}





// function renderMap() {
//   $.ajax({
//     method: "GET",
//     url: "/api/v1/sites.json",
//     dataType: "JSON",
//     success: function(response) {
//       initMap(response);
//     }
//   });
// }
