import 'dart:html';

void main() {
  var headingDiv = querySelector('#heading');
  var speedDiv = querySelector('#speed');
  var errorDiv = querySelector('#error');

  window.navigator.geolocation.watchPosition(enableHighAccuracy: true).listen((data) {
    headingDiv.innerHtml = 'Heading: ${data.coords.heading}';
    speedDiv.innerHtml = 'Speed ${data.coords.speed}';
  }).onError((e){
    if (e is PositionError) {
      errorDiv.innerHtml = (e as PositionError).message;
    } else {
      errorDiv.innerHtml = e.toString();
    }
  });
}