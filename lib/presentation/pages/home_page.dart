import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tts_app/domain/enums/tts_voice_type.dart';
import 'package:tts_app/presentation/bloc/tts_bloc.dart';
import 'package:tts_app/presentation/bloc/tts_event.dart';
import 'package:tts_app/presentation/bloc/tts_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TtsBloc _ttsBloc;
  late final ValueNotifier<bool> _isTextFilledNotifier;

  @override
  void initState() {
    super.initState();
    _ttsBloc = context.read();
    _isTextFilledNotifier = ValueNotifier(false);
  }

  @override
  void dispose() {
    _isTextFilledNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TTS Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<TtsBloc, TtsState>(
          bloc: _ttsBloc,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: _onChangedText,
                  decoration: const InputDecoration(
                    labelText: 'Enter text',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Voices: '),
                    DropdownButton<TtsVoiceType>(
                      value: state.voiceType,
                      items: const [
                        DropdownMenuItem(
                          value: TtsVoiceType.local,
                          child: Text('Local'),
                        ),
                        DropdownMenuItem(
                          value: TtsVoiceType.roger,
                          child: Text('Roger'),
                        ),
                        DropdownMenuItem(
                          value: TtsVoiceType.sarah,
                          child: Text('Sarah'),
                        ),
                      ],
                      onChanged: _onChangedVoiceType,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<bool>(
                  valueListenable: _isTextFilledNotifier,
                  builder: (context, value, child) {
                    if (value) {
                      return ElevatedButton(
                        onPressed: _onSpeakButtonPressed,
                        child: const Text('Speak'),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                if (state.isSpeaking)
                  ElevatedButton(
                    onPressed: _onStopButtonPressed,
                    child: const Text('Stop'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onChangedText(String value) {
    _isTextFilledNotifier.value = value.trim().isNotEmpty;
    _ttsBloc.add(
      TtsTextChanged(value),
    );
  }

  void _onChangedVoiceType(TtsVoiceType? voiceType) {
    if (voiceType != null) {
      _ttsBloc.add(
        TtsVoiceChanged(voiceType),
      );
    }
  }

  void _onSpeakButtonPressed() {
    _ttsBloc.add(
      TtsSpeakRequested(),
    );
  }

  void _onStopButtonPressed() {
    _ttsBloc.add(
      TtsStopRequested(),
    );
  }
}
