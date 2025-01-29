import 'package:tts_app/domain/enums/tts_voice_type.dart';

abstract class TtsRepository {
  Future<void> speak(String text, TtsVoiceType voiceType);

  Future<void> stop(TtsVoiceType voiceType);

  Stream<void> get onSpeakCompletion;
}
