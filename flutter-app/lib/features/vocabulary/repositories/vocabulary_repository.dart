class VocabularyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _baseUrl = 'http://10.0.2.2:3000';

  // Get words from Node.js backend
  Future<List<Word>> getWords() async {
    final response = await http.get(Uri.parse('$_baseUrl/words'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Word.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load words');
    }
  }

  // Saving new words to Firebase Firestore
    Future<void> addWord(Word word) async {
        await _firestore.collection('words').add(word.toJson());
    }
}