import 'package:equatable/equatable.dart';

class TtsState extends Equatable {
  final String text;
  final bool isSpeaking;

  const TtsState({
    this.text = '',
    this.isSpeaking = false,
  });

  TtsState copyWith({String? text, bool? isSpeaking}) {
    return TtsState(
      text: text ?? this.text,
      isSpeaking: isSpeaking ?? this.isSpeaking,
    );
  }

  @override
  List<Object?> get props => [text, isSpeaking];
}
