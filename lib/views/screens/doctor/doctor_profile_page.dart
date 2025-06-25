import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/providers/language_provider.dart';
import 'package:final_project/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorProfilePage extends StatefulWidget {
  DoctorProfilePage({Key? key}) : super(key: key);

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Consumer<FireStoreProvider>(
      builder: (context, fireStore, child) {
        return fireStore.doctor == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: double.infinity,
                      color: Config.primaryColor,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 110),
                          CircleAvatar(
                            radius: 65.0,
                            backgroundImage: AssetImage('assets/profile1.jpg'),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            fireStore.doctor!.name,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: Card(
                          margin: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                          child: SizedBox(
                            width: 300,
                            height: 260,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    localizations.profile,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Divider(color: Colors.grey[300]),
                                  Config.spaceSmall,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.language,
                                        color: Colors.yellowAccent[400],
                                        size: 35,
                                      ),
                                      const SizedBox(width: 20),
                                      TextButton(
                                        onPressed: () {
                                          Provider.of<LanguageProvider>(
                                            context,
                                            listen: false,
                                          ).toggleLanguage();
                                        },
                                        child: Text(
                                          localizations.changeLanguage,
                                          style: TextStyle(
                                            color: Config.primaryColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Config.spaceSmall,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.logout_outlined,
                                        color: Colors.lightGreen[400],
                                        size: 35,
                                      ),
                                      const SizedBox(width: 20),
                                      TextButton(
                                        onPressed: () async {
                                          Provider.of<AppAuthProvider>(
                                            context,
                                            listen: false,
                                          ).signOut();
                                        },
                                        child: Text(
                                          localizations.logout,
                                          style: TextStyle(
                                            color: Config.primaryColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
