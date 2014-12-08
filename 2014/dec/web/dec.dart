import 'dart:html';
import 'dart:web_audio';
import 'dart:typed_data';

const int fftSize = 512;
const int frequencyBinCount = fftSize ~/ 2;

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

      window.requestAnimationFrame(analyzeAndRender);
    }
    analyzeAndRender(0);
  });
}

void visualize(CanvasElement canvas, List<num> data, int width, int max) {
  canvas.context2D..fillStyle = 'white'
                  ..fillRect(0, 0, 512, 512)
                  ..fillStyle = 'black';

  for (int i = 0; i < data.length; i++) {
    canvas.context2D.fillRect(i * width, 256, width, 256 * data[i] / max);
  }
}
