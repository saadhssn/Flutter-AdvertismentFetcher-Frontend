import 'dart:ui';


import 'package:advertisment_fetcher/static/views/auth/login_page.dart';
// import 'package:advertisment_fetcher/static/views/home/home_2.dart';
import 'package:advertisment_fetcher/static/views/home/home_page.dart';
import 'package:advertisment_fetcher/static/views/home/userProvider.dart';

// ignore_for_file: prefer_const_constructors, unused_import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{

  runApp(
    ChangeNotifierProvider(create: (context)=> userProvider(),
    child:  MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advertisment Fetcher',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

