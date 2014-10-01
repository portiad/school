/**
 * service.js
 *
 * Computer Science 50
 * Problem Set 8
 *
 * Implements a shuttle service.
 */

// default height
var HEIGHT = 0.8;

// default latitude
var LATITUDE = 42.3745615030193;

// default longitude
var LONGITUDE = -71.11803936751632;

// default heading
var HEADING = 1.757197490907891;

// default number of seats
var SEATS = 10;

// default velocity
var VELOCITY = 50;

// global reference to shuttle's marker on 2D map
var bus = null;

// global reference to 3D Earth
var earth = null;

// global reference to 2D map
var map = null;

// global reference to shuttle
var shuttle = null;

// starting points for the game
var points = 0;

// full tank of charge
var charge = 100;

// load version 1 of the Google Earth API
google.load("earth", "1");

// load version 3 of the Google Maps API
google.load("maps", "3", {other_params: "sensor=false"});

// once the window has loaded
$(window).load(function() {
    if (charge > 0)
    {// listen for keydown anywhere in body
        $(document.body).keydown(function(event) {
            return keystroke(event, true);
        });

        // listen for keyup anywhere in body
        $(document.body).keyup(function(event) {
            return keystroke(event, false);
        });
    }
    else
    {
        $("#announcements").html("Shuttle has no charge to move");
    }
    
    // listen for click on Drop Off button
    $("#dropoff").click(function(event) {
        dropoff();
    });

    // listen for click on Pick Up button
    $("#pickup").click(function(event) {
        pickup();
    });

    // listen for click on Charge button
    $("#charge").click(function(event) {
        charged();
    });
    // load application
    load();
});

// unload application
$(window).unload(function() {
    unload();
});

function power()
{
    charge = charge - .1;

    if (charge < 0)
    {
         charge = 0;
    }

    driverinfo();   
}

/**
* Renders the points and charge % to the player
*/
function driverinfo()
{
    $("#points").html("Points: " + points);
    $("#charge").html("Charge: " + parseInt(charge) + "%");
}

/**
 * Renders seating chart.
 */
function chart()
{
    var html = "<ol start='0'>";
    for (var i = 0; i < shuttle.seats.length; i++)
    {
        if (shuttle.seats[i] == null)
        {
            html += "<li>Empty Seat</li>";
        }
        else        //displays picked-up passengers names and houses
        {
            html += "<li>" + shuttle.seats[i] + "</li>";
        }
    }
    html += "</ol>";
    $("#chart").html(html);
}

/**
 * Drops up passengers if their stop is nearby.
 */
function charged()
{
    var html = "";
    count = 0;

    for (var i in STATION)
    {
        var d = shuttle.distance(STATION[i].lat, STATION[i].lng);
        
        if (d <= 20)
        {
            charge = 100;
            driverinfo();
            count++;
        }
    }

    if (count > 0)
    {
        $("#announcements").html("Shuttle is now charged");
    }
    else
    {
        $("#announcements").html("No stations within 20 feet of the shuttle");
    } 
}

/**
 * Drops up passengers if their stop is nearby.
 */
function dropoff()
{
    var count = 0;
    var html = "";

    for (var i in PASSENGERS)
    {
        if (PASSENGERS[i].status == "shuttle")
        {
            var d = shuttle.distance(HOUSES[PASSENGERS[i].house].lat, HOUSES[PASSENGERS[i].house].lng);
            if (d <= 30) 
            {
                PASSENGERS[i].status = "house";
                shuttle.seats[PASSENGERS[i].seat] = null;
                html += " Dropped off " + PASSENGERS[i].name + "! You got a point!<br>";
                points++;
                chart();
                driverinfo();
                count ++ 
            }
        }
    }
    if (count > 0)
    {
        $("#announcements").html(html);
    }
    else
    {
        $("#announcements").html("No passengers within 30 feet of their house");
    }
}

/**
 * Called if Google Earth fails to load.
 */
function failureCB(errorCode) 
{
    // report error unless plugin simply isn't installed
    if (errorCode != ERR_CREATE_PLUGIN)
    {
        alert(errorCode);
    }
}

/**
 * Handler for Earth's frameend event.
 */
function frameend() 
{
    shuttle.update();
}

/**
 * Called once Google Earth has loaded.
 */
