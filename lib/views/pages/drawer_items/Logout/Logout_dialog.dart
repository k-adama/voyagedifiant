import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Déconnexion"),
      content: Text("Voulez-vous vraiment vous déconnecter ?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fermer le popup
          },
          child: Text("Annuler"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fermer le popup
            onConfirm(); // Exécuter l'action de déconnexion
          },
          child: Text("Oui, Déconnecter"),
        ),
      ],
    );
  }
}



void showLogoutPopup(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return LogoutDialog(onConfirm: onConfirm);
    },
  );
}