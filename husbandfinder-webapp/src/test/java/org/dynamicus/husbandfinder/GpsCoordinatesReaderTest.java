package org.dynamicus.husbandfinder;

import org.json.simple.parser.ParseException;
import org.junit.Test;

import java.io.IOException;

import static org.junit.Assert.*;

public class GpsCoordinatesReaderTest {

    @Test
    public void testReadAddress() throws ParseException, IOException {

        assertEquals("Note that this test may fail if your internet connection is down, or if google has changed the interface",
                "Johanne Dybwads plass 1, 0161 Oslo, Norway",
                     new GpsCoordinatesReader().getAddressByGpsCoordinates("59.914561", "10.734117"));//Nationaltheatret

    }

}