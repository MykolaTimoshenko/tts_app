import 'package:equatable/equatable.dart';
import 'package:tts_app/domain/enums/tts_voice_type.dart';

class TtsState extends Equatable {
  final String text;
  final bool isSpeaking;
  final TtsVoiceType voiceType;

  const TtsState({
    this.text = '',
    this.isSpeaking = false,
    this.voiceType = TtsVoiceType.local,
  });

  TtsState copyWith({
    String? text,
    bool? isSpeaking,
    TtsVoiceType? voiceType,
  }) {
    return TtsState(
      text: text ?? this.text,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      voiceType: voiceType ?? this.voiceType,
    );
  }

  @override
  List<Object> get props => [text, isSpeaking, voiceType];
}
