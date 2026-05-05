import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIRemoteDataSource {
  final Dio _dio;
  final String _baseUrl = 'https://api.deepseek.com';

  AIRemoteDataSource(this._dio);

  String get _apiKey => dotenv.get('DEEPSEEK_API_KEY', fallback: '');

  Future<String> getAIResponse(String prompt, {String? context}) async {
    try {
      if (_apiKey.isEmpty) {
        throw Exception('API Key de DeepSeek no configurada en .env');
      }

      final fullPrompt = context != null 
          ? 'Basado en el siguiente contenido del documento:\n$context\n\nPregunta: $prompt'
          : prompt;

      final response = await _dio.post(
        '$_baseUrl/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'deepseek-chat',
          'messages': [
            {'role': 'system', 'content': 'Eres un tutor experto de EstudiaYa. Tu objetivo es ayudar a los estudiantes a entender sus documentos y temas de estudio de forma clara y didáctica.'},
            {'role': 'user', 'content': fullPrompt},
          ],
          'stream': false,
        },
      );

      if (response.statusCode == 200) {
        return response.data['choices'][0]['message']['content'];
      } else {
        throw Exception('Error al obtener respuesta de DeepSeek');
      }
    } catch (e) {
      throw Exception('Error de conexión con DeepSeek: $e');
    }
  }
}
