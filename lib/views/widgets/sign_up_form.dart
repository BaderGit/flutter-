import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/views/widgets/button.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../utils/config.dart';

class SignUpForm extends StatelessWidget {
  // final Function() onSubmit;
  // final bool isLoading;

  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          : AssetImage("assets/profile33.jpg"),
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
                    ),
                  ),
                ],
              ),
              Config.spaceSmall,
              TextFormField(
                controller: auth.userNameController,
                decoration: const InputDecoration(
                  hintText: 'full name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) => auth.nullValidation(value),
              ),
              Config.spaceSmall,
              TextFormField(
                controller: auth.ageController,
                decoration: const InputDecoration(
                  hintText: 'age',
                  prefixIcon: Icon(Icons.cake),
                ),
                validator: (value) => auth.nullValidation(value),
              ),
              Config.spaceSmall,
              TextFormField(
                controller: auth.genderController,
                decoration: const InputDecoration(
                  hintText: 'gender',
                  prefixIcon: Icon(Icons.male),
                ),
                validator: (value) => auth.nullValidation(value),
              ),
              Config.spaceSmall,
              TextFormField(
                controller: auth.emailController,

                decoration: const InputDecoration(
                  hintText: ' Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) => auth.nullValidation(value),
              ),
              Config.spaceSmall,
              TextFormField(
                controller: auth.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: ' Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: (value) => auth.passwordValidation(value),
              ),
              Config.spaceMedium,
              Button(
                width: double.infinity,
                title: "create an account",

                onPressed: () async {
                  await auth.userSignUp();
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
