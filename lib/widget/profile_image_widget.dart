
import 'package:flutter/material.dart';
import 'package:tue_26oct/utilities/colors.dart';

class ProfileImageWidget extends StatelessWidget {

  final cubit;
  final onPressed;


  const ProfileImageWidget({Key key, this.cubit, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top:25.0),
      child: Stack(
        children: [

          Align(
            alignment: Alignment.center,
            child: Visibility(
                visible: cubit
                    .imageFile == null,
                child: Icon(Icons.person,color: Colors.white,size: 50,)),

          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(top:7),
              decoration: BoxDecoration(
                  color: primaryColor,
                  //borderRadius:BorderRadius.circular(100),
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryColor,width: 2)
              ),

              child : IconButton(
                  alignment: Alignment.topCenter,
                  icon: new Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.white,
                  ),
                  onPressed:
                    onPressed,

              ),

            ),
          ),
        ],
      ),
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        image: cubit
            .imageFile != null ? DecorationImage(
            image: FileImage(
                cubit.imageFile),
            fit: BoxFit.cover
        ):null,
      ),
    );
  }
}
