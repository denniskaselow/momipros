import 'dart:html';

void main() {
  var headingDiv = querySelector('#heading');
  var speedDiv = querySelector('#speed');
  var errorDiv = querySelector('#error');

  try {
    window.navigator.geolocation.watchPosition(enableHighAccuracy: true, timeout: new Duration(seconds: 10)).listen((data) {
      headingDiv.innerHtml = 'Heading: ${data.coords.heading}';
      speedDiv.innerHtml = 'Speed ${data.coords.speed}';
    })..onDone(() {
      errorDiv.innerHtml = 'erledigt';
    })..onError((e){
      if (e is PositionError) {
        errorDiv.innerHtml = (e as PositionError).message;
      }
    });
  } catch (e) {
    errorDiv.innerHtml = e;
  }
}