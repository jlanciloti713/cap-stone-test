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



});
