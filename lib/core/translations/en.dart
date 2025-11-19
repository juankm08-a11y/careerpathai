import 'package:careerpathai/core/constants/app_texts.dart';

final Map<String, String> en = {...RegisterEn.map, ...LoginEn.map};

class RegisterEn {
  static const map = {
    RegisterTexts.title: "Register",
    RegisterTexts.fullName: "Full Name",
    RegisterTexts.email: "Email",
    RegisterTexts.password: "Password",
    RegisterTexts.acceptTerms: "I accept terms and conditions",
    RegisterTexts.button: "Register",
    RegisterTexts.completeFields: "Please complete all fields",
  };
}

class LoginEn {
  static const map = {
    LoginTexts.title: "Sign In",
    LoginTexts.email: "Email",
    LoginTexts.password: "Password",
    LoginTexts.confirmPassword: "Confirm Password",
    LoginTexts.button: "Sign In",
    LoginTexts.createAccount: "Create an Account",
    LoginTexts.fillFields: "Please fill all fields",
    LoginTexts.invalidCredentials: "Invalid Credentials",
    LoginTexts.error: "Error"
  };
}
