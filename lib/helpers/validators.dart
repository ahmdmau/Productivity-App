class Validator {
  Validator();

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Please enter a valid email address.';
    else
      return null;
  }

  String? password(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Password must be at least 6 characters.';
    else
      return null;
  }

  String? repeatPassword(String? value, String password) {
    if (value!.isEmpty || value != password)
      return 'Password must be at least 6 characters.';
    else
      return null;
  }

  String? name(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Please enter a name.';
    else
      return null;
  }

  String? notEmpty(String? value) {
    if (value!.isEmpty)
      return 'This is a required field.';
    else
      return null;
  }
}
