// WEEK 6: CAMERA BASED PPG-LIKE PROVIDER
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/legacy.dart';


/// State PPG: capturing, samples, mean, variance
class PpgState {
  final bool capturing;
  final List<double> samples;
  final double mean;
  final double variance;

  PpgState({
    required this.capturing,
    required this.samples,
    required this.mean,
    required this.variance,
  });

  PpgState copyWith({
    bool? capturing,
    List<double>? samples,
    double? mean,
    double? variance,
  }) {
    return PpgState(
      capturing: capturing ?? this.capturing,
      samples: samples ?? this.samples,
      mean: mean ?? this.mean,
      variance: variance ?? this.variance,
    );
  }
}

/// Provider modern untuk state PPG
final ppgProvider = StateNotifierProvider<PpgNotifier, PpgState>(
  (ref) => PpgNotifier(),
);

/// Notifier untuk PPG
class PpgNotifier extends StateNotifier<PpgState> {
  PpgNotifier()
      : super(
          PpgState(
            capturing: false,
            samples: [],
            mean: 0,
            variance: 0,
          ),
        );

  CameraController? _controller;

  /// Mulai capture kamera
  Future<void> startCapture() async {
    final cameras = await availableCameras();
    final cam = cameras.first;

    _controller = CameraController(
      cam,
      ResolutionPreset.low,
      enableAudio: false,
    );

    await _controller!.initialize();
    state = state.copyWith(capturing: true);

    _controller!.startImageStream((image) {
      final plane = image.planes[0]; // Kanal Y (luminance)
      final buffer = plane.bytes;

      double sum = 0;
      int count = 0;

      // Sampling setiap 50 byte untuk efisiensi
      for (int i = 0; i < buffer.length; i += 50) {
        sum += buffer[i];
        count++;
      }

      final meanY = sum / count;

      // Sliding window 300 sampel
      final newSamples = [...state.samples, meanY];
      if (newSamples.length > 300) newSamples.removeAt(0);

      final mean = newSamples.reduce((a, b) => a + b) / newSamples.length;
      final variance =
          newSamples.fold(0.0, (s, x) => s + pow(x - mean, 2)) /
          max(1, newSamples.length - 1);

      state = state.copyWith(
        samples: newSamples,
        mean: mean,
        variance: variance,
      );
    });
  }

  /// Hentikan capture kamera
  Future<void> stopCapture() async {
    if (_controller != null) {
      await _controller!.stopImageStream();
      await _controller!.dispose();
      _controller = null;
    }

    state = state.copyWith(capturing: false);
  }
}
