import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tts_app/core/utils/tts_player.dart';
import 'package:tts_app/domain/repositories/tts_repository.dart';

import 'tts_event.dart';
import 'tts_state.dart';

class TtsBloc extends Bloc<TtsEvent, TtsState> {
  final TtsRepository _repository;
  final TtsPlayer _player;

  StreamSubscription<void>? _playerSub;
  StreamSubscription<void>? _localTtsSub;

  TtsBloc(this._repository, this._player) : super(const TtsState()) {
    on<TtsTextChanged>(_onTextChanged);
    on<TtsSpeakRequested>(_onSpeakRequested);
    on<TtsStopRequested>(_onStopRequested);
    on<TtsProviderChanged>(_onProviderChanged);
    on<TtsPlaybackCompleted>(_onPlaybackCompleted);

    _playerSub = _player.onPlaybackComplete.listen((_) {
      add(TtsPlaybackCompleted());
    });
    _localTtsSub = _repository.onSpeakCompletion.listen((_) {
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
    await _repository.speak(state.text, state.provider);
  }

  Future<void> _onStopRequested(
    TtsStopRequested event,
    Emitter<TtsState> emit,
  ) async {
    await _repository.stop(state.provider);
    emit(state.copyWith(isSpeaking: false));
  }

  void _onProviderChanged(
    TtsProviderChanged event,
    Emitter<TtsState> emit,
  ) {
    emit(state.copyWith(provider: event.provider));
  }

  void _onPlaybackCompleted(
    TtsPlaybackCompleted event,
    Emitter<TtsState> emit,
  ) {
    emit(state.copyWith(isSpeaking: false));
  }

  @override
  Future<void> close() async {
    await _playerSub?.cancel();
    await _localTtsSub?.cancel();
    return super.close();
  }
}
