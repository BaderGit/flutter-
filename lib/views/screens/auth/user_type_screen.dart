import 'package:final_project/data/sp_helper.dart';
import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/language_provider.dart';
import 'package:final_project/utils/app_router.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/views/screens/auth/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({Key? key}) : super(key: key);

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  String? selectedUserType;

  void _handleUserTypeChange(String? type) {
    setState(() {
      selectedUserType = type;
    });
  }

  void _navigateBasedOnUserType(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    if (selectedUserType == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(localizations.selectTypeError)));
      return;
    }

    SpHelper.spHelper.setUserType(selectedUserType!);
    Provider.of<AppAuthProvider>(context, listen: false).userType =
        selectedUserType!;
    AppRouter.navigateToWidget(const AuthPage());
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final localizations = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);

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
              Text(
                localizations.welcomeText,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,

              // User type selection
              Text(
                localizations.selectUserType,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,

              // Patient Radio Button
              RadioListTile<String>(
                activeColor: Config.primaryColor,
                title: Text(localizations.patient),
                value: 'patient',
                groupValue: selectedUserType,
                onChanged: _handleUserTypeChange,
              ),

              // Doctor Radio Button
              RadioListTile<String>(
                activeColor: Config.primaryColor,
                title: Text(localizations.doctor),
                value: 'doctor',
                groupValue: selectedUserType,
                onChanged: _handleUserTypeChange,
              ),

              // Staff Radio Button
              RadioListTile<String>(
                activeColor: Config.primaryColor,
                title: Text(localizations.staff),
                value: 'staff',
                groupValue: selectedUserType,
                onChanged: _handleUserTypeChange,
              ),

              Config.spaceMedium,

              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Config.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _navigateBasedOnUserType(context),
                  child: Text(localizations.continueText),
                ),
              ),
              Config.spaceSmall,
              Center(
                child: TextButton(
                  style: ButtonStyle(),
                  child: Text(
                    localizations.changeLanguage,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  onPressed: () {
                    languageProvider.toggleLanguage();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