function initCB(instance) 
{
    // retain reference to GEPlugin instance
    earth = instance;

    // specify the speed at which the camera moves
    earth.getOptions().setFlyToSpeed(100);

    // show buildings
    earth.getLayerRoot().enableLayerById(earth.LAYER_BUILDINGS, true);

    // disable terrain (so that Earth is flat)
    earth.getLayerRoot().enableLayerById(earth.LAYER_TERRAIN, false);

    // prevent mouse navigation in the plugin
    earth.getOptions().setMouseNavigationEnabled(false);

    // instantiate shuttle
    shuttle = new Shuttle({
        heading: HEADING,
        height: HEIGHT,
        latitude: LATITUDE,
        longitude: LONGITUDE,
        planet: earth,
        seats: SEATS,
        velocity: VELOCITY
    });

    // synchronize camera with Earth
    google.earth.addEventListener(earth, "frameend", frameend);

    // synchronize map with Earth
    google.earth.addEventListener(earth.getView(), "viewchange", viewchange);

    // update shuttle's camera
    shuttle.updateCamera();

    // show Earth
    earth.getWindow().setVisibility(true);

    // render seating chart
    chart();

    // populate Earth with passengers and houses
    populate();

    // driver info
    driverinfo();
}

/**
 * Handles keystrokes.
 */
function keystroke(event, state)
{
    $("#announcements").html("On the move."); 

    // ensure we have event
    if (!event)
    {
        event = window.event;
    }

    power();

    // left arrow
    if (event.keyCode == 37)
    {
        shuttle.states.turningLeftward = state;
        return false;
    }

    // up arrow
    else if (event.keyCode == 38)
    {
        shuttle.states.tiltingUpward = state;
        return false;
    }

    // right arrow
    else if (event.keyCode == 39)
    {
        shuttle.states.turningRightward = state;
        return false;
    }

    // down arrow
    else if (event.keyCode == 40)
    {
        shuttle.states.tiltingDownward = state;
        return false;
    }

    // A, a
    else if (event.keyCode == 65 || event.keyCode == 97)
    {
        shuttle.states.slidingLeftward = state;
        return false;
    }

    // D, d
    else if (event.keyCode == 68 || event.keyCode == 100)
    {
        shuttle.states.slidingRightward = state;
        return false;
    }
  
    // S, s
    else if (event.keyCode == 83 || event.keyCode == 115)
    {
        shuttle.states.movingBackward = state;     
        return false;
    }

    // W, w
    else if (event.keyCode == 87 || event.keyCode == 119)
    {
        shuttle.states.movingForward = state;    
        return false;
    }

    // I, i
    else if (event.keyCode == 73 || event.keyCode == 105)
    {
        shuttle.velocity += 5;
    }

    //K, k
    else if (event.keyCode == 75 || event.keyCode == 107)
    {
        shuttle.velocity -= 5;
        if (shuttle.velocity < 0)
        {
            shuttle.velocity = 0;
        }
    }
  
    return true;
}

/**
 * Loads application.
 */
function load()
{
    // embed 2D map in DOM
    var latlng = new google.maps.LatLng(LATITUDE, LONGITUDE);
    map = new google.maps.Map($("#map").get(0), {
        center: latlng,
        disableDefaultUI: true,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        scrollwheel: false,
        zoom: 17,
        zoomControl: true
    });

    // prepare shuttle's icon for map
    bus = new google.maps.Marker({
        icon: "https://maps.gstatic.com/intl/en_us/mapfiles/ms/micons/bus.png",
        map: map,
        title: "you are here"
    });

    // embed 3D Earth in DOM
    google.earth.createInstance("earth", initCB, failureCB);
}

/**
* Get first available seat
*/
function getseats()
{
    for (var i = 0; i < shuttle.seats.length; i++)
    {
        if (shuttle.seats[i] == null)
        {
            return i;
        }
    }
    return "full";
}

/**
 * Picks up nearby passengers.
 */
function pickup()
{
    var features = earth.getFeatures();
    var count = 0;
    var html = "";

    for (var i in PASSENGERS)
    {
        var d = shuttle.distance(PASSENGERS[i].placemark.getGeometry().getLatitude(), PASSENGERS[i].placemark.getGeometry().getLongitude());
        if (d <= 15 && PASSENGERS[i].status == null)       //check if passengers within 15 meters
        {
            var seat = getseats();      // check if seats available
            count ++;
            if (seat != "full")
            {
                if (HOUSES[PASSENGERS[i].house] != null)        // don't pick up freshman
                {                    
                    shuttle.seats[seat] = PASSENGERS[i].name + " - " + PASSENGERS[i].house;       // place passenger in seat
                    PASSENGERS[i].seat = seat;
                    chart();                                             // update seating chart
                    PASSENGERS[i].status = "shuttle"                     // change passenger to on shuttle
                    features.removeChild(PASSENGERS[i].placemark);       // 3D remove
                    (PASSENGERS[i].marker).setMap(null);                 // 2D remove
                    html += PASSENGERS[i].name + "is picked up!<br>";
                }
                else
                {
                    html += "Can't pick up freshmen<br>";
                }
            }
            else
            {
               html += "No more free seats<br>";
            }
        }
    }

    if (count > 0)
    {
        $("#announcements").html(html);                     
    }
    else
    {
        $("#announcements").html("No passengers within 15 meters");
    }
}

