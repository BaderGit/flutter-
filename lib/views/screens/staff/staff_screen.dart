import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/providers/language_provider.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  _StaffScreenState createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    List<Map<String, dynamic>> medCat = [
      {
        "icon": FontAwesomeIcons.userDoctor,
        "category": AppLocalizations.of(context)!.general,
      },
      {
        "icon": FontAwesomeIcons.heartPulse,
        "category": AppLocalizations.of(context)!.cardiology,
      },
      {
        "icon": FontAwesomeIcons.lungs,
        "category": AppLocalizations.of(context)!.respirations,
      },
      {
        "icon": FontAwesomeIcons.hand,
        "category": AppLocalizations.of(context)!.dermatology,
      },
      {
        "icon": FontAwesomeIcons.personPregnant,
        "category": AppLocalizations.of(context)!.gynecology,
      },
      {
        "icon": FontAwesomeIcons.teeth,
        "category": AppLocalizations.of(context)!.dental,
      },
    ];

    return Consumer2<AppAuthProvider, FireStoreProvider>(
      builder: (context, auth, fireStore, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          localizations.addNewDoctor,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        IconButton(
                          onPressed: () {
                            auth.signOut();
                          },
                          icon: const Icon(Icons.logout),
                          tooltip: localizations.logout,
                        ),
                      ],
                    ),
                    Form(
                      key: auth.signUpKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) =>
                                auth.nullValidation(value, localizations),
                            controller: auth.doctorUserNameController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Config.primaryColor,
                            decoration: InputDecoration(
                              hintText: localizations.fullNameHint,
                              labelText: localizations.fullNameLabel,
                              prefixIcon: const Icon(Icons.email_outlined),
                              prefixIconColor: Config.primaryColor,
                            ),
                          ),
                          Config.spaceSmall,
                          DropdownButtonFormField<String>(
                            dropdownColor: Colors.white,
                            validator: (value) =>
                                auth.nullValidation(value, localizations),
                            decoration: InputDecoration(
                              hintText: localizations.specialityHint,
                              labelText: localizations.specialityLabel,
                              prefixIcon: const Icon(
                                Icons.medical_services_outlined,
                              ),
                              prefixIconColor: Config.primaryColor,
                            ),
                            value: auth.selectedSpeciality,
                            onChanged: (String? newValue) {
                              setState(() {
                                auth.selectedSpeciality = newValue;
                              });
                            },
                            items: medCat.map<DropdownMenuItem<String>>((
                              value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value["category"],
                                child: Text(value["category"]),
                              );
                            }).toList(),
                          ),
                          Config.spaceSmall,
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
                                    ? const Icon(
                                        Icons.visibility_off_outlined,
                                        color: Colors.black38,
                                      )
                                    : const Icon(
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
                            title: localizations.createAccount,
                            onPressed: () async {
                              await auth.doctorSignUp(localizations);
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
                                Provider.of<LanguageProvider>(
                                  context,
                                  listen: false,
                                ).toggleLanguage();
                              },
                            ),
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
