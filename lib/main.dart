import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tts_app/core/services/service_locator.dart';
import 'package:tts_app/domain/repositories/tts_repository.dart';
import 'package:tts_app/presentation/bloc/tts_bloc.dart';
import 'package:tts_app/presentation/pages/home_page.dart';


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
      create: (_) => TtsBloc(locator<TtsRepository>()),
      child: MaterialApp(
        title: 'TTS Example',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
      ),
    );
  }
}