import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tts_app/presentation/bloc/tts_bloc.dart';
import 'package:tts_app/presentation/bloc/tts_event.dart';
import 'package:tts_app/presentation/bloc/tts_state.dart';

enum TtsProvider {
  local,
  elevenLabs,
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TTS Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<TtsBloc, TtsState>(
          builder: (context, state) {
            final bloc = context.read<TtsBloc>();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Enter text to speak',
                  ),
                  onChanged: (value) => bloc.add(TtsTextChanged(value)),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Provider: '),
                    DropdownButton<TtsProvider>(
                      value: state.provider,
                      items: const [
                        DropdownMenuItem(
                          value: TtsProvider.local,
                          child: Text('Local TTS'),
                        ),
                        DropdownMenuItem(
                          value: TtsProvider.elevenLabs,
                          child: Text('ElevenLabs'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          bloc.add(TtsProviderChanged(val));
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => bloc.add(TtsSpeakRequested()),
                  child: const Text('Speak'),
                ),
                const SizedBox(height: 8),
                if (state.isSpeaking)
                  ElevatedButton(
                    onPressed: () => bloc.add(TtsStopRequested()),
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
