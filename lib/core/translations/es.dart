import 'package:careerpathai/core/constants/app_texts.dart';

final Map<String, String> es = {
  ...RegisterEs.map,
  ...LoginEs.map,
  ...HomeEs.map,
  ...AboutEs.map
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

class HomeEs {
  static const map = {
    HomeTexts.title: "Inicio",
    HomeTexts.welcomeBack: "Bienvenido de nuevo",
    HomeTexts.quickActions: "Acciones rápidas",
    HomeTexts.progress: "Progreso",
    HomeTexts.yourSkills: "Tus habilidades",
    HomeTexts.bestCareers: "Mejores carreras",
    HomeTexts.startText: "Empezar test",
    HomeTexts.results: "Resultados",
    HomeTexts.register: "Registrarse",
    HomeTexts.emptyTitle: "No hay datos disponibles",
    HomeTexts.emptySubtitle:
        "Comienza tu primer test para ver tu progreso aqui.",
    HomeTexts.profileTitle: "Perfil",
    HomeTexts.aboutTitle: "Acerca de",
  };
}

class AboutEs {
  static const map = {
    AboutTexts.title: "Acerca de",
    AboutTexts.options: "Opciones de información:",
    AboutTexts.history: "Historia",
    AboutTexts.help: "Ayuda",
    AboutTexts.showInformation: "Mostrar Información",
    AboutTexts.selected: "Seleccionado:",
  };
}
