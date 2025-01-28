import 'package:equatable/equatable.dart';

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

class TtsSpeakRequested extends TtsEvent {}

class TtsStopRequested extends TtsEvent {}

class TtsPlaybackCompleted extends TtsEvent {}
