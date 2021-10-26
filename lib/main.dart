import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tue_26oct/AppLocalization/AppLanguage.dart';
import 'package:tue_26oct/AppLocalization/AppLocalization.dart';
import 'package:tue_26oct/modules/auth/login/login.dart';
import 'package:tue_26oct/modules/home/home_page.dart';
import 'package:tue_26oct/services_models/user_model.dart';
import 'package:tue_26oct/utilities/constants.dart';
import 'package:tue_26oct/utilities/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


bool isLoggedIn = getUserLoggedIn();
UserModel currentUser;
SharedPreferences preferences;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initPref();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

initPref() async {
  preferences = await SharedPreferences.getInstance();
}


class MyApp extends StatefulWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => widget.appLanguage,
    child: Consumer<AppLanguage>(builder: (context, model, child) => MaterialApp(
    darkTheme: ThemeData.dark(),
      title: appName,
      locale: model.appLocal,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: isLoggedIn?HomePage():Login(),
    )));
  }
}
