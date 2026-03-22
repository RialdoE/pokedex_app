import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/widgets/custom_text_field.dart';

void main() {
  group('CustomTextField', () {
    testWidgets('renders label text correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: TextEditingController(),
              labelText: 'Email',
            ),
          ),
        ),
      );
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('shows eye icon when obscureText is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: TextEditingController(),
              labelText: 'password',
              obscureText: true,
            ),
          ),
        ),
      );
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('does not show eye icon when obscureText is false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: TextEditingController(),
              labelText: 'Email',
              obscureText: false,
            ),
          ),
        ),
      );
      expect(find.byIcon(Icons.visibility_off), findsNothing);
      expect(find.byIcon(Icons.visibility), findsNothing);
    });

    testWidgets('toggles password visibility when eye icon is tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: TextEditingController(),
              labelText: 'password',
              obscureText: true,
            ),
          ),
        ),
      );
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('shows validation error when validator fails', (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: TextEditingController(),
                    labelText: 'Email',
                    validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                  ),
                  ElevatedButton(
                    onPressed: () => formKey.currentState!.validate(),
                    child: const Text('Submit'),
                  )
                ],
              ),
            ),
          ),
        )
      );
      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(find.text('Please enter your email'), findsOneWidget);
    });
  });
}
