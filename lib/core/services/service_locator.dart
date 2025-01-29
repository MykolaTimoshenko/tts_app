import 'package:get_it/get_it.dart';
import 'package:tts_app/data/datasources/eleven_labs_datasource.dart';
import 'package:tts_app/data/datasources/local_tts_datasource.dart';
import 'package:tts_app/core/utils/tts_player.dart';
import 'package:tts_app/data/repositories/tts_repository_impl.dart';
import 'package:tts_app/domain/repositories/tts_repository.dart';

final locator = GetIt.instance;

Future<void> initServiceLocator() async {
  locator.registerLazySingleton<LocalTtsDataSource>(LocalTtsDataSource.new);
  locator.registerLazySingleton<ElevenLabsDataSource>(ElevenLabsDataSource.new);
  locator.registerLazySingleton<TtsPlayer>(TtsPlayer.new);
  locator.registerLazySingleton<TtsRepository>(TtsRepositoryImpl.new);
}
