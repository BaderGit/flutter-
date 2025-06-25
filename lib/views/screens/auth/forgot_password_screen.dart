import 'package:final_project/data/auth_helper.dart';
import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/language_provider.dart';
import 'package:final_project/utils/app_router.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Consumer2<AppAuthProvider, LanguageProvider>(
      builder: (context, auth, lang, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Form(
                key: auth.forgetPassUpKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            localizations.resetPasswordRequestButtonText,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Expanded(child: SizedBox()),
                                IconButton(
                                  onPressed: () {
                                    AppRouter.popRoute();
                                  },
                                  icon: Icon(Icons.arrow_forward),
                                  tooltip: localizations.backButtonTooltip,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Config.spaceBig,

                      TextFormField(
                        validator: (value) =>
                            auth.emailValidation(value, localizations),
                        controller: auth.forgetPasswordEmailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Config.primaryColor,
                        decoration: InputDecoration(
                          hintText: localizations.emailHint,
                          labelText: localizations.emailLabel,
                          prefixIcon: const Icon(Icons.email_outlined),
                          prefixIconColor: Config.primaryColor,
                        ),
                      ),
                      Config.spaceSmall,
                      Button(
                        width: double.infinity,
                        title: localizations.resetPasswordRequestButtonText,
                        onPressed: () async {
                          await auth.forgetPassword(localizations);
                        },
                        disable: false,
                      ),
                      Config.spaceSmall,
                      Center(
                        child: TextButton(
                          child: Text(
                            localizations.changeLanguage,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          onPressed: () {
                            lang.toggleLanguage();
                          },
                        ),
                      ),
                      Center(
                        child: TextButton(
                          child: Text(
                            localizations.changeLanguage,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          onPressed: () {
                            AuthHelper.authHelper.forgetPassword(
                              "baderahed21@gmail.com",
                              localizations,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
