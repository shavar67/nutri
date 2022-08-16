import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/constants/route_constants.dart';
import 'package:nuclear/model/theme_provider.dart';
import 'package:nuclear/routes/router.dart';
import 'package:nuclear/screens/shared/home.dart';
import 'package:nuclear/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [Provider<ThemeProvider>(create: (_) => ThemeProvider())],
    child: const MyApp(),
  ));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeProvider _themeProvider = ThemeProvider();

  var logger = Logger(printer: PrettyPrinter());

  @override
  void initState() {
    _initAppTheme();
    super.initState();
  }

  void _initAppTheme() async {
    _themeProvider.setDarkTheme = await _themeProvider.appPreference.getTheme();
    logger.i('logging from init state ${_themeProvider.getDarkTheme}');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
        create: (_) => _themeProvider,
        child: Consumer<ThemeProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: !_themeProvider.getDarkTheme
                    ? AppTheme.lightTheme
                    : AppTheme.darkTheme,
                initialRoute: homeRoute,
                builder: EasyLoading.init(),
                onGenerateRoute: AppRouter.generateRoute,
                home: Home());
          },
        ));
  }
}
