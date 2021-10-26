import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tue_26oct/modules/chapter/chapter_page.dart';
import 'package:tue_26oct/helper/API_Manager.dart';
import 'package:tue_26oct/modules/home/cubit/cubit.dart';
import 'package:tue_26oct/modules/home/cubit/states.dart';
import 'package:tue_26oct/modules/side_drawer/side_drawer.dart';
import 'package:tue_26oct/services_models/chapter_model.dart';
import 'package:tue_26oct/utilities/colors.dart';
import 'package:tue_26oct/utilities/constants.dart';
import 'package:tue_26oct/widget/shared_widgets.dart';
import 'package:tue_26oct/helper/API_Manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _Homemodulestate createState() => _Homemodulestate();
}


class _Homemodulestate extends State<HomePage> {

  API_Manager api_manager = API_Manager();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    void openPage(where) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => where));
    }



    return new BlocProvider<HomeCubit>(
        create: (context) => HomeCubit()..initializeCurrentUser(),
    child: BlocConsumer<HomeCubit, HomeStates>(
    listener: (context, state) async {



    },
    builder: (context, state) =>  Scaffold(
      appBar: AppBar(
        title: Text(appName, style: GoogleFonts.poppins()),
        centerTitle: true,
        backgroundColor:  primaryColor,
      ),
        drawer: SideDrawer(),
        body: Container(
        child: FutureBuilder(
          future: api_manager.loadChapters(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  addAutomaticKeepAlives: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: 114,
                  itemBuilder: (context, index) {

                    ChapterModel chapterModel = snapshot.data[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                        child: ListTile(
                          onTap: () {
                            openPage(ChapterPage(chapterModel));
                          },
                          title: Text(chapterModel.name_english,
                              style: GoogleFonts.poppins()),
                          leading: CircleAvatar(
                            backgroundColor: primaryColor,
                            child: Text((index + 1).toString(),
                                style: GoogleFonts.poppins(color: Colors.black)),
                          ),
                          subtitle: Text(
                              chapterModel.revelation_place,
                              style: GoogleFonts.poppins()),
                          trailing: Text("سورة ${chapterModel.name} ",
                              style: GoogleFonts.poppins()),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: ShowLoading(isLoading: true,));
            }
          },
        ),
      )),
    ));
  }
}
