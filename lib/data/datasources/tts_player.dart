import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

class TtsPlayer {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playFromBytes(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/tts_audio.mp3';
    final file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);

    await _player.play(DeviceFileSource(filePath));
  }

  Future<void> stop() async {
    await _player.stop();
  }
}
