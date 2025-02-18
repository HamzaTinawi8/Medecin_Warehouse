import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medecin_warehouse/core/cubit/Auth_cubit/Auth_cubit.dart';
import 'package:medecin_warehouse/generated/l10n.dart';
import 'package:medecin_warehouse/view/screen/cart_screen.dart';
import 'package:medecin_warehouse/view/screen/categories_screen.dart';
import 'package:medecin_warehouse/view/screen/home.dart';
import 'package:medecin_warehouse/view/screen/login.dart';
import 'package:medecin_warehouse/view/screen/onboarding.dart';
import 'package:medecin_warehouse/view/widget/cart_widget.dart';
import 'package:medecin_warehouse/view/widget/nav_bar.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';


void main() {
  runApp( Phoenix(child: MyApp()));
}

class MyApp extends StatefulWidget {
  String ?x;
  MyApp({ this.x});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: NavBar(),
    );
  }
}

