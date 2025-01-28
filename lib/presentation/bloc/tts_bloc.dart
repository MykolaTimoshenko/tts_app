import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tts_app/domain/repositories/tts_repository.dart';

import 'tts_event.dart';
import 'tts_state.dart';

class TtsBloc extends Bloc<TtsEvent, TtsState> {
  final TtsRepository _ttsRepository;
  StreamSubscription<void>? _onCompleteSub;

  TtsBloc(this._ttsRepository) : super(const TtsState()) {
    on<TtsTextChanged>(_onTextChanged);
    on<TtsSpeakRequested>(_onSpeakRequested);
    on<TtsStopRequested>(_onStopRequested);
    on<TtsPlaybackCompleted>(_onPlaybackCompleted);

    _onCompleteSub = _ttsRepository.onSpeakCompletion.listen((_) {
      add(TtsPlaybackCompleted());
    });
  }

  void _onTextChanged(
    TtsTextChanged event,
    Emitter<TtsState> emit,
  ) {
    emit(state.copyWith(text: event.text));
  }

  Future<void> _onSpeakRequested(
    TtsSpeakRequested event,
    Emitter<TtsState> emit,
  ) async {
    emit(state.copyWith(isSpeaking: true));
    await _ttsRepository.speak(state.text);
  }

  Future<void> _onStopRequested(
    TtsStopRequested event,
    Emitter<TtsState> emit,
  ) async {
    await _ttsRepository.stop();
    emit(state.copyWith(isSpeaking: false));
  }

  Future<void> _onPlaybackCompleted(
    TtsPlaybackCompleted event,
    Emitter<TtsState> emit,
  ) async {
    await _ttsRepository.stop();
    emit(state.copyWith(isSpeaking: false));
  }

  @override
  Future<void> close() async {
    await _onCompleteSub?.cancel();
    return super.close();
  }
}
