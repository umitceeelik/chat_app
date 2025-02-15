import 'dart:convert';
import 'package:chat_app/features/contacts/data/models/contacts_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ContactsRemoteDataSource {
  final String baseUrl;
  final _storage = FlutterSecureStorage();

  ContactsRemoteDataSource({required this.baseUrl});

  
  Future<List<ContactsModel>> fetchContacts() async {
    String token = await _storage.read(key: 'token') ?? '';
    
    final response = await http.get(
      Uri.parse('$baseUrl/contacts'),
      headers: {
        'Authorization': 'Bearer $token', 
      },
    );


    if(response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ContactsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch contacts');
    }
  }

  Future<void> addContact({required String email}) async {
    String token = await _storage.read(key: 'token') ?? '';
    final response = await http.post(
      Uri.parse('$baseUrl/contacts'),
      body: jsonEncode({
        'contactEmail': email,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', 
      },
    );

    if(response.statusCode != 201) {
      throw Exception('Failed to add contact');
    }
  }

  Future<List<ContactsModel>> fetchRecentContacts() async {
    String token = await _storage.read(key: 'token') ?? '';
    
    final response = await http.get(
      Uri.parse('$baseUrl/contacts/recent'),
      headers: {
        'Authorization': 'Bearer $token', 
      },
    );

    if(response.statusCode == 200) {
      List data = jsonDecode(response.body);
      print(data);
      return data.map((json) => ContactsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch contacts');
    }
  }
    
}