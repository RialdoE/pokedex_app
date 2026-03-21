import 'package:flutter/material.dart';
import 'package:pokedex_app/main.dart';
import 'package:pokedex_app/themes.dart';
import 'package:pokedex_app/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.pokemonRed),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (context, mode, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Icon(
                  Icons.person_add,
                  size: 80,
                  color: mode == ThemeMode.dark
                      ? AppColors.pokemonWhite
                      : AppColors.pokemonRed,
                ),
                const SizedBox(height: 12),
                const Text(
                  'New Trainer',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Start your journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: _emailController,
                  labelText: 'Email',
                ),
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                ),
                const SizedBox(height: 40),
                ElevatedButton(onPressed: _register, child: const Text('Register')),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: AppColors.pokemonRed,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.pokemonRed,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: themeNotifier.value == ThemeMode.dark,
                  onChanged: (value) {
                    themeNotifier.value = value
                        ? ThemeMode.dark
                        : ThemeMode.light;
                    SharedPreferences.getInstance().then(
                      (prefs) => prefs.setBool('isDark', value),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
