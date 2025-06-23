import 'dart:developer';

import 'package:final_project/models/appointment.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  LocalNotification._();
  static LocalNotification localNotification = LocalNotification._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse details) {}

  Future init() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );
  }

  void showSchduledNotification(TZDateTime appointmentTime) async {
    // tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 3",
        " repeated notification",
        importance: Importance.max,
        priority: Priority.max,
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      "Scheduled Notification",
      "body",
      appointmentTime,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  void getRightTime(AppointmentModel appointment) async {
    // Initialize timezone database
    tz.initializeTimeZones();
    // Set local location to Africa/Cairo
    final cairo = tz.getLocation('Africa/Cairo');
    tz.setLocalLocation(cairo);

    // Get current time in Cairo
    final now = tz.TZDateTime.now(cairo);
    // final tzTime = DateFormat('HH:mm a').format(now);

    final appointmentDateTime = DateFormat(
      'M/dd/yyyy HH:mm',
    ).parse("${appointment.date} ${appointment.time}");

    final appointmentReminder = appointmentDateTime.subtract(Duration(days: 1));
    final scheduledAppointmentTime = tz.TZDateTime.from(
      appointmentReminder,
      cairo,
    );

    if (scheduledAppointmentTime.subtract(Duration(days: 1)).day == now.day) {
      if (appointmentReminder.isAfter(now)) {
        showSchduledNotification(scheduledAppointmentTime);
      }
    }

    // final testTzDateTime = tz.TZDateTime.from(
    //   tz.TZDateTime.now(tz.local).add(Duration(days: 2)),
    //   cairo,
    // );
    // log(testTzDateTime.toString());
    // final reminder = testTzDateTime.subtract(Duration(days: 1));
    // log(reminder.toString());

    // log(reminder.subtract(Duration(days: 1)).toString());
    // log(now.toString());

    // if (reminder.subtract(Duration(days: 1)).day == now.day) {
    //   if (reminder.isAfter(now)) {
    //     log("inside if $reminder");
    //     showSchduledNotification(reminder);
    //     log(reminder.toString());
    //     log(now.toString());
    //   }
    // }
    final testTzDateTime = tz.TZDateTime.from(
      now.add(Duration(seconds: 40)),
      cairo,
    );

    final reminder = testTzDateTime.subtract(Duration(seconds: 30));

    if (reminder.isAfter(now)) {
      log("inside if $reminder");
      showSchduledNotification(reminder);
    }

    // log('Appointment as TZDateTime: $appointmentTzDateTime');

    // Compare dates

    // if (tzDate == "6/21/2025") {
    //   if ("19:19 PM" == tzTime) {
    //     log(tzDate);
    //     log(tzTime);

    //     // showSchduledNotification(appointmentTzDateTime);
    //     log('test timezone time : $testTzDateTime');
    //     log('current timezone time : ${tz.TZDateTime.now(tz.local)}');
    //     showSchduledNotification(testTzDateTime.add(Duration(seconds: 10)));
    //   }
    // }
    // if (tzDate == appointment.date) {
    //   if ("18:41 PM" == tzTime) {

    //     // showSchduledNotification(appointmentTzDateTime);
    //     log('test timezone time : $testTzDateTime');
    //     showSchduledNotification(testTzDateTime);
    //   }
    // }
  }
}
