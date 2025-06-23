import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/firestore_provider.dart';

import 'package:final_project/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/config.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final fireStore = Provider.of<FireStoreProvider>(context, listen: false);

  //     fireStore.getAllDoctors();

  //     log(
  //       "this is alldoctors from initState" +
  //           fireStore.allDoctors.length.toString(),
  //     );
  //   });
  //   super.initState();
  // }
  // getAllDoctors(BuildContext context) async {

  // }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     getAllDoctors(context);
  //   });
  // }

  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    // getAllDoctors(context);
    return Consumer2<AppAuthProvider, FireStoreProvider>(
      builder: (context, auth, fireStore, child) {
        // fireStore.getAllDoctors();
        // log(
        //   "this is the doctors list length" +
        //       fireStore.allDoctors.length.toString(),
        // );

        if (auth.userType != "doctor") {
          return Form(
            key: auth.loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  validator: (value) => auth.emailValidation(value),
                  controller: auth.emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Config.primaryColor,
                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                    labelText: 'Email',
                    // alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.email_outlined),
                    prefixIconColor: Config.primaryColor,
                  ),
                ),
                Config.spaceSmall,
                TextFormField(
                  validator: (value) => auth.passwordValidation(value),
                  controller: auth.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Config.primaryColor,
                  obscureText: obsecurePass,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
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
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: Config.primaryColor,
                            ),
                    ),
                  ),
                ),
                Config.spaceSmall,
                Button(
                  width: double.infinity,
                  title: "Sign In",

                  onPressed: () async {
                    // log("${doctor.length}");
                    await auth.signIn();
                    // log(doctor.length.toString());
                    // log(fireStore.allDoctors[0]!.email.toString());
                    // if (doctor.isNotEmpty) {
                    //   CustomShowDialog.showDialogFunction(
                    //     "u are not a patient",
                    //   );
                    // } else {

                    // }
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
                validator: (value) => auth.emailValidation(value),
                controller: auth.doctorEmailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Config.primaryColor,
                decoration: const InputDecoration(
                  hintText: 'Email Address',
                  labelText: 'Email',

                  prefixIcon: Icon(Icons.email_outlined),
                  prefixIconColor: Config.primaryColor,
                ),
              ),
              Config.spaceSmall,
              TextFormField(
                validator: (value) => auth.passwordValidation(value),
                controller: auth.doctorPasswordController,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: Config.primaryColor,
                obscureText: obsecurePass,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
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
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          ),
                  ),
                ),
              ),
              Config.spaceSmall,
              Button(
                width: double.infinity,
                title: "Sign In",

                onPressed: () async {
                  await auth.signIn();
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
