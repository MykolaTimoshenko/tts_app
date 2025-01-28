abstract class TtsRepository {
  Future<void> speak(String text);

  Future<void> stop();

  Stream<void> get onSpeakCompletion;
}
