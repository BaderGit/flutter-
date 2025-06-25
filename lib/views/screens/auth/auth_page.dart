import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/language_provider.dart';
import 'package:final_project/utils/app_router.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/views/screens/auth/forgot_password_screen.dart';
import 'package:final_project/views/widgets/auth/login_form.dart';
import 'package:final_project/views/widgets/auth/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final localizations = AppLocalizations.of(context)!;

    return Consumer<AppAuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Welcome text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        auth.userType == "patient"
                            ? localizations.welcomePatient
                            : auth.userType == "doctor"
                            ? localizations.welcomeDoctor
                            : localizations.welcomeAdmin,
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
                  Config.spaceSmall,

                  // Sign in/up text
                  Text(
                    isSignIn
                        ? localizations.signInText
                        : localizations.registerText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Config.spaceSmall,

                  // Form
                  isSignIn ? LoginForm() : SignUpForm(),
                  Config.spaceSmall,

                  // Forgot password (only for sign in)
                  if (isSignIn)
                    Center(
                      child: TextButton(
                        onPressed: () {
                          AppRouter.navigateToWidget(ForgotPasswordScreen());
                        },
                        child: Text(
                          localizations.forgotPassword,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                  // Toggle between sign in/up
                  if (auth.userType == "patient")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          isSignIn
                              ? localizations.signUpPrompt
                              : localizations.signInPrompt,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isSignIn = !isSignIn;
                            });
                          },
                          child: Text(
                            isSignIn
                                ? localizations.signUpButton
                                : localizations.signInButton,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  Config.spaceMedium,

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
                        Provider.of<LanguageProvider>(
                          context,
                          listen: false,
                        ).toggleLanguage();
                      },
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
