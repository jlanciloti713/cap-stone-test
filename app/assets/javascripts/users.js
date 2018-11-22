$(document).ready(function() {

  navigator.geolocation.watchPosition(getLocation);
    function getLocation(pos) {
        var CSRFToken = $('meta[name="csrf-token"]').prop("content");
        var lat = pos.coords.latitude;
        var lon = pos.coords.longitude;
        var userLatitude = $(this).attr("latitude")
        var userLongitude = $(this).attr("longitude")
        var userPosition = $("#user-position");
        $.ajax({
        type: "PUT",
        url: "/users/currentposition",
        headers: {'X-CSRF-TOKEN': CSRFToken},
        datatype: "json",
        data: {userLatitude: lat, userLongitude: lon},
        success: function(response) {
        
        console.log(response);

        },
        error: function(response) {
        console.log(response);
        }
      });
    };


  var messagesContainer = $("#messages-container");
  var messageBox = $("#message-box");
  var messageButton = $("#message-button");
  var CSRFToken = $('meta[name="csrf-token"]').prop("content");
  var userID = $("#user-id").prop("value");
  var userLatitude = $("#user-latitude").prop("value");
  var userLongitude = $("#user-longitude").prop("value");

  messageButton.on("click", function(event) {
    event.preventDefault();
  $.ajax({
    type: "POST",
    url: "/messages",
    headers: {'X-CSRF-TOKEN': CSRFToken}, 
    data: {user_id: userID, content: messageBox.prop("value"), latitude: userLatitude, longitude: userLongitude},
    datatype: 'json',
    success: function(response) {
      messagesContainer.prepend(
        `<div class="message">
          <ul>
            <li>
              <p>${response.content}</p>
              <p>${response.latitude}</p>
              <p>${response.longitude}</p>
              <p><a href='/messages/${response.id}' rel="nofollow" data-method="delete">Delete</a></p>
            </li>
          </ul>
         </div>`
        );
      messageBox.prop("value", "")
      },
    error: function(response) {
      console.log(response);
    }
  });

  });

});
