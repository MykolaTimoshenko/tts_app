import 'package:tts_app/core/services/service_locator.dart';
import 'package:tts_app/data/datasources/local_tts_datasource.dart';
import 'package:tts_app/domain/repositories/tts_repository.dart';

class TtsRepositoryImpl implements TtsRepository {
  final _localDataSource = locator<LocalTtsDataSource>();

  @override
  Future<void> speak(String text) async {
    await _localDataSource.speak(text);
  }

  @override
  Future<void> stop() async {
    await _localDataSource.stop();
  }

  @override
  Stream<void> get onSpeakCompletion => _localDataSource.onSpeakCompletion;
}
