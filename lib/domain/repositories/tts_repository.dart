import 'package:tts_app/presentation/pages/home_page.dart';

abstract class TtsRepository {
  Future<void> speak(String text, TtsProvider provider);

  Future<void> stop(TtsProvider provider);

  Stream<void> get onSpeakCompletion;
}
