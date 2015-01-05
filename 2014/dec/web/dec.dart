import 'dart:html';
import 'dart:web_audio';
import 'dart:typed_data';
import 'dart:math';

const int fftSize = 512;
const int frequencyBinCount = fftSize ~/ 2;

const String webPDataUrlHeader = 'data:image/webp;base64,';

void main() {
  var ctx = new AudioContext();

  window.navigator.getUserMedia(audio: true, video: false).then((mediaStream) {
    var analyzer = ctx.createAnalyser();
    analyzer.fftSize = fftSize;
    ctx.createMediaStreamSource(mediaStream).connectNode(analyzer);
    var floatFrequencyDataCanvas = querySelector('#floatFrequencyData') as CanvasElement;
    floatFrequencyDataCanvas.width = 512;
    floatFrequencyDataCanvas.height = 512;
    var floatTimeDomainDataCanvas = querySelector('#floatTimeDomainData') as CanvasElement;
    floatTimeDomainDataCanvas.width = 512;
    floatTimeDomainDataCanvas.height = 512;
    var byteFrequencyDataCanvas = querySelector('#byteFrequencyData') as CanvasElement;
    byteFrequencyDataCanvas.width = 512;
    byteFrequencyDataCanvas.height = 512;
    var byteTimeDomainDataCanvas = querySelector('#byteTimeDomainData') as CanvasElement;
    byteTimeDomainDataCanvas.width = 512;
    byteTimeDomainDataCanvas.height = 512;
    var headCanvas = querySelector('#head') as CanvasElement;
    headCanvas.width = 512;
    headCanvas.height = 512;

    var floatFrequencyData = new Float32List(frequencyBinCount);
    var floatTimeDomainData = new Float32List(fftSize);
    var byteFrequencyData = new Uint8List(frequencyBinCount);
    var byteTimeDomainData = new Uint8List(fftSize);


    void analyzeAndRender(num time) {
      analyzer.getFloatFrequencyData(floatFrequencyData);
      analyzer.getFloatTimeDomainData(floatTimeDomainData);
      analyzer.getByteFrequencyData(byteFrequencyData);
      analyzer.getByteTimeDomainData(byteTimeDomainData);

      visualize(byteFrequencyDataCanvas, byteFrequencyData, 2, 256);
      visualize(floatFrequencyDataCanvas, floatFrequencyData, 2, 256);
      visualize(byteTimeDomainDataCanvas, byteTimeDomainData, 1, 256);
      visualize(floatTimeDomainDataCanvas, floatTimeDomainData, 1, 1);

      var valleyForE = byteFrequencyData.skip(14).take(4).reduce((a, b) => a+b);
      var valleyForA = byteFrequencyData.skip(22).take(4).reduce((a, b) => a+b);
      var diff = (valleyForE - valleyForA) / 4;
      var sum = byteFrequencyData.reduce((a, b) => a+b);

      headCanvas.context2D..fillStyle = 'white'
                          ..fillRect(0, 0, 512, 512)
                          ..save()
                          ..fillStyle = 'black'
                          ..save()
                          ..translate(256, 256 - 2 * sum / fftSize)
                          ..rotate(PI / 4 * diff / 256)
                          ..beginPath()
                          ..arc(0, 0, 64, PI, 0)
                          ..fill()
                          ..closePath()
                          ..restore()
                          ..save()
                          ..translate(256, 256)
                          ..beginPath()
                          ..arc(0, 0, 64, 0, PI)
                          ..fill()
                          ..closePath()
                          ..restore()
                          ..restore();

      var dataUrlWebP = headCanvas.toDataUrl('image/webp');
      String decodedImage = window.atob(dataUrlWebP.substring(webPDataUrlHeader.length));
      var riff = parseRiff(decodedImage);
      print(riff.length);
      print(riff.riff.length);
      print(riff.riff.data);
      print(decodedImage.length);
      print(decodedImage.substring(0, 30));
      print(decodedImage.substring(0, 30).split('').map((char) => char.codeUnitAt(0).toRadixString(16)).join(' '));

      window.requestAnimationFrame(analyzeAndRender);
    }
    analyzeAndRender(0);
  });
}

// parse RIFF according to https://en.wikipedia.org/wiki/Resource_Interchange_File_Format#Explanation
RiffChunk parseRiff(String webPImage) {
  RiffChunk result;
  var dataStart = 8;
  var id = webPImage.substring(0, 4);
  int chunkLength = webPImage.substring(4, 8)
                             .split('')
                             .reversed
                             .map((char) => char.codeUnitAt(0))
                             .fold(0, (int result, int current) => (result << 3) + current);
  result = new RiffChunk(id, chunkLength, webPImage.substring(dataStart));
  if (id == 'RIFF' || id == 'LIST') {
    var tmp = parseRiff(webPImage.substring(dataStart + 4));
    if (id == 'RIFF') {
      result.riff = tmp;
    } else {
      result.list = tmp;
    }
  }
  return result;
}

void visualize(CanvasElement canvas, List<num> data, int width, int max) {
  canvas.context2D..fillStyle = 'white'
                  ..fillRect(0, 0, 512, 512)
                  ..fillStyle = 'black';

  for (int i = 0; i < data.length; i++) {
    canvas.context2D.fillRect(i * width, 256, width, 256 * data[i] / max);
  }
}

class RiffChunk {
  String id;
  int length;
  String data;
  RiffChunk riff;
  RiffChunk list;
  RiffChunk(this.id, this.length, this.data);
}