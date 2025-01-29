import 'package:tts_app/domain/enums/tts_provider_type.dart';

abstract class TtsRepository {
  Future<void> speak(String text, TtsProviderType provider);

  Future<void> stop(TtsProviderType provider);

  Stream<void> get onSpeakCompletion;
}
