package org.dynamicus.husbandfinder;

import freemarker.template.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import spark.ModelAndView;
import spark.template.freemarker.FreeMarkerEngine;

import java.util.HashMap;
import java.util.Map;

import static spark.Spark.get;
import static spark.Spark.post;
import static spark.SparkBase.port;
import static spark.SparkBase.staticFileLocation;

public class HusbandFinderController {

    private static final Logger log = LoggerFactory.getLogger(HusbandFinderController.class);

    //This is temporary storage, and will only support 1 user.
    private static HusbandCoord husbandCoord = null;

    public static void main(String[] args) {
        new HusbandFinderController().geoRead();
    }

    public void geoRead() {

        port(5678);

        staticFileLocation("/public");


        get("/", (request, response) -> {
            response.redirect("/index.html");
            return "";
        });


        get("/index.html", (request, response) -> {
            return new ModelAndView(new HashMap<>(), "GeoDestinationRead.ftl");
        }, new FreeMarkerEngine(createDefaultConfiguration()));


        post("/submit.html", (request, response) -> {
            String latitudeEnd = request.queryParams("lastHusbandLat");
            String longitudeEnd = request.queryParams("lastHusbandLong");
            log.info("Submitted location, Latitude : " + latitudeEnd + " Longitude : " + longitudeEnd);

            // Updating coordinates
            husbandCoord = new HusbandCoord();
            husbandCoord.setHusbandLat(latitudeEnd);
            husbandCoord.setHusbandLong(longitudeEnd);

            Map<String, Object> attributes = new HashMap<>();
            attributes.put("message", "Current location registered.");

            return new ModelAndView(attributes, "GeoDestinationRead.ftl");
        }, new FreeMarkerEngine(createDefaultConfiguration()));


        get("/stored.html", (request, response) -> {
            Map<String, Object> attributes = new HashMap<>();
            attributes.put("latitudeEnd", husbandCoord.getHusbandLat());
            attributes.put("longitudeEnd", husbandCoord.getHusbandLong());

            return new ModelAndView(attributes, "HusbandFinder.ftl");
        }, new FreeMarkerEngine(createDefaultConfiguration()));

    }

    private Configuration createDefaultConfiguration() {
        Configuration configuration = new Configuration();
        configuration.setClassForTemplateLoading(getClass(), "");
        return configuration;
    }

}
