import 'package:tts_app/core/services/service_locator.dart';
import 'package:tts_app/core/utils/tts_player.dart';
import 'package:tts_app/data/datasources/eleven_labs_datasource.dart';
import 'package:tts_app/data/datasources/local_tts_datasource.dart';
import 'package:tts_app/domain/enums/tts_provider_type.dart';
import 'package:tts_app/domain/repositories/tts_repository.dart';

class TtsRepositoryImpl implements TtsRepository {
  final _localDataSource = locator<LocalTtsDataSource>();
  final _elevenLabsDataSource = locator<ElevenLabsDataSource>();
  final _ttsPlayer = locator<TtsPlayer>();

  @override
  Future<void> speak(String text, TtsProviderType provider) async {
    switch (provider) {
      case TtsProviderType.local:
        await _localDataSource.speak(text);
        break;
      case TtsProviderType.elevenLabs:
        final audioBytes = await _elevenLabsDataSource.synthesize(text);
        await _ttsPlayer.playFromBytes(audioBytes);
        break;
    }
  }

  @override
  Future<void> stop(TtsProviderType provider) async {
    switch (provider) {
      case TtsProviderType.local:
        await _localDataSource.stop();
        break;
      case TtsProviderType.elevenLabs:
        await _ttsPlayer.stop();
        break;
    }
  }

  @override
  Stream<void> get onSpeakCompletion => _localDataSource.onCompletion;
}
