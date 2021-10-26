

import 'package:tue_26oct/main.dart';

const String userLoggedInKey = "ISLOGGEDIN";
  const String userNameKey = "USERNAMEKEY";
  const String userEmailKey = "USEREMAILKEY";
  const String imageKey = "Image";
  const String userIdKey = "id";
  const String currentUserKey = "currentUser";
  const String isSeenIntroKey = "isSeenIntro";



/// saving data to sharedpreference
  Future<bool> saveUserLoggedIn(bool isUserLoggedIn) async{
    return await preferences.setBool(userLoggedInKey, isUserLoggedIn);
  }


  Future<bool> saveCurrentUser(String currentUserDoc) async{
    return await preferences.setString(currentUserKey, currentUserDoc);
  }

  Future<bool> saveIsSeenIntro() async{
    return await preferences.setBool(isSeenIntroKey, true);
  }

  /// fetching data from sharedpreference

  bool getUserLoggedIn() =>
    preferences.getBool(userLoggedInKey)??false;

  bool getIsSeenIntro() =>
      preferences.getBool(isSeenIntroKey)??false;

  String getCurrentUser() =>  preferences.getString(currentUserKey).toString();





  /// clear data from sharedpreference
  clearSharedPref() => preferences.clear();


