import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tue_26oct/modules/auth/login/cubit/states.dart';
import 'package:tue_26oct/utilities/constants.dart';
import 'package:tue_26oct/utilities/shared_pref.dart';
import 'package:tue_26oct/widget/shared_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(Initial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool obscureText = true;
  final textFieldFocusNode = FocusNode();

 togglePassword() {
      obscureText = !obscureText;
      textFieldFocusNode.unfocus();
      textFieldFocusNode.canRequestFocus = false;
      emit(TogglePassword());
  }


  loginUser(context) async{


    if (formKey.currentState.validate()) {

        try{

          toggleIsLoading();

          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text
          );

          User firebaseUser = userCredential.user;

          print(firebaseUser);

          DocumentSnapshot doc = await usersRef.doc(firebaseUser?.uid).get();

          print("user  ${doc.data()}");

          saveUser(doc);

          toggleIsLoading();

          emit(LoginSuccess());

      } on FirebaseAuthException catch (e) {

          showToast(msg: e.message.toString());
        toggleIsLoading();
      } catch (e) {
        print(e);
        showToast(msg: e.toString());
        toggleIsLoading();
      }
    }else{
        showToast(msg: "All fields are required");

    }
  }


  socialLogin(user,loginBy,isNewUser) async {
    toggleIsLoading();

    print(user);

    print(isNewUser);

    if(isNewUser) {
      await usersRef.doc(user.user.uid).set({
        "id": user.user.uid,
        "name": user.user.displayName,
        "email": user.user.email,
        "phone": user.user.phoneNumber,
        "image": user.user.photoURL,
        "loginBy": loginBy
      });
    }

    DocumentSnapshot doc = await usersRef.doc(user.user.uid).get();

    print(doc);

    saveUser(doc);
    toggleIsLoading();
    emit(SocialLoginSuccess(user.user.displayName, isNewUser));
  }


  saveUser(doc){
    saveUserLoggedIn(true);
    saveCurrentUser(json.encode(doc.data()));
  }

  toggleIsLoading() {
    isLoading = !isLoading;
    emit(IsLoading());
  }



}
