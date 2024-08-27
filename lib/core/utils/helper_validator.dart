class HelperValidator {
  static RegExp must8 = RegExp(r'.{8,}');

  static RegExp validEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!validEmail.hasMatch(value)) {
      return 'Enter a valid email address';
    } else if (!must8.hasMatch(value)) {
      return 'Email must be at least 8 characters long';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (!must8.hasMatch(value)) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  bool checkPasswordLength(String password) => must8.hasMatch(password);
  bool checkEmailLength(String email) => must8.hasMatch(email);
}
