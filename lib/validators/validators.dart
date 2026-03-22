class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email.';
    final regex = RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$');
    if (!regex.hasMatch(value)) return 'Please enter a valid email.';
    return null; 
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password.';
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*]).{8,}$'); 
    if (!regex.hasMatch(value)) return 'Password must be at least 8 characters, include an uppercase letter, a number and a special character.';
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Please confirm your password.';
    if (value != password) return 'Passwords do not match.';
    return null; 
  }
}