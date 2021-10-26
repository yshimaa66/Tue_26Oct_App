import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tue_26oct/modules/verse_audio_player.dart';
import 'package:tue_26oct/services_models/chapter_model.dart';
import 'package:tue_26oct/services_models/verse_model.dart';
import 'package:tue_26oct/utilities/colors.dart';
import 'package:tue_26oct/widget/shared_widgets.dart';

class VersesBox extends StatefulWidget {
  VerseModel verse;

  VersesBox(this.verse);

  @override
  _VersesBoxState createState() => _VersesBoxState();
}

class _VersesBoxState extends State<VersesBox> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              SizedBox(height: 10),
              VerseOptions(widget: widget),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(right: 15, left: 15),
                alignment: Alignment.topRight,
                child: Wrap(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 8),
                        child: Text(widget.verse.text_uthmani,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 20.5)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}

class VerseOptions extends StatelessWidget {
  const VerseOptions({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final VersesBox widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 60,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.black26, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    child: TextButton(
                        onPressed: () {},
                        child: CircleAvatar(
                            backgroundColor: primaryColor,
                            child: Text((widget.verse.verse_number).toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                )))))),
            Expanded(flex: 2, child: Container()),
            Expanded(
                flex: 3,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {

                            navigateTo(context,
                                VerseAudioPlayer(audio_url: widget.verse.audio_url,));

                          },
                          icon: Icon(Icons.play_arrow_outlined,
                            color: primaryColor,

                          )),
                      SizedBox(width: 10)
                    ],
                  ),
                )),
          ],
        ));
  }
}
