import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/config.dart';
import '../../../../l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Consumer2<AppAuthProvider, FireStoreProvider>(
      builder: (context, auth, fireStore, child) {
        if (auth.userType != "doctor") {
          return Form(
            key: auth.loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  validator: (value) =>
                      auth.emailValidation(value, localizations),
                  controller: auth.emailController,
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
                TextFormField(
                  validator: (value) =>
                      auth.passwordValidation(value, localizations),
                  controller: auth.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Config.primaryColor,
                  obscureText: obsecurePass,
                  decoration: InputDecoration(
                    hintText: localizations.passwordHint,
                    labelText: localizations.passwordLabel,
                    alignLabelWithHint: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    prefixIconColor: Config.primaryColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obsecurePass = !obsecurePass;
                        });
                      },
                      icon: obsecurePass
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: Config.primaryColor,
                            ),
                      tooltip: obsecurePass
                          ? localizations.showPassword
                          : localizations.hidePassword,
                    ),
                  ),
                ),
                Config.spaceSmall,
                Button(
                  width: double.infinity,
                  title: localizations.signInButton,
                  onPressed: () async {
                    await auth.signIn(localizations);
                  },
                  disable: false,
                ),
              ],
            ),
          );
        }
        return Form(
          key: auth.loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                validator: (value) =>
                    auth.emailValidation(value, localizations),
                controller: auth.doctorEmailController,
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
              TextFormField(
                validator: (value) =>
                    auth.passwordValidation(value, localizations),
                controller: auth.doctorPasswordController,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: Config.primaryColor,
                obscureText: obsecurePass,
                decoration: InputDecoration(
                  hintText: localizations.passwordHint,
                  labelText: localizations.passwordLabel,
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  prefixIconColor: Config.primaryColor,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          ),
                    tooltip: obsecurePass
                        ? localizations.showPassword
                        : localizations.hidePassword,
                  ),
                ),
              ),
              Config.spaceSmall,
              Button(
                width: double.infinity,
                title: localizations.signInButton,
                onPressed: () async {
                  await auth.signIn(localizations);
                },
                disable: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
