import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ElevenLabsDataSource {
  Future<Uint8List> synthesize({
    required String text,
    required String voiceId,
  }) async {
    final response = await http.post(
      Uri.parse(
        'https://api.elevenlabs.io/v1/text-to-speech/$voiceId',
      ),
      headers: {
        'xi-api-key': 'sk_d3e302a4215b161107952c326e48d44841406459344b8427',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'text': text,
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
