import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

import 'package:tue_26oct/modules/chapter/cubit/states.dart';

class ChapterCubit extends Cubit<ChapterStates> {
  ChapterCubit() : super(Initial());

  static ChapterCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;



  toggleIsLoading() {
    isLoading = !isLoading;
    emit(IsLoading());
  }



}
