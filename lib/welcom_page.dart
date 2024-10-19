import 'package:flutter/material.dart';
import 'question_page.dart'; // Import de la page de quiz

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Page'),
        backgroundColor: const Color.fromARGB(255, 58, 183, 83),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome !',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/welcom3.png', // Assurez-vous que le chemin est correct
              width: 500,  // Largeur de l'image
              height: 500, // Hauteur de l'image
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la page Quiz
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                );
              },
              child: const Text('Commencer'),
            ),
          ],
        ),
      ),
    );
  }
}
