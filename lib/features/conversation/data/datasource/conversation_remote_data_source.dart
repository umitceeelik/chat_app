import 'dart:convert';

import 'package:chat_app/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ConversationRemoteDataSource {
  final String baseUrl;
  final _storage = FlutterSecureStorage();

  ConversationRemoteDataSource({required this.baseUrl});

  Future<List<ConversationModel>> fetchConversations() async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/conversations'),
      headers: {
        'Authorization': 'Bearer $token',
      }
    );
    
    if(response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ConversationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch conversations');
    }
  }

  Future<String> checkOrCreateConversations({required String contactId}) async {
    String token = await _storage.read(key: 'token') ?? '';

    final url = Uri.parse('${baseUrl}/conversations/check-or-create');

    final response = await http.post(
      url,
      body: jsonEncode({'contactId': contactId}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return data['conversationId'];
    } else {
      throw Exception('Failed to check or create conversations');
    }
  }
}