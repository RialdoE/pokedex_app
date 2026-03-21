import 'package:pokedex_app/pages/login_page.dart';
import 'package:pokedex_app/pages/register_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';

  static final routes = {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
  };
}