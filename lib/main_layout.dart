import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/firestore_provider.dart';

import 'package:final_project/views/screens/appointment/appointment_page.dart';
import 'package:final_project/views/screens/doctor/doctor_profile_page.dart';
import 'package:final_project/views/screens/doctor/doctor_home_page.dart';
import 'package:final_project/views/screens/appointment/history_page.dart';
import 'package:final_project/views/screens/patient/patient_home_page.dart';
import 'package:final_project/views/screens/patient/patient_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:final_project/l10n/app_localizations.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fireStore = Provider.of<FireStoreProvider>(context, listen: false);
      final auth = Provider.of<AppAuthProvider>(context, listen: false);
      if (auth.userType == "patient") {
        await fireStore.getPatient();
        await fireStore.getAllAppointments();
        await fireStore.getTodaysAppointment();
        await fireStore.getAllDoctors();
        await fireStore.getAllStoredAppointments();
      } else {
        await fireStore.getDoctor();
        await fireStore.getAllAppointments();
      }
    });
    super.initState();
  }

  int currentPage = 0;
  final PageController _page = PageController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Consumer2<AppAuthProvider, FireStoreProvider>(
      builder: (context, auth, fireStore, child) {
        return Scaffold(
          body: PageView(
            controller: _page,
            onPageChanged: ((value) {
              setState(() {
                currentPage = value;
              });
            }),
            children: <Widget>[
              if (auth.userType == "patient") ...[
                PatientHomePage(),
                HistoryPage(),
                AppointmentPage(),
                PatientProfilePage(),
              ] else ...[
                DoctorHomePage(),
                DoctorProfilePage(),
              ],
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            onTap: (page) {
              setState(() {
                currentPage = page;
                _page.animateToPage(
                  page,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              });
            },
            items: <BottomNavigationBarItem>[
              if (auth.userType == "patient") ...[
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.houseChimneyMedical),
                  label: localizations.home,
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.clockRotateLeft),
                  label: localizations.history,
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidCalendarCheck),
                  label: localizations.appointments,
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidUser),
                  label: localizations.profile,
                ),
              ] else ...[
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.houseChimneyMedical),
                  label: localizations.home,
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidUser),
                  label: localizations.profile,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
