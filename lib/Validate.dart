import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Validate {
  // Validates an email address.
  static bool isEmail(String value) {
    if (EmailValidator.validate(value.trim())) {
      // if (emailRegEx.hasMatch(value.trim())) {
      return true;
    }
    return false;
  }

  /*
   * Returns an error message if email does not validate.
   */
  static String? validateEmail(String value) {
    String email = value.trim();
    if (email.isEmpty) {
      return 'Email is required.';
    }
    if (!isEmail(email)) {
      return 'Valid email required.';
    }
    return null;
  }

  /*
   * Returns an error message if required field is empty.
   */
  static String? requiredField(String value, String message) {
    if (value.trim().isEmpty) {
      return message;
    }
    return null;
  }
}
