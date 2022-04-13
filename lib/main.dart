import 'dart:io';

import 'package:bitsports/features/home/pages/home_page.dart';
import 'package:bitsports/features/home/services/people_service.dart';
import 'package:bitsports/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'features/home/data/starwars_data.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => PeopleService(StarWarsData(), http.Client())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BitSports',
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.black,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              color: Color(0xff121212),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            textTheme: const TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              headline2: TextStyle(color: Color(0xffEC5757)),
            )),
        home: const HomePage(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
