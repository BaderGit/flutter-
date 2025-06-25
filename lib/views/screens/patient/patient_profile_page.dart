import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/providers/language_provider.dart';
import 'package:final_project/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/l10n/app_localizations.dart';

class PatientProfilePage extends StatefulWidget {
  PatientProfilePage({Key? key}) : super(key: key);

  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Consumer2<FireStoreProvider, LanguageProvider>(
      builder: (context, fireStore, lang, child) {
        return fireStore.patient == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: double.infinity,
                      color: Config.primaryColor,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 110),
                          CircleAvatar(
                            radius: 65.0,
                            backgroundImage: NetworkImage(
                              fireStore.patient!.imgUrl,
                            ),
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            fireStore.patient!.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${fireStore.patient!.age} ${localizations.yearsOld} | ${lang.getGenderLocalization(fireStore.patient!.gender, localizations)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
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
                                    style: const TextStyle(
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
                                          style: const TextStyle(
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
                                          style: const TextStyle(
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
