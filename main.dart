import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Quiz',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.purple[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
              child: Text('Start'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[800],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  int questionIndex = 0;
  final List<Map<String, Object>> questions = [
    {
      'question': '1. Apa warna langit pada siang hari?',
      'options': [
        {'text': 'A. Biru', 'score': true},
        {'text': 'B. Hijau', 'score': false},
        {'text': 'C. Merah', 'score': false},
        {'text': 'D. Hitam', 'score': false},
      ],
    },
    {
      'question': '2. Which in the Solar System is the smallest?',
      'options': [
        {'text': 'A. Pluto', 'score': false},
        {'text': 'B. Earth', 'score': false},
        {'text': 'C. Mercury', 'score': true},
        {'text': 'D. Mars', 'score': false},
      ],
    },
    {
      'question': '3. Apa warna baju upin?',
      'options': [
        {'text': 'A. Kuning', 'score': true},
        {'text': 'B. Hitam', 'score': false},
        {'text': 'C. Putih', 'score': false},
        {'text': 'D. Merah', 'score': false},
      ],
    },
    {
      'question': '4. Apa warna api?',
      'options': [
        {'text': 'A. Merah', 'score': true},
        {'text': 'B. Biru', 'score': false},
        {'text': 'C. Hijau', 'score': false},
        {'text': 'D. Putih', 'score': false},
      ],
    },
  ];

  void answerQuestion(bool isCorrect) {
    if (isCorrect) {
      score++;
    }

    setState(() {
      questionIndex++;
    });

    if (questionIndex >= questions.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultPage(score)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.cloud,
                    size: 300, color: Colors.purple.withOpacity(0.5)),
                Positioned(
                  child: Text(
                    questions[questionIndex]['question'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...(questions[questionIndex]['options']
                    as List<Map<String, Object>>)
                .map((option) {
              return _buildOption(
                  option['text'] as String, option['score'] as bool);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String optionText, bool isCorrect) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: () => answerQuestion(isCorrect),
        child: Text(optionText),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple[300],
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          textStyle: const TextStyle(fontSize: 18),
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;

  ResultPage(this.score);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hasil Skor', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 20),
            Text('Anda mendapatkan skor $score dari total soal!',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Kembali ke Menu'),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.purple[800]),
            )
          ],
        ),
      ),
    );
  }
}
