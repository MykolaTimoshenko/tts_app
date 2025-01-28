import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

class LocalTtsDataSource {
  final FlutterTts _flutterTts = FlutterTts();

  final _completionController = StreamController<void>.broadcast();

  Stream<void> get onSpeakCompletion => _completionController.stream;

  LocalTtsDataSource() {
    _flutterTts.awaitSpeakCompletion(true);

    _flutterTts.setCompletionHandler(() {
      _completionController.add(null);
    });
  }

  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  void dispose() {
    _completionController.close();
  }
}
