<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="/css/style.css">
        <title>Husband finder</title>
        <script type="text/javascript">
            function initGeolocation(){
                  if(navigator.geolocation) {
                      navigator.geolocation.getCurrentPosition(function(position) {
                            document.getElementById('long').value = position.coords.longitude;
                            document.getElementById('lat').value = position.coords.latitude;
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
            
        </script>
    </head>

     <body onLoad="initGeolocation();">
        <div align="center">
            <form name="submit" action="/submit.html" method="post">
                <table class="table2">
                    <tr>
                        <td>Latitude :</td>
                        <td><input type="text" name="lastHusbandLat" id="lat" value="" readonly= "true"></td>
                    </tr>
                    <tr>
                        <td>Longitude :</td>
                        <td><input type="text" name="lastHusbandLong" id="long" value="" readonly= "true"></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Submit"></td>
                    </tr>
                </table>

            </form>
            <#if message??>
                <p class="txt_blue">${message} <a href="/stored.html" target="_blank">view map</a></p>
            </#if>
        </div>
     </body>
</html>