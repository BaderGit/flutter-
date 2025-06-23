import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({Key? key}) : super(key: key);

  @override
  _StaffScreenState createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  bool obsecurePass = true;
  // To track the selected speciality

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppAuthProvider, FireStoreProvider>(
      builder: (context, auth, fireStore, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Add New Doctor',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        IconButton(
                          onPressed: () {
                            auth.signOut();
                          },
                          icon: Icon(Icons.logout),
                        ),
                      ],
                    ),
                    Form(
                      key: auth.signUpKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) => auth.nullValidation(value),
                            controller: auth.doctorUserNameController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Config.primaryColor,
                            decoration: const InputDecoration(
                              hintText: 'full name',
                              labelText: 'full name',
                              prefixIcon: Icon(Icons.email_outlined),
                              prefixIconColor: Config.primaryColor,
                            ),
                          ),
                          Config.spaceSmall,
                          // Replaced TextField with DropdownButtonFormField
                          DropdownButtonFormField<String>(
                            dropdownColor: Colors.white,
                            validator: (value) => auth.nullValidation(value),
                            decoration: const InputDecoration(
                              hintText: 'speciality',
                              labelText: 'speciality',
                              prefixIcon: Icon(Icons.medical_services_outlined),
                              prefixIconColor: Config.primaryColor,
                            ),
                            value: auth.selectedSpeciality,
                            onChanged: (String? newValue) {
                              setState(() {
                                auth.selectedSpeciality = newValue;
                              });
                            },
                            items: fireStore.medCat
                                .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value["category"],
                                    child: Text(value["category"]),
                                  );
                                })
                                .toList(),
                          ),
                          Config.spaceSmall,
                          TextFormField(
                            validator: (value) => auth.emailValidation(value),
                            controller: auth.doctorEmailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Config.primaryColor,
                            decoration: const InputDecoration(
                              hintText: 'Email Address ',
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                              prefixIconColor: Config.primaryColor,
                            ),
                          ),
                          Config.spaceSmall,
                          TextFormField(
                            validator: (value) =>
                                auth.passwordValidation(value),
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
                            title: "create an account",

                            onPressed: () async {
                              await auth.doctorSignUp();
                              // setState(() {
                              //   selectedSpeciality = null;
                              // });
                            },
                            disable: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
