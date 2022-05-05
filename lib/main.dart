import 'package:biddano/utils/constants.dart';
import 'package:biddano/utils/locator.dart';
import 'package:biddano/utils/navigation.dart';
import 'package:biddano/utils/routes-utils.dart';
import 'package:biddano/views/tabbar/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.app_name,
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: dashboardRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(
        title: AppStrings.app_name,
      ),
    );
  }
}
