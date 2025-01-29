import 'package:equatable/equatable.dart';
import 'package:tts_app/domain/enums/tts_provider_type.dart';

class TtsState extends Equatable {
  final String text;
  final bool isSpeaking;
  final TtsProviderType provider;

  const TtsState({
    this.text = '',
    this.isSpeaking = false,
    this.provider = TtsProviderType.local,
  });

  TtsState copyWith({
    String? text,
    bool? isSpeaking,
    TtsProviderType? provider,
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
