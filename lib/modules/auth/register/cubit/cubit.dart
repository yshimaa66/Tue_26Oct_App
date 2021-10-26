import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tue_26oct/modules/auth/register/cubit/states.dart';
import 'package:tue_26oct/utilities/constants.dart';
import 'package:tue_26oct/utilities/shared_pref.dart';
import 'package:tue_26oct/widget/shared_widgets.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(Initial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  bool obscureText = true;
  String title="";
  var imageFile;
  final textFieldFocusNode = FocusNode();

  var imageUrl;

 togglePassword() {
      obscureText = !obscureText;
      // textFieldFocusNode.unfocus();
      // textFieldFocusNode.canRequestFocus = false;
      emit(TogglePassword());
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
        imageFile = File(pickedImage.path);
    }
    emit(ImagePicked());
  }

  uploadImage() async {
    if (imageFile != null) {
      try {
        final FirebaseStorage storage = FirebaseStorage.instance;

         String imageName = DateTime.now().millisecondsSinceEpoch.toString();

         Reference refFeedBucket = storage
            .ref('profilePictures/' + imageName);


        TaskSnapshot uploadedFile = await refFeedBucket.putFile(imageFile);

        if (uploadedFile.state == TaskState.success) {
          imageUrl = await refFeedBucket.getDownloadURL();
        }

        print(imageUrl);

        emit(ImageUpload());

      }catch(e){
        print(e.toString());
      }
  }
 }

  registerUser(context) async{


    if (formKey.currentState.validate() && imageFile != null) {

      toggleIsLoading();

      try {
       UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text
        );

        User firebaseUser = userCredential.user;

        print(firebaseUser);

        await uploadImage();

        print(imageUrl);

         usersRef.doc(firebaseUser?.uid).set({
            "id": firebaseUser?.uid,
            "name": nameController.text,
            "email": emailController.text,
            "phone": phoneController.text,
           "image":imageUrl,
           "loginBy":"Email"
          });

        DocumentSnapshot doc = await usersRef.doc(firebaseUser?.uid).get();

        print(doc);

        saveUser(doc);

        toggleIsLoading();

        emit(RegisterSuccess(nameController.text));

      } on FirebaseAuthException catch (e) {
        //await loadingDialog(isLoading: false);
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          showToast(msg: "The password provided is too weak");
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          showToast(msg: "The account already exists for that email");
        }
        toggleIsLoading();
      } catch (e) {
        print(e);
        showToast(msg: e.toString());
        toggleIsLoading();
      }
    }else{

      if(imageFile == null) {
        showToast(msg: "Image is required");
      }

      if(!formKey.currentState.validate()){
        showToast(msg: "All fields are required");
      }

    }
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
