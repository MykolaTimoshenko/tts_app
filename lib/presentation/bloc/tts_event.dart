import 'package:equatable/equatable.dart';
import 'package:tts_app/presentation/pages/home_page.dart';

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
  final TtsProvider provider;

  const TtsProviderChanged(this.provider);

  @override
  List<Object?> get props => [provider];
}
