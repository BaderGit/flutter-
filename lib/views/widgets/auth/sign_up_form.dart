import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/config.dart';
import '../../../../l10n/app_localizations.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Consumer2<AppAuthProvider, FireStoreProvider>(
      builder: (context, auth, fireStore, child) {
        return Form(
          key: auth.signUpKey,
          child: Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      auth.pickImage();
                    },
                    child: CircleAvatar(
                      radius: 64,
                      backgroundImage: auth.selectedImage != null
                          ? FileImage(auth.selectedImage!)
                          : const AssetImage("assets/profile33.jpg")
                                as ImageProvider,
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 80,
                    child: IconButton(
                      onPressed: () {
                        auth.pickImage();
                      },
                      icon: Icon(
                        size: 30,
                        Icons.add_a_photo,
                        color: Config.primaryColor,
                      ),
                      tooltip: localizations.uploadPhoto,
                    ),
                  ),
                ],
              ),
              Config.spaceSmall,
              TextFormField(
                controller: auth.userNameController,
                decoration: InputDecoration(
                  hintText: localizations.fullNameHint,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                validator: (value) => auth.nullValidation(value, localizations),
              ),
              Config.spaceSmall,
              TextFormField(
                controller: auth.ageController,
                decoration: InputDecoration(
                  hintText: localizations.ageHint,
                  prefixIcon: const Icon(Icons.cake),
                ),
                validator: (value) => auth.nullValidation(value, localizations),
              ),
              Config.spaceSmall,
              // Replace the gender TextFormField with Radio buttons
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.genderHint,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'male',
                        autofocus: true,
                        activeColor: Config.primaryColor,
                        groupValue: auth.selectedGender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              auth.selectedGender = value;
                            });
                          }
                        },
                      ),
                      Text(localizations.male),
                      Radio<String>(
                        activeColor: Config.primaryColor,
                        value: 'female',
                        groupValue: auth.selectedGender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              auth.selectedGender = value;
                            });
                          }
                        },
                      ),
                      Text(localizations.female),
                      // Add more options if needed
                    ],
                  ),
                ],
              ),
              Config.spaceSmall,
              TextFormField(
                controller: auth.emailController,
                decoration: InputDecoration(
                  hintText: localizations.emailHint,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                validator: (value) => auth.nullValidation(value, localizations),
              ),
              Config.spaceSmall,
              TextFormField(
                controller: auth.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: localizations.passwordHint,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                validator: (value) =>
                    auth.passwordValidation(value, localizations),
              ),
              Config.spaceMedium,
              Button(
                width: double.infinity,
                title: localizations.createAccount,
                onPressed: () async {
                  await auth.userSignUp(localizations);
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
