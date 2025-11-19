import 'package:careerpathai/core/constants/app_texts.dart';

final Map<String, String> en = {
  ...RegisterEn.map,
  ...LoginEn.map,
  ...HomeEn.map,
  ...AboutEn.map
};

class RegisterEn {
  static const map = {
    RegisterTexts.title: "Register",
    RegisterTexts.fullName: "Full Name",
    RegisterTexts.email: "Email",
    RegisterTexts.password: "Password",
    RegisterTexts.acceptTerms: "I accept terms and conditions",
    RegisterTexts.button: "Register",
    RegisterTexts.completeFields: "Please complete all fields",
    RegisterTexts.accountCreated: "Account created succesfully!",
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

class HomeEn {
  static const map = {
    HomeTexts.title: "Home",
    HomeTexts.welcomeBack: "Welcome Back",
    HomeTexts.quickActions: "Quick Actions",
    HomeTexts.progress: "Progress",
    HomeTexts.yourSkills: "Your Skills",
    HomeTexts.bestCareers: "Best Careers",
    HomeTexts.startText: "Start Test",
    HomeTexts.results: "Results",
    HomeTexts.register: "Register",
    HomeTexts.emptyTitle: "No data available",
    HomeTexts.emptySubtitle: "Start your first test to see progress here.",
    HomeTexts.profileTitle: "Profile",
    HomeTexts.aboutTitle: "About",
  };
}

class AboutEn {
  static const map = {
    AboutTexts.title: "About",
    AboutTexts.options: "Information Options:",
    AboutTexts.history: "History",
    AboutTexts.help: "Help",
    AboutTexts.showInformation: "Show Information",
    AboutTexts.selected: "Selected:",
  };
}
