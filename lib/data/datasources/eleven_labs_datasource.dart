import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ElevenLabsDataSource {
  final String _voiceId = 'YOUR_VOICE_ID';

  Future<Uint8List> synthesize(String text) async {
    final response = await http.post(
      Uri.parse(
          'https://api.elevenlabs.io/v1/text-to-speech/JBFqnCBsd6RMkjVDRZzb'),
      headers: {
        'xi-api-key': 'sk_d3e302a4215b161107952c326e48d44841406459344b8427',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'text': text,
        'output_format': 'mp3_44100_128',
        'model_id': "eleven_multilingual_v2",
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'ElevenLabs synthesis failed. Status: ${response.statusCode}',
      );
    }
    return response.bodyBytes;
  }
}
