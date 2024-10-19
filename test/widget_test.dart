import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_hiboum/main.dart';

void main() {
  testWidgets('Login page test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Vérifier que le titre de la page de connexion est affiché
    expect(find.text('Login Page'), findsOneWidget);

    // Saisir un email
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    
    // Saisir un mot de passe
    await tester.enterText(find.byType(TextField).at(1), 'password');
    
    // Appuyer sur le bouton de connexion
    await tester.tap(find.text('Login'));
    await tester.pump(); // Mettre à jour l'interface utilisateur
  });
}
