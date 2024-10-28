String? validateName(String name) {
  if (name.isEmpty) {
    return 'Please enter name';
  }
  return null;
}

String? validateEmail(String email) {
  if (email.isEmpty) {
    return 'Please enter email';
  }
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegExp.hasMatch(email)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePassword(String password) {
  if (password.isEmpty) {
    return 'Please enter password';
  }
  return null;
}

String? validatePhoneNumber(String number) {
  if (number.isEmpty) {
    return 'Please enter phone number';
  } else if (number.length != 10) {
    return 'Please enter valid phone number';
  }
  return null;
}

String? validateAndMatchPassword(
    {required String password, required String reEnteredPassword}) {
  if (password.isEmpty) {
    return 'Please enter password';
  } else if (password != reEnteredPassword) {
    return "Password doesn't match";
  } else {
    return null;
  }
}

String? validateField({required String value, required String title}) {
  if (value.isEmpty) {
    return 'Please enter $title';
  }
  return null;
}
