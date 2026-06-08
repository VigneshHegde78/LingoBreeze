import "dart:convert";
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import "package:cloud_firestore/cloud_firestore.dart";
import "package:lingobreeze/features/vocabulary/models/word.dart";

class VocabularyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 3. Create a dynamic getter for the Base URL
  String get _baseUrl {
    return 'http://localhost:3000';
  }

  // Get words from Node.js backend
  Future<List<Word>> getWords() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/words'))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Word.fromJson(item)).toList();
      } else {
        throw Exception('Server returned code ${response.statusCode}');
      }
    } catch (e) {
      // Catch timeouts or network connection failures explicitly
      throw Exception('Network error: $e');
    }
  }

  // Saving new words to Firebase Firestore
  Future<void> addWord(Word word) async {
    await _firestore.collection('words').add(word.toJson());
  }
}
