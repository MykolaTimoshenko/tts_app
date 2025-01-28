import 'package:equatable/equatable.dart';
import 'package:tts_app/presentation/pages/home_page.dart';

class TtsState extends Equatable {
  final String text;
  final bool isSpeaking;
  final TtsProvider provider;

  const TtsState({
    this.text = '',
    this.isSpeaking = false,
    this.provider = TtsProvider.local,
  });

  TtsState copyWith({
    String? text,
    bool? isSpeaking,
    TtsProvider? provider,
  }) {
    return TtsState(
      text: text ?? this.text,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      provider: provider ?? this.provider,
    );
  }

  @override
  List<Object> get props => [text, isSpeaking, provider];
}
