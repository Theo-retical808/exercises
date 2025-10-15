import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        body: const Center(
          child: Flashcard(),
        ),
      ),
    );
  }
}

// A. The Flashcard Widget and createState() Method
class Flashcard extends StatefulWidget {
  const Flashcard({super.key});

  @override
  State<Flashcard> createState() => _FlashcardState();
}

// B. The _FlashcardState Class
class _FlashcardState extends State<Flashcard> {
  bool _isAnswerVisible = false; // Answer hidden by default

  void _toggleAnswer() {
    setState(() {
      _isAnswerVisible = !_isAnswerVisible;
    });
  }

  // C. The build() Method
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'What is Flutter?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (_isAnswerVisible)
              const Text(
                'Flutter is an open-source UI toolkit by Google for building cross-platform apps.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleAnswer,
              child: Text(_isAnswerVisible ? 'Hide Answer' : 'Show Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
