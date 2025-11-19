import 'package:careerpathai/core/constants/app_texts.dart';

final Map<String, String> es = {
  ...RegisterEs.map,
  ...LoginEs.map,
};

class RegisterEs {
  static const map = {
    RegisterTexts.title: "Registro",
    RegisterTexts.fullName: "Nombre Completo",
    RegisterTexts.email: "Correo",
    RegisterTexts.password: "Contraseña",
    RegisterTexts.acceptTerms: "Acepto términos y condiciones",
    RegisterTexts.button: "Registrarse",
    RegisterTexts.completeFields: "Por completa todos los campos",
    RegisterTexts.accountCreated: "Cuenta creada exitosamente",
  };
}

class LoginEs {
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
