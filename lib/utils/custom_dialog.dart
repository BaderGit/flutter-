import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/utils/app_router.dart';
import 'package:flutter/material.dart';

class CustomShowDialog {
  static showDialogFunction(String content, AppLocalizations localization) {
    showDialog(
      context: AppRouter.navKey.currentContext!,

      builder: (context) {
        return AlertDialog(
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                AppRouter.popRoute();
              },
              child: Text(localization.ok),
            ),
          ],
        );
      },
    );
  }
}
