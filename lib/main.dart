import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/constants/route_constants.dart';
import 'package:nuclear/model/theme_provider.dart';
import 'package:nuclear/routes/router.dart';
import 'package:nuclear/screens/shared/home.dart';
import 'package:nuclear/theme/app_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [Provider<ThemeProvider>(create: (_) => ThemeProvider())],
    child: const MyApp(),
  ));
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
                onGenerateRoute: AppRouter.generateRoute,
                home: const Home());
          },
        ));
  }
}
