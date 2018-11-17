$(document).ready(function() {

  navigator.geolocation.watchPosition(getLocation);
    function getLocation(pos) {

      navigator.geolocation.watchPosition(function() {
        var CSRFToken = $('meta[name="csrf-token"]').prop("content");
        var lat = pos.coords.latitude;
        var lon = pos.coords.longitude;
        var userPosition = $("#user-position");
        $.ajax({
        type: "PUT",
        url: "/users/currentposition",
        headers: {'X-CSRF-TOKEN': CSRFToken},
        datatype: "json",
        data: {lat: lat, lon: lon},
        success: function(response) {
        console.log(response);
        },
        error: function(response) {
        console.log(response);
        }
      });
  });
};


});