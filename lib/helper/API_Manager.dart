// ignore: file_names
// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tue_26oct/services_models/chapter_model.dart';
import 'package:tue_26oct/services_models/verse_model.dart';
import 'package:tue_26oct/utilities/constants.dart';
import 'package:tue_26oct/widget/shared_widgets.dart';

class API_Manager {

  // ignore: missing_return
  Future<List<ChapterModel>>loadChapters()async{

    try {
      const subUrl='chapters';

      var fullUrl = baseUrl + subUrl;

      print(fullUrl);

      var response = await http.get(Uri.parse(fullUrl));

      if(response.statusCode == 200){

        List parsed = json.decode(response.body)["chapters"];
        print(parsed[0]);
        return parsed.map((e) => ChapterModel.fromJson(e)).toList();
      }
      else{
        showToast(msg: json.decode(response.body)["exception"]??"Something went wrong");
      }
    } catch (e) {
      // ignore: avoid_print
      print("loadChapters $e");
    }
  }



    Future<List<VerseModel>>loadVersesPerPage(String verseBaseUrl)async{

      List<VerseModel> verses = [];
      bool isNextPageExist=true;
      int pageNumber = 1;

      while(isNextPageExist){


      try {
        final subUrl='&page=$pageNumber&per_page=200';

        var fullUrl = verseBaseUrl + subUrl;

        // ignore: avoid_print
        print(fullUrl);

        var response = await http.get(Uri.parse(fullUrl));

        if(response.statusCode == 200){

          // ignore: avoid_print
          print(response.body);

          List parsed = json.decode(response.body)["verses"];
          isNextPageExist = json.decode(response.body)["pagination"]["next_page"]!=null;
          // ignore: avoid_print
          print(parsed[0]);
          verses.addAll(parsed.map((e) => VerseModel.fromJson(e)).toList());
        }
        else{
          showToast(msg: json.decode(response.body)["exception"]??"Something went wrong");
        }
      } catch (e) {
        // ignore: avoid_print
        print("loadVersesPerPage $e");
      }

      pageNumber++;


      }

      return verses;

    }



    Future<List<VerseModel>>loadVerses(int chapterNumber,int pagesLength)async{

        List<VerseModel> verses = [];

        final subUrl='verses/by_chapter/$chapterNumber?language=en&words=false&audio=1&fields='
            'text_uthmani';

        var fullUrl = baseUrl + subUrl;

        // ignore: avoid_print
        print(fullUrl);
        // ignore: avoid_print
        print(pagesLength);


        var newVerses = await loadVersesPerPage(fullUrl);


        verses.addAll(newVerses);


        return verses;

    }



}
