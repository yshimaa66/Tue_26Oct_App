
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tue_26oct/AppLocalization/AppLanguage.dart';
import 'package:tue_26oct/AppLocalization/AppLocalization.dart';
import 'package:tue_26oct/main.dart';
import 'package:tue_26oct/modules/auth/login/login.dart';
import 'package:tue_26oct/modules/side_drawer/cubit/cubit.dart';
import 'package:tue_26oct/modules/side_drawer/cubit/states.dart';
import 'package:tue_26oct/utilities/colors.dart';
import 'package:tue_26oct/widget/shared_widgets.dart';

class SideDrawer extends StatefulWidget{
  _SideDrawer createState()=> _SideDrawer();
}
class _SideDrawer extends State<SideDrawer> {



  @override
    Widget build(BuildContext context) {

    var appLanguage = Provider.of<AppLanguage>(context);


    return new BlocProvider<SideDrawerCubit>(
          create: (context) => SideDrawerCubit(),
      child: BlocConsumer<SideDrawerCubit, SideDrawerStates>(
      listener: (context, state) async {

      if(state is LogoutSuccess){

      showToast(msg: 'We will miss you');
      navigateTo(context, Login());

      }


      },
      builder: (context, state) => Drawer(
      child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[



                DrawerHeader(child: Column(
                  children: [
                    currentUser.image != null
                        ?
                   Stack(
                     children: [
                       CircleAvatar(
                         child: SpinKitCircle(
                           color: Colors.white,
                           size: 40,
                         ),
                         backgroundColor: accentColor,
                         radius: 50,
                       ),

                       CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        backgroundImage:NetworkImage(currentUser.image),
                       ),
                     ],
                   ):CircleAvatar(
                      child: Icon(Icons.person,size: 50,color: Colors.white,),
                      backgroundColor: primaryColor,
                      radius: 50,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child: Text(
                        currentUser.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                )),




          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(AppLocalizations.of(context).translate('logOut'),),
            onTap: () =>
            {
              showAlert(context,BlocProvider.of<SideDrawerCubit>(context)),

            },
          ),

                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(AppLocalizations.of(context).translate('changeLang'),),
                  onTap: (){

                  print(appLanguage.appLocal.languageCode);

                  if(appLanguage.appLocal.languageCode=="en"){
                  appLanguage.changeLanguage(Locale("ar"));
                  }else{
                  appLanguage.changeLanguage(Locale("en"));
                  }

                },
                ),


        ],
      ),
    )));
  }

  showAlert(BuildContext context,cubit) {

    var noBtn = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    var yesBtn = TextButton(
      child: Text("Yes"),
      onPressed: () {
        cubit.logOut();
      },
    );

    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: new Text("LOGOUT"),
            content: new Text("Are You Sure Want To Logout ?"),
            actions: <Widget>[
              noBtn,
              yesBtn
              ]);
        });

  }
}