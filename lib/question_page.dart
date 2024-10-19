import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0; // Score initialisé à 0
  String? _selectedAnswer;
  bool _isAnswered = false;
  bool _isCorrect = false;

  // Liste des questions et réponses
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Quel est le plus long fleuve du monde?',
      'answers': ['Nil', 'Amazon', 'Mississippi'],
      'correctAnswer': 'Amazon',
    },
    {
      'question': 'Combien de côtés possède un triangle?',
      'answers': ['3', '4', '5'],
      'correctAnswer': '3',
    },
    {
      'question': 'Quel est le plus petit pays du monde?',
      'answers': ['Vatican', 'Monaco', 'Malte'],
      'correctAnswer': 'Vatican',
    },
    {
      'question': 'Dans quel pays peut-on visiter la Tour Eiffel?',
      'answers': ['France', 'Italie', 'Espagne'],
      'correctAnswer': 'France',
    },
    {
      'question': 'Quel est l’océan qui borde la côte ouest des États-Unis?',
      'answers': ['Pacifique', 'Atlantique', 'Indien'],
      'correctAnswer': 'Pacifique',
    },
  ];

  // Fonction pour vérifier la réponse et mettre à jour le score
  void _checkAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _isAnswered = true;
      _isCorrect = (answer == _questions[_currentQuestionIndex]['correctAnswer']);
      if (_isCorrect) {
        _score++; // Incrémente le score si la réponse est correcte
      }
    });
  }

  // Fonction pour passer à la question suivante
  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _isAnswered = false;
      });
    } else {
      // Si c'est la dernière question, aller à l'écran de résultats
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(score: _score, totalQuestions: _questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Page'),
        backgroundColor: Colors.blue, // Couleur de l'app bar en bleu
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
          children: <Widget>[
            Text(
              'Question ${_currentQuestionIndex + 1} / ${_questions.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue), // Couleur du texte en bleu
            ),
            const SizedBox(height: 20),
            Text(
              currentQuestion['question'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue), // Couleur du texte en bleu
              textAlign: TextAlign.center, // Center the question text
            ),
            const SizedBox(height: 20),
            Column(
              children: currentQuestion['answers'].map<Widget>((answer) {
                return ElevatedButton(
                  onPressed: _isAnswered
                      ? null
                      : () {
                          _checkAnswer(answer);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedAnswer == answer
                        ? (_isCorrect ? Colors.blue.shade700 : Colors.red)
                        : Colors.blue, // Couleur des boutons en bleu
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    answer,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (_isAnswered)
              Text(
                _isCorrect
                    ? 'Correct ! Vous avez bien répondu. 👍'
                    : 'Incorrect. La bonne réponse était : ${currentQuestion['correctAnswer']}. Essayez la prochaine question !',
                style: TextStyle(
                  fontSize: 18,
                  color: _isCorrect ? Colors.blue : Colors.red, // Couleur en fonction de la réponse
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Center the result text
              ),
            const SizedBox(height: 20),
            if (_isAnswered)
              ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Couleur du bouton en bleu
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Question Suivante',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Page de résultats
class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultPage({super.key, required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats'),
        backgroundColor: Colors.blue, // Couleur de l'app bar en bleu
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Vous avez terminé le quiz !',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue), // Couleur du texte en bleu
              ),
              const SizedBox(height: 20),
              Text(
                'Votre score : $score / $totalQuestions',
                style: TextStyle(fontSize: 22, color: Colors.blueAccent, fontWeight: FontWeight.bold), // Couleur du texte en bleu
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Retour à la première page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Couleur du bouton en bleu
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Recommencer',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
