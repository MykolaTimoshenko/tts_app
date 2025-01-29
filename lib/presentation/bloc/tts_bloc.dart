import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tts_app/core/utils/tts_player.dart';
import 'package:tts_app/domain/repositories/tts_repository.dart';

import 'tts_event.dart';
import 'tts_state.dart';

class TtsBloc extends Bloc<TtsEvent, TtsState> {
  final TtsRepository _ttsRepository;
  final TtsPlayer _ttsPlayer;

  StreamSubscription<void>? _playerSubscription;
  StreamSubscription<void>? _localTtsSubscription;

  TtsBloc(this._ttsRepository, this._ttsPlayer) : super(const TtsState()) {
    on<TtsTextChanged>(_onTextChanged);
    on<TtsSpeakRequested>(_onSpeakRequested);
    on<TtsStopRequested>(_onStopRequested);
    on<TtsVoiceChanged>(_onVoiceChanged);
    on<TtsPlaybackCompleted>(_onPlaybackCompleted);

    _playerSubscription = _ttsPlayer.onPlaybackComplete.listen((_) {
      add(TtsPlaybackCompleted());
    });
    _localTtsSubscription = _ttsRepository.onSpeakCompletion.listen((_) {
      add(TtsPlaybackCompleted());
    });
  }

  void _onTextChanged(TtsTextChanged event, Emitter<TtsState> emit) {
    emit(state.copyWith(text: event.text));
  }

  Future<void> _onSpeakRequested(
    TtsSpeakRequested event,
    Emitter<TtsState> emit,
  ) async {
    emit(state.copyWith(isSpeaking: true));
    await _ttsRepository.speak(state.text, state.voiceType);
  }

  Future<void> _onStopRequested(
    TtsStopRequested event,
    Emitter<TtsState> emit,
  ) async {
    await _ttsRepository.stop(state.voiceType);
    emit(state.copyWith(isSpeaking: false));
  }

  void _onVoiceChanged(
    TtsVoiceChanged event,
    Emitter<TtsState> emit,
  ) {
    emit(state.copyWith(voiceType: event.voice));
  }

  void _onPlaybackCompleted(
    TtsPlaybackCompleted event,
    Emitter<TtsState> emit,
  ) {
    emit(state.copyWith(isSpeaking: false));
  }

  @override
  Future<void> close() async {
    await _playerSubscription?.cancel();
    await _localTtsSubscription?.cancel();
    return super.close();
  }
}
