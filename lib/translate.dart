import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'fr_FR': {
          'login_title': 'CONNEXION',
          'remember': 'Se rappeler de moi',
          'forgot_password': 'Mot de passe oublié?',
          'phone_number': 'Numéro de téléphone',
          'password': 'Mot de passe',
          'log_in': 'SE CONNECTER',
          'have_not_account': 'Vous n\'avez pas encore de compte ?',
          'sign_up': 'Inscrivez-vous',
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
        },
      };
}