/**
 * Populates Earth with passengers and houses.
 */
function populate()
{
    // mark houses
    for (var house in HOUSES)
    {
        // plant house on map
        new google.maps.Marker({
            icon: "https://google-maps-icons.googlecode.com/files/home.png",
            map: map,
            position: new google.maps.LatLng(HOUSES[house].lat, HOUSES[house].lng),
            title: house
        });
    }
    
    // get current URL, sans any filename
    var url = window.location.href.substring(0, (window.location.href.lastIndexOf("/")) + 1);

    // mark station
    for (var i = 0; i < STATION.length; i++)
    {   
        // prepare placemark
        var splacemark = earth.createPlacemark("");
        splacemark.setName(STATION[i].name);

        // prepare icon
        var logo = earth.createIcon("");
        logo.setHref(url + "/img/station/" + STATION[i].img + ".png");

        // prepare style
        var sstyle = earth.createStyle("");
        sstyle.getIconStyle().setIcon(logo);
        sstyle.getIconStyle().setScale(4.0);

        // prepare stylemap
        var sstyleMap = earth.createStyleMap("");
        sstyleMap.setNormalStyle(sstyle);
        sstyleMap.setHighlightStyle(sstyle);

        // associate stylemap with placemark
        splacemark.setStyleSelector(sstyleMap);

        // prepare point
        var spoint = earth.createPoint("");
        spoint.setAltitudeMode(earth.ALTITUDE_RELATIVE_TO_GROUND);
        spoint.setLatitude(STATION[i].lat);
        spoint.setLongitude(STATION[i].lng);
        spoint.setAltitude(0.0);

        // associate placemark with point
        splacemark.setGeometry(spoint);

        // add placemark to Earth
        earth.getFeatures().appendChild(splacemark);

        // plant house on map
        new google.maps.Marker({
            icon: "https://maps.gstatic.com/mapfiles/ms2/micons/gas.png",
            map: map,
            position: new google.maps.LatLng(STATION[i].lat, STATION[i].lng),
            title: STATION[i].name
        });
    }

    // get current URL, sans any filename
    var url = window.location.href.substring(0, (window.location.href.lastIndexOf("/")) + 1);

    // scatter passengers
    for (var i = 0; i < PASSENGERS.length; i++)
    {
        // pick a random building
        var building = BUILDINGS[Math.floor(Math.random() * BUILDINGS.length)];

        // prepare placemark
        var placemark = earth.createPlacemark("");
        placemark.setName(PASSENGERS[i].name + " to " + PASSENGERS[i].house);

        // prepare icon
        var icon = earth.createIcon("");
        icon.setHref(url + "/img/passenger/" + PASSENGERS[i].username + ".jpg");

        // prepare style
        var style = earth.createStyle("");
        style.getIconStyle().setIcon(icon);
        style.getIconStyle().setScale(4.0);

        // prepare stylemap
        var styleMap = earth.createStyleMap("");
        styleMap.setNormalStyle(style);
        styleMap.setHighlightStyle(style);

        // associate stylemap with placemark
        placemark.setStyleSelector(styleMap);

        // prepare point
        var point = earth.createPoint("");
        point.setAltitudeMode(earth.ALTITUDE_RELATIVE_TO_GROUND);
        point.setLatitude(building.lat);
        point.setLongitude(building.lng);
        point.setAltitude(0.0);

        // associate placemark with point
        placemark.setGeometry(point);

        // add placemark to Earth
        earth.getFeatures().appendChild(placemark);

        // add marker to map
        var marker = new google.maps.Marker({
            icon: "https://maps.gstatic.com/intl/en_us/mapfiles/ms/micons/man.png",
            map: map,
            position: new google.maps.LatLng(building.lat, building.lng),
            title: PASSENGERS[i].name + " at " + building.name
        });
        
        // Remember passenger's placemark and marker for pick-up
        PASSENGERS[i].placemark = placemark;
        PASSENGERS[i].marker = marker;
        PASSENGERS[i].status = null;
        PASSENGERS[i].seat = null;
    }
}

/**
 * Handler for Earth's viewchange event.
 */
function viewchange() 
{
    // keep map centered on shuttle's marker
    var latlng = new google.maps.LatLng(shuttle.position.latitude, shuttle.position.longitude);
    map.setCenter(latlng);
    bus.setPosition(latlng);
}

/**
 * Unloads Earth.
 */
function unload()
{
    google.earth.removeEventListener(earth.getView(), "viewchange", viewchange);
    google.earth.removeEventListener(earth, "frameend", frameend);
}
