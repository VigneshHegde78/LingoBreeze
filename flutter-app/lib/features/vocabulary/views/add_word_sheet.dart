import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/word.dart';
import '../providers/vocabulary_provider.dart';

class AddWordSheet extends ConsumerStatefulWidget {
  const AddWordSheet({super.key});

  @override
  ConsumerState<AddWordSheet> createState() => _AddWordSheetState();
}

class _AddWordSheetState extends ConsumerState<AddWordSheet> {
  // 1. These controllers grab the text typing inputs
  final _formKey = GlobalKey<FormState>();
  final _wordController = TextEditingController();
  final _meaningController = TextEditingController();
  final _translationController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _wordController.dispose();
    _meaningController.dispose();
    _translationController.dispose();
    super.dispose();
  }

  void _submitData() async {
    // Check if fields are filled out properly
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final newWord = Word(
      word: _wordController.text.trim(),
      meaning: _meaningController.text.trim(),
      translation: _translationController.text.trim(),
    );

    try {
      // 2. Call our repository directly to save the word to Firebase
      await ref.read(vocabularyRepositoryProvider).addWord(newWord);

      // 3. THE MAGIC STEP: Tell Riverpod that the old data list is garbage now!
      // This forces the main view to make a fresh GET request to your Node API.
      ref.invalidate(wordsProvider);

      // Close the bottom sheet safely
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save word: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // This padding handles the on-screen keyboard spacing dynamically
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add New Word',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _wordController,
              decoration: const InputDecoration(
                labelText: 'Word',
                border: OutlineInputBorder(),
              ),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Word is required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _meaningController,
              decoration: const InputDecoration(
                labelText: 'Meaning',
                border: OutlineInputBorder(),
              ),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Meaning is required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _translationController,
              decoration: const InputDecoration(
                labelText: 'Translation',
                border: OutlineInputBorder(),
              ),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Translation is required' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitData,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save Word'),
            ),
          ],
        ),
      ),
    );
  }
}
