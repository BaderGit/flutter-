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

  void showBasicNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 1",
        "basic notification",
        importance: Importance.max,
        priority: Priority.max,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      "title",
      "basic notification",
      details,
      payload: "PayloadData",
    );
  }

  void showRepeatedNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 2",
        " repeated notification",
        importance: Importance.max,
        priority: Priority.max,
      ),
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
      androidScheduleMode: AndroidScheduleMode.exact,
      1,
      "repetaed notification",
      "body",
      RepeatInterval.everyMinute,
      details,
      payload: "PayloadData",
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
    final tzTime = DateFormat('HH:mm a').format(now);
    final tzDate = DateFormat('M/dd/yyyy').format(now);

    // Parse appointment date and time (note: fixed format pattern)
    final appointmentDateTime = DateFormat(
      'M/dd/yyyy HH:mm',
    ).parse("${appointment.date} ${appointment.time}");

    // Convert to TZDateTime in Cairo timezone
    // final appointmentTzDateTime = tz.TZDateTime.from(
    //   appointmentDateTime,
    //   cairo,
    // );
    final testTzDateTime = tz.TZDateTime.from(
      tz.TZDateTime.now(tz.local),
      cairo,
    );

    // Logging for debugging
    log('Appointment date: ${appointment.date}');
    log('Appointment time: ${appointment.time}');
    log('Current Cairo time: $tzTime');
    log('Current Cairo date: $tzDate');

    // log('Appointment as TZDateTime: $appointmentTzDateTime');

    // Compare dates

    if (tzDate == "6/21/2025") {
      if ("19:19 PM" == tzTime) {
        log(tzDate);
        log(tzTime);
        if (testTzDateTime.isAfter(tz.TZDateTime.now(tz.local))) {}

        // showSchduledNotification(appointmentTzDateTime);
        log('test timezone time : $testTzDateTime');
        log('current timezone time : ${tz.TZDateTime.now(tz.local)}');
        showSchduledNotification(testTzDateTime.add(Duration(seconds: 10)));
      }
    }
    // if (tzDate == appointment.date) {
    //   if ("18:41 PM" == tzTime) {

    //     // showSchduledNotification(appointmentTzDateTime);
    //     log('test timezone time : $testTzDateTime');
    //     showSchduledNotification(testTzDateTime);
    //   }
    // }
  }
}
