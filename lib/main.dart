import 'package:deer/dependencies.dart';
import 'package:deer/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final dependencies = Dependencies.standard();
  final notificationManager = FlutterLocalNotificationsPlugin();
  initializeDateFormatting().then((_) => runApp(App(
    dependencies: dependencies,
    notificationManager: notificationManager,
  )));
}
