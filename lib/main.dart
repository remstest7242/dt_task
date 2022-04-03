import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_demo/core/bindings/application_binding.dart';
import 'package:news_app_demo/core/data/constants.dart';
import 'package:news_app_demo/core/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: AppString.titleAppName,
        initialBinding: ApplicationBinding(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: routes);
  }

}
