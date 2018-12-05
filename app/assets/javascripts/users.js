$(document).ready(function() {
  var messageAmount = $('#message-amount');

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
          messageAmount.html(response.nearby_messages.length);
          console.log(response);
        },
        error: function(response) {
          console.log(response);
        }
      });

        // Define controller action for this ajax request to send to. It should grab all of the current user's messages and return them, as well as the amount of times they've been kept.

        $.ajax({
          type: "GET",
          url: "/users/update_show",
          datatype: 'json',
          success: function(response) {
            var messagesContainerHTML = "";

            for (var i = 0; i < response.length; i++) {
              messagesContainerHTML += (
                `<div class="message">
                  <ul>
                    <li>
                      <p>${response[i].content} (${response[i].kept_messages.length})</p>
                      <p>${response[i].latitude}</p>
                      <p>${response[i].longitude}</p>
                      <p><a href='/messages/${response[i].id}' rel="nofollow" data-method="delete">Delete</a></p>
                    </li>
                  </ul>
                 </div>`
                );
              console.log(response[i]);
            }

            messagesContainer.html(messagesContainerHTML);
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
  var userAddress = $("#user-address").prop("value");
  messageButton.on("click", function(event) {
    event.preventDefault();
    $.ajax({
      type: "POST",
      url: "/messages",
      headers: {'X-CSRF-TOKEN': CSRFToken}, 
      data: {user_id: userID, content: messageBox.prop("value"), latitude: userLatitude, longitude: userLongitude, address: userAddress},
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

  var keepButton = $("#keep-button");
  var messageID = $("#message-id").prop("value");
  keepButton.on("click", function(event){
    event.preventDefault();
    $.ajax({
      type: "POST",
      url: "/kept_messages",
      headers: {'X-CSRF-TOKEN': CSRFToken},
      data: {user_id: userID, message_id: messageID},
      datatype: 'json',
      success: function(response) {

        console.log(response);
      },
      error: function(response) {
        console.log(response);
      }
    });
  });




});
