import 'package:final_project/providers/auth_provider.dart';

import 'package:final_project/providers/language_provider.dart';
import 'package:final_project/utils/app_router.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/utils/text.dart';

import 'package:final_project/views/widgets/login_form.dart';
import 'package:final_project/views/widgets/sign_up_form.dart';

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

    return Consumer<AppAuthProvider>(
      builder: (context, auth, child) {
        // fireStore.getAllDoctors();
        // log(
        //   "this is the doctors list length" +
        //       fireStore.allDoctors.length.toString(),
        // );

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                            ? AppLocalizations.of(context)!.welcome
                            : auth.userType == "doctor"
                            ? AppLocalizations.of(context)!.welcome
                            : AppLocalizations.of(context)!.welcome,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Expanded(
                        child: Row(
                          children: [
                            // IconButton(
                            //   onPressed: () {
                            //     Provider.of<LanguageProvider>(
                            //       context,
                            //       listen: false,
                            //     ).toggleLanguage();
                            //   },
                            //   icon: Icon(Icons.language),
                            // ),
                            Expanded(child: SizedBox()),
                            IconButton(
                              onPressed: () {
                                AppRouter.popRoute();
                              },
                              icon: Icon(Icons.arrow_forward),
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
                        ? AppText.enText['signIn_text']!
                        : AppText.enText['register_text']!,
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
                          Provider.of<AppAuthProvider>(
                            context,
                            listen: false,
                          ).forgetPassword();
                        },
                        child: Text(
                          AppText.enText['forgot-password']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                  // Social login text
                  // Center(
                  //   child: Text(
                  //     AppText.enText['social-login']!,
                  //     style: TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.normal,
                  //       color: Colors.grey.shade500,
                  //     ),
                  //   ),
                  // ),
                  // Config.spaceSmall,

                  // Social buttons
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: const <Widget>[SocialButton(social: 'google')],
                  // ),
                  // Config.spaceSmall,

                  // Toggle between sign in/up
                  if (auth.userType == "patient")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          isSignIn
                              ? AppText.enText['signUp_text']!
                              : AppText.enText['registered_text']!,
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
                            isSignIn ? 'Sign Up' : 'Sign In',
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
                      style: ButtonStyle(),
                      child: Text(
                        "change language",
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

                  // Add some extra space at the bottom when keyboard appears
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
