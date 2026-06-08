class Word {
    final String word;
    final String meaning;
    final String translation;

    Word({
        required this.word,
        required this.meaning,
        required this.translation,
    });

    // translates JSON into a Flutter object
    factory Word.fromJson(Map<String, dynamic> json) {
        return Word(
            word: json['word'] ?? '',
            meaning: json['meaning'] ?? '',
            translation: json['translation'] ?? '',
        );
    }

    // translates a Flutter object into JSON for Firebase
    Map<String, dynamic> toJson() {
        return {
            'word': word,
            'meaning': meaning,
            'translation': translation,
        };
    }
}