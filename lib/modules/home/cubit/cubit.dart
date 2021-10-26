import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tue_26oct/main.dart';
import 'dart:ui' as ui;

import 'package:tue_26oct/modules/home/cubit/states.dart';
import 'package:tue_26oct/services_models/user_model.dart';
import 'package:tue_26oct/utilities/shared_pref.dart';


class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(Initial());

  static HomeCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;


  initializeCurrentUser() async {

    print("initialize Current User");

    var currentUserDoc = getCurrentUser();

    try {
      currentUser = UserModel.fromJson(jsonDecode(currentUserDoc));
      print(currentUser.image);
    }catch(e){
      print(e.toString());
    }

    emit(InitializeCurrentUser());

  }

  toggleIsLoading() {
    isLoading = !isLoading;
    emit(IsLoading());
  }



}
