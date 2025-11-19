import 'package:careerpathai/core/constants/app_texts.dart';

final Map<String, String> es = {
  ...RegisterEs.map,
  ...LoginEs.map,
};

class RegisterEs {
  static const map = {
    RegisterTexts.title: "Registrarse",
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
    LoginTexts.title: "Inicir Sesión ",
    LoginTexts.email: "Correo",
    LoginTexts.password: "Contraseña",
    LoginTexts.confirmPassword: "Confirm Password",
    LoginTexts.button: "Iniciar Sesión",
    LoginTexts.createAccount: "Crear una cuenta",
    LoginTexts.fillFields: "Por favor completa todos los campos",
    LoginTexts.invalidCredentials: "Credenciales inválidas",
    LoginTexts.error: "Error"
  };
}
