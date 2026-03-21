import 'package:flutter/material.dart';
import 'package:pokedex_app/themes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.pokemonGrey
          : AppColors.lightTextPrimary,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14
          )
        ),
      ),
    );
  }
}
