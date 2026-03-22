import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/main.dart';
import 'package:pokedex_app/routes.dart';
import 'package:pokedex_app/services/auth_services.dart';
import 'package:pokedex_app/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.pokemonWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.pokemonRed,
        iconTheme: const IconThemeData(color: AppColors.pokemonWhite),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Email'),
            subtitle: Text(user?.email ?? 'Not logged in'),
          ),
          const Divider(),

          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder:(context, mode, _) {
              return SwitchListTile(
                secondary: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                value: mode == ThemeMode.dark,
                onChanged: (value) {
                  themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
                  SharedPreferences.getInstance().then(
                    (prefs) => prefs.setBool('isDark', value),
                  );
                },
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.pokemonRed),
            title: const Text(
              'Logout',
              style: TextStyle(color: AppColors.pokemonRed),
            ),
            onTap: () async {
              await authService.logout();
              if(context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.login, 
                  (route) => false,
                  );
              }
            },
          )
        ],
      ),
    );
  }
}