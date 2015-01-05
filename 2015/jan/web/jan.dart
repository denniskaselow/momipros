import 'dart:html';
import 'dart:math';

import 'package:google_maps/google_maps.dart';

DivElement locationDiv = querySelector('#location');
DivElement headingDiv = querySelector('#heading');
DivElement speedDiv = querySelector('#speed');
DivElement errorDiv = querySelector('#error');

MapOptions options;
GMap map;
Polyline line;

void main() {
  map = new GMap(querySelector('#map'));
  options = new MapOptions()..zoom = 15
                            ..streetViewControl = false
                            ..mapTypeId = MapTypeId.HYBRID;
  var arrow = new GSymbol()..path = SymbolPath.FORWARD_OPEN_ARROW;
  line = new Polyline(new PolylineOptions()..icons = [new IconSequence()..icon = arrow
                                                                       ..offset = '100%']
                                           ..map = map);

  window.navigator.geolocation.watchPosition(enableHighAccuracy: true).listen((data) {
    var coords = data.coords;
    updateMap(coords.latitude, coords.longitude, coords.heading, coords.speed);
  }).onError((e) {
    if (e is PositionError) {
      errorDiv.innerHtml = (e as PositionError).message;
    } else {
      errorDiv.innerHtml = e.toString();
    }
  });
}

void updateMap(double latitude, double longitude, double heading, double speed) {
  locationDiv.innerHtml = 'Lat: ${latitude} Long: ${longitude}';
  options.center = new LatLng(latitude, longitude);
  map.options = options;
  if (heading == double.NAN || heading == null || (heading == 0.0 && speed == 0.0)) {
    headingDiv.innerHtml = 'Heading: UNKNOWN';
    speedDiv.innerHtml = 'Speed: UNKNOWN';
  } else {
    headingDiv.innerHtml = 'Heading: ${heading}';
    speedDiv.innerHtml = 'Speed ${speed} m/s';
    var length = speed * 0.0005;
    heading = -heading * PI / 180;
    line.path = [new LatLng(latitude + length * sin(heading - PI/2), longitude + length * cos(heading - PI/2) ),
                 new LatLng(latitude + length * sin(heading + PI/2), longitude + length * cos(heading + PI/2))];
  }
}