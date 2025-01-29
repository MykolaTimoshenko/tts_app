import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tts_app/core/services/service_locator.dart';
import 'package:tts_app/core/utils/tts_player.dart';
import 'package:tts_app/domain/repositories/tts_repository.dart';
import 'package:tts_app/presentation/bloc/tts_bloc.dart';
import 'package:tts_app/presentation/pages/home_page.dart';

///1. Add different keys to elevenLab
///2. Add loader to button
///3. Add required text to button(without text button is non available) (DONE) ++++
///4. Add stream connection so audio will stop after audio ends (DONE) ++++
///5. Add code refactoring to all files
///6. Think how to implement API key(not required)
///6. Add documentation

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TtsBloc(
        locator<TtsRepository>(),
        locator<TtsPlayer>(),
      ),
      child: MaterialApp(
        title: 'TTS Example',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
      ),
    );
  }
}
