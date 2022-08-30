import 'package:flutter/material.dart';
import 'package:legionstat/api/repository/chart_repository.dart';
import 'package:legionstat/api/repository/history_repository.dart';
import 'package:legionstat/views/home.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChartRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryRepository()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: Color(0xFF141E30)),
          home: HomePage()),
    );
  }
}
