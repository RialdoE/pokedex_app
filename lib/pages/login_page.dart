import 'package:flutter/material.dart';
import 'package:pokedex_app/main.dart';
import 'package:pokedex_app/routes.dart';
import 'package:pokedex_app/themes.dart';
import 'package:pokedex_app/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {}

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
                  Icons.catching_pokemon,
                  size: 80,
                  color: mode == ThemeMode.dark
                      ? AppColors.pokemonWhite
                      : AppColors.pokemonRed,
                ),
                const SizedBox(height: 12),
                const Text(
                  'PokéDex',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Welcome back, Trainer!',
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
                ElevatedButton(onPressed: _login, child: const Text('Log In')),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.register),
                      child: const Text(
                        'Register',
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
