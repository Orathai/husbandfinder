package org.dynamicus.husbandfinder;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;

public class GpsCoordinatesReader {

    private static final Logger log = LoggerFactory.getLogger(GpsCoordinatesReader.class);

    public String getAddressByGpsCoordinates(String latitude, String longitude)
            throws IOException, ParseException {

        log.info("Latitude: " + latitude + " Longitude: " + longitude);

        URL url = new URL("http://maps.googleapis.com/maps/api/geocode/json?latlng="
                + latitude + "," + longitude + "&sensor=true");
        url.openConnection();
        String address = "";

        InputStream in = url.openStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(in));
        String result, line = "";
        result = line;

        while ((line = reader.readLine()) != null) {
            result += line;
        }

        JSONParser parser = new JSONParser();
        JSONObject rsp = (JSONObject) parser.parse(result);

        if (rsp.containsKey("results")) {
            JSONArray matches = (JSONArray) rsp.get("results");

            if (matches.get(0) != null) {
                JSONObject data = (JSONObject) matches.get(0);
                address = (String) data.get("formatted_address");
                log.info("ADDRESS: " + address + " JSON Object: " + data.toJSONString());
            }

        }
        return address;
    }

}
