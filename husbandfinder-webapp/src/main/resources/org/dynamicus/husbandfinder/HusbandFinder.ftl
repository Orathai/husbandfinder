<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="/css/style.css">
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <meta charset="utf-8">
        <title>Husband finder</title>

        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
        <script>
            var rendererOptions = {
              draggable: true
            };
            var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
            var directionsService = new google.maps.DirectionsService();
            var map;

            var oslo = new google.maps.LatLng(59.913729, 10.752007);

            function initialize() {
                //59.913729, 10.752007
                var mapOptions = {
                    zoom:7,
                    center: oslo
                };

                map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
                directionsDisplay.setMap(map);
                directionsDisplay.setPanel(document.getElementById('directionsPanel'));

                google.maps.event.addListener(directionsDisplay, 'directions_changed', function() {
                    computeTotalDistance(directionsDisplay.getDirections());
                });

                calcRoute();
            }

            function calcRoute() {
                  if(navigator.geolocation) {
                      navigator.geolocation.getCurrentPosition(function(position) {

                          var start = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                          var end = new google.maps.LatLng(${latitudeEnd}, ${longitudeEnd});
                          var selectedMode = document.getElementById('mode').value;

                          var request = {
                              origin:start,
                              destination:end,
                              travelMode: google.maps.TravelMode[selectedMode]
                          };

                          directionsService.route(request, function(response, status) {
                                if (status == google.maps.DirectionsStatus.OK) {
                                  directionsDisplay.setDirections(response);
                                }
                          });

                      }, function() {
                            handleNoGeolocation(true);
                      });
                  } else {
                      // Browser doesn't support Geolocation
                      handleNoGeolocation(false);
                  }
            }

            function handleNoGeolocation(errorFlag) {
                  var content = "";
                  if (errorFlag) {
                    content = 'Error: The Geolocation service failed.';
                  } else {
                    content = 'Error: Your browser doesn\'t support geolocation.';
                  }
            }

            function computeTotalDistance(result) {
                  var total = 0;
                  var myRoute = result.routes[0];
                  for (var i = 0; i < myRoute.legs.length; i++) {
                        total += myRoute.legs[i].distance.value;
                  }
                  total = total / 1000.0;
                  document.getElementById('total').innerHTML = total + ' km';
            }

            google.maps.event.addDomListener(window, 'load', initialize);
        </script>
    </head>
    <body onLoad="calcRoute();">
        <div id="map-canvas" class="map_canvas"></div>
        <div id="directionsPanel" class="direction_panel">
            <strong>Mode of Travel: </strong>
            <select id="mode" onchange="calcRoute();">
              <option value="WALKING">Walking</option>
              <option value="DRIVING">Driving</option>
              <option value="BICYCLING">Bicycling</option>
              <option value="TRANSIT">Transit</option>
            </select>
            <p>Total Distance: <span id="total"></span></p>
        </div>
    </body>
</html>