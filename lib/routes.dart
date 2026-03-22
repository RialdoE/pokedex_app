import 'package:pokedex_app/pages/home_page.dart';
import 'package:pokedex_app/pages/login_page.dart';
import 'package:pokedex_app/pages/register_page.dart';
import 'package:pokedex_app/pages/settings_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const settings = '/settings';

  static final routes = {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    home: (context) => const HomePage(),
    settings: (context) => const SettingsPage()
  };
}