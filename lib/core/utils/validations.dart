

class Validators {
  static String? mobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }
    if (value.trim().length < 10) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password at least 6 characters';
    }
    return null;
  }

  static String? confirmPassword(String? value, String newPassword) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password at least 6 characters';
    }
    if (value != newPassword) {
      return 'Password does not match';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name at least 3 characters';
    }
    return null;
  }

  static String? selectDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Select Date';
    }
    return null;
  }

  static String? selectGlCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Select Gl Code';
    }
    return null;
  }

  static String? notEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter value';
    }
    return null;
  }

  static String? leaveType(String? value) {
    if (value == null) {
      return 'Please select Leave Type';
    }
    return null;
  }
}
