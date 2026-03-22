import 'package:flutter/material.dart';
import 'package:pokedex_app/routes.dart';
import 'package:pokedex_app/services/auth_services.dart';
import 'package:pokedex_app/themes.dart';
import 'package:pokedex_app/validators/validators.dart';
import 'package:pokedex_app/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    final error = await _authService.register(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    } else {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.pokemonRed),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Icon(
                      Icons.person_add,
                      size: 80,
                      color: Theme.of(context).brightness == Brightness.dark
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
                      validator: Validators.email,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      obscureText: true,
                      validator: Validators.password,
                    ),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      obscureText: true,
                      validator: (value) => Validators.confirmPassword(
                        value,
                        _passwordController.text,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _register,
                      child: const Text('Register'),
                    ),
                
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
                  ],
                ),
        ),
      ),
    );
  }
}
