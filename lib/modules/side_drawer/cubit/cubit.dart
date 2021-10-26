
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

import 'package:tue_26oct/modules/side_drawer/cubit/states.dart';
import 'package:tue_26oct/utilities/shared_pref.dart';

class SideDrawerCubit extends Cubit<SideDrawerStates> {
  SideDrawerCubit() : super(Initial());

  static SideDrawerCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;


  logOut() async{
    await FirebaseAuth.instance.signOut();
    clearSharedPref();
    emit(LogoutSuccess());
  }


  toggleIsLoading() {
    isLoading = !isLoading;
    emit(IsLoading());
  }



}
