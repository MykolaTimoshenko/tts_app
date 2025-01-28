import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tts_app/presentation/bloc/tts_bloc.dart';
import 'package:tts_app/presentation/bloc/tts_event.dart';
import 'package:tts_app/presentation/bloc/tts_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TTS Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<TtsBloc, TtsState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Enter text to speak',
                  ),
                  onChanged: (value) =>
                      context.read<TtsBloc>().add(TtsTextChanged(value)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<TtsBloc>().add(TtsSpeakRequested());
                  },
                  child: const Text('Speak'),
                ),
                if (state.isSpeaking)
                  ElevatedButton(
                    onPressed: () {
                      context.read<TtsBloc>().add(TtsStopRequested());
                    },
                    child: const Text('Stop'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
