import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tue_26oct/helper/API_Manager.dart';
import 'package:tue_26oct/modules/chapter/cubit/cubit.dart';
import 'package:tue_26oct/modules/chapter/cubit/states.dart';
import 'package:tue_26oct/services_models/chapter_model.dart';
import 'package:tue_26oct/services_models/verse_model.dart';
import 'package:tue_26oct/utilities/colors.dart';
import 'package:tue_26oct/widget/shared_widgets.dart';
import 'package:tue_26oct/widget/verses_box.dart';
import 'package:tue_26oct/widget/intro_box.dart';

class ChapterPage extends StatefulWidget {
  ChapterModel chapter;

  ChapterPage(this.chapter);

  @override
  _Chaptermodulestate createState() => _Chaptermodulestate();
}

class _Chaptermodulestate extends State<ChapterPage> {


  API_Manager api_manager = API_Manager();


  @override
  Widget build(BuildContext context) {

    return new BlocProvider<ChapterCubit>(
        create: (context) => ChapterCubit(),
    child: BlocConsumer<ChapterCubit, ChapterStates>(
    listener: (context, state) async {



    },
    builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(widget.chapter.name_english, style: GoogleFonts.poppins()),
          backgroundColor:  primaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 30),
                IntroBox(widget.chapter, widget.chapter.name_english),
                SizedBox(height: 30),
                FutureBuilder(
                future: api_manager.loadVerses(widget.chapter.number,
                    widget.chapter.pages),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {

                      return ListView.separated(
                      separatorBuilder: (context,index){
                      return SizedBox(height : 20);
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.chapter.verses_count,
                      itemBuilder: (context, index) {

                        VerseModel verseModel = snapshot.data[index];

                        return VersesBox(verseModel);

                      });
                      }
                      else {
                        return Center(child: ShowLoading(isLoading: true,));
                        }
                }),
              ],
            ),
          ),
        ),
       )));
  }
}


