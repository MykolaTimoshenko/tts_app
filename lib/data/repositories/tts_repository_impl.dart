import 'package:tts_app/core/services/service_locator.dart';
import 'package:tts_app/core/utils/tts_player.dart';
import 'package:tts_app/data/datasources/eleven_labs_datasource.dart';
import 'package:tts_app/data/datasources/local_tts_datasource.dart';
import 'package:tts_app/domain/enums/tts_voice_type.dart';
import 'package:tts_app/domain/repositories/tts_repository.dart';

class TtsRepositoryImpl implements TtsRepository {
  final _localDataSource = locator<LocalTtsDataSource>();
  final _elevenLabsDataSource = locator<ElevenLabsDataSource>();
  final _ttsPlayer = locator<TtsPlayer>();

  @override
  Future<void> speak(String text, TtsVoiceType voiceType) async {
    switch (voiceType) {
      case TtsVoiceType.local:
        await _localDataSource.speak(text);
        break;
      case TtsVoiceType.roger:
        final audioBytes = await _elevenLabsDataSource.synthesize(
          text: text,
          voiceId: 'CwhRBWXzGAHq8TQ4Fs17',
        );
        await _ttsPlayer.playFromBytes(audioBytes);
        break;
      case TtsVoiceType.sarah:
        final audioBytes = await _elevenLabsDataSource.synthesize(
          text: text,
          voiceId: 'EXAVITQu4vr4xnSDxMaL',
        );
        await _ttsPlayer.playFromBytes(audioBytes);
        break;
    }
  }

  @override
  Future<void> stop(TtsVoiceType voiceType) async {
    switch (voiceType) {
      case TtsVoiceType.local:
        await _localDataSource.stop();
        break;
      case TtsVoiceType.roger:
        await _ttsPlayer.stop();
        break;
      case TtsVoiceType.sarah:
        await _ttsPlayer.stop();
        break;
    }
  }

  @override
  Stream<void> get onSpeakCompletion => _localDataSource.onCompletion;
}
