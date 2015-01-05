import 'dart:html';
import 'dart:math';

import 'package:google_maps/google_maps.dart';

Polyline line;

void main() {
  var locationDiv = querySelector('#location');
  var headingDiv = querySelector('#heading');
  var speedDiv = querySelector('#speed');
  var errorDiv = querySelector('#error');

  window.navigator.geolocation.watchPosition(enableHighAccuracy: true).listen((data) {
    var coords = data.coords;
    var options = new MapOptions()..center = new LatLng(coords.latitude, coords.longitude)
                                  ..zoom = 15
                                  ..streetViewControl = false
                                  ..mapTypeId = MapTypeId.HYBRID;
    locationDiv.innerHtml = 'Lat: ${coords.latitude} Long: ${coords.longitude}';
    var map = new GMap(querySelector('#map'), options);
    if (coords.heading == double.NAN || coords.heading == null || (coords.heading == 0.0 && coords.speed == 0.0)) {
      headingDiv.innerHtml = 'Heading: UNKNOWN';
      speedDiv.innerHtml = 'Speed: UNKNOWN';
    } else {
      headingDiv.innerHtml = 'Heading: ${coords.heading}';
      speedDiv.innerHtml = 'Speed ${coords.speed} m/s';
      var length = coords.speed * 0.0005;
      var heading = coords.heading;
      var arrow = new GSymbol()..path = SymbolPath.FORWARD_OPEN_ARROW;
      line = new Polyline(new PolylineOptions()..icons = [new IconSequence()..icon = arrow
                                                                            ..offset = '100%']
                                               ..map = map
                                               ..path = [new LatLng(coords.latitude + length * sin(heading - PI/2), coords.longitude + length * cos(heading - PI/2) ),
                                                         new LatLng(coords.latitude + length * sin(heading + PI/2), coords.longitude + length * cos(heading + PI/2))]);
    }
  }).onError((e) {
    if (e is PositionError) {
      errorDiv.innerHtml = (e as PositionError).message;
    } else {
      errorDiv.innerHtml = e.toString();
    }
  });
}