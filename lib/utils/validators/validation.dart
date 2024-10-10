class AppValidator{

  static String? validateEmptyText(String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return '$fieldName is required.';
    }

    return null;
  }

  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    
    if(!emailRegExp.hasMatch(value)){
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return 'Password is required.';
    }

    // Check for minimum password lenght
    if(value.length<6){
      return 'Password must be at least 6 characters long.';
    }

    // Check for Upper Case
    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'Password must contain at least 1  upper case character.';
    }

    // Check for Number
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least one number.';
    }

    // Check for Special Character
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return 'Password must contain at least 1  special character.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return 'Phone Number is required.';
    }

    final phoneRegExp = RegExp(r'^\d{11}$');

    if(!phoneRegExp.hasMatch(value)){
      return 'invalidate phone number formate (10 digit required).';
    }
    return null;
  }
}