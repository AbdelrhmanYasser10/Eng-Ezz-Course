
String? emailValidator(String? value){
    if(value == null) {
      return "Please enter a valid email";
    } else if(value.isEmpty){ return "Email cannot be empty";}
    else{
      final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );
      if(!emailRegex.hasMatch(value)){
        return "Please enter a valid email";
      }
      else{
        return null;
      }
    }
}

String? usernameValidator(String? value){
  if(value == null) {
    return "Enter a valid username";
  }
  else if(value.isEmpty){
    return "Username cannot be empty";
  }
  else{
    if(value.length < 5){
      return "Username cannot be less than 5 characters";
    }
    return null;
  }
}

String? passwordValidator(String? value){
  if(value == null) {
    return "Enter a valid password";
  }
  else if(value.isEmpty){
    return "Password is too short";
  }
  else{
    final passwordRegex = RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*\d).{8,}$');
    if(!passwordRegex.hasMatch(value)){
      return "Password must contain (special character,numbers,and at least 8 characters";
    }
    else{
      return null;
    }
  }
}