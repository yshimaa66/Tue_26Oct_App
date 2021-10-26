import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tue_26oct/utilities/colors.dart';

showToast({String msg="", toastLength}) => Fluttertoast.showToast(
  msg: msg,
  //  toastDuration: Duration(seconds: 2),
  toastLength: toastLength ?? Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 3,
  // backgroundColor: Colors.red,
  // textColor: Colors.white,
  fontSize: 16.0,
);


class ShowLoading extends StatelessWidget {

  final bool isLoading;
  final double size;

  const ShowLoading({Key key, this.isLoading=true, this.size=50.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Center(
        child: SpinKitCircle(
          color: primaryColor,
          size: size,
        ),
      ),
    );
  }
}


void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);