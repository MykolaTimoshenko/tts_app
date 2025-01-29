import 'package:equatable/equatable.dart';
import 'package:tts_app/domain/enums/tts_voice_type.dart';

abstract class TtsEvent extends Equatable {
  const TtsEvent();

  @override
  List<Object?> get props => [];
}

class TtsTextChanged extends TtsEvent {
  final String text;

  const TtsTextChanged(this.text);

  @override
  List<Object?> get props => [text];
}

class TtsVoiceChanged extends TtsEvent {
  final TtsVoiceType voice;

  const TtsVoiceChanged(this.voice);

  @override
  List<Object?> get props => [voice];
}

class TtsSpeakRequested extends TtsEvent {}

class TtsStopRequested extends TtsEvent {}

class TtsPlaybackCompleted extends TtsEvent {}
