import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tue_26oct/services_models/chapter_model.dart';
import 'package:tue_26oct/utilities/colors.dart';

class IntroBox extends StatelessWidget {

  ChapterModel chapter;
  String title;

  IntroBox(this.chapter, this.title);

  String attawbacheck(name) {
    if (name == "التوبة") {
      return "أعوذُ بِٱللَّهِ مِنَ ٱلشَّيۡطَٰنِ ٱلرَّجِيمِ";
    } else {
      return 'بِسْمِ اللَّهِ الرَّحْمَن الرَّحِيم';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          border: Border.fromBorderSide(
              BorderSide(
                  color:primaryColor,width: 5
              )
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight:Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),//                 <--- border radius here
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        // height: 200,
        // width: 340,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SizedBox(height: 20),
              // Text(Chapter.englishNameTranslation,
              //     style: GoogleFonts.poppins(fontSize: 22)),
              SizedBox(height: 15),
              Text(
                  chapter.revelation_place +
                      "     |     " +
                      chapter.verses_count.toString() +
                      " verses",
                  style: GoogleFonts.poppins(fontSize: 15)),
              SizedBox(height: 20),
              Text(attawbacheck(chapter.name), style: GoogleFonts.poppins(fontSize: 25))
            ],
          ),
        ),
      ),
    );
  }
}
