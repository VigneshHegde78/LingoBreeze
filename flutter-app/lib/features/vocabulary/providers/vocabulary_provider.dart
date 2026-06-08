import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/word.dart';
import '../repositories/vocabulary_repository.dart';

// 1. Provides Repository to the rest of the app
final vocabularyRepositoryProvider = Provider<VocabularyRepository>((ref) {
  return VocabularyRepository();
});

// 2. State Manager to fetch words from Node.js
final wordsProvider = FutureProvider<List<Word>>((ref) async {
  final repository = ref.read(vocabularyRepositoryProvider);
  return repository.getWords();
});
