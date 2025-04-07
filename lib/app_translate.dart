import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'fr_FR': {
          '_title': 'CONNEXION',
          'remember': 'Se rappeler de moi',
          'forgot_password': 'Mot de passe oublié?',
          'phone_number': 'Numéro de téléphone',
          'password': 'Mot de passe',
          'log_in': 'SE CONNECTER',
          'have_not_account': 'Vous n\'avez pas encore de compte ?',
          'sign_up': 'Inscrivez-vous',
          'register': 'INSCRIPTION',
          'full_name': 'Nom et prénoms',
          'email_adress': 'Entrer votre e-mail',
          'select_city': 'Sélectionner une ville',
          'sign_up_register': 'S\'INSCRIRE',
          'already_account': 'Dèjà un compte ?',
          'login_in_register': 'Connectez-vous',
        },
        'en_US': {
          'login_title': 'LOGIN',
          'remember': 'Remember me',
          'forgot_password': 'Forgot your password?',
          'phone_number': 'Phone number',
          'password': 'Password',
          'log_in': 'LOG IN',
          'have_not_account': 'Don\'t have an account?',
          'sign_up': 'Sign up',
          'register': 'REGISTER',
          'full_name': 'Full name',
          'email_adress': 'Enter your e-mail address',
          'select_city': 'Select a city',
          'sign_up_register': 'SIGN UP',
          'already_account': 'Already have an account?',
          'login_in_register': 'log in',
        },
      };
}
