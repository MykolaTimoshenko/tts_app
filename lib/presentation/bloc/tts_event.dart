import 'package:equatable/equatable.dart';
import 'package:tts_app/domain/enums/tts_provider_type.dart';

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

class TtsProviderChanged extends TtsEvent {
  final TtsProviderType provider;

  const TtsProviderChanged(this.provider);

  @override
  List<Object?> get props => [provider];
}

class TtsPlaybackCompleted extends TtsEvent {}
