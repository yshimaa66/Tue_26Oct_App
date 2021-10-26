
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tue_26oct/modules/auth/login/cubit/cubit.dart';
import 'package:tue_26oct/modules/auth/login/cubit/states.dart';
import 'package:tue_26oct/modules/auth/register/register.dart';
import 'package:tue_26oct/modules/home/home_page.dart';
import 'package:tue_26oct/utilities/colors.dart';
import 'package:tue_26oct/utilities/constants.dart';
import 'package:tue_26oct/widget/buttons_widget.dart';
import 'package:tue_26oct/widget/fields_widget.dart';
import 'package:tue_26oct/widget/shared_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;



   var createNewAccount = GestureDetector(
     onTap: (){
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => Register()),
       );
     },
     child: Text("New User? Register" ,
       style:TextStyle( color:Colors.white.withOpacity(.5),fontSize: 16.0,
           fontWeight: FontWeight.bold),
     ),
   );


    return new BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(),
    child: BlocConsumer<LoginCubit, LoginStates>(
    listener: (context, state) async {

    if(state is LoginSuccess){

      showToast(msg: 'Login completed successfully');
      navigateTo(context, HomePage());

    }



    },
    builder: (context, state){

      return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Container(

        child:new Scaffold(
          backgroundColor: Colors.black12,
          resizeToAvoidBottomInset: false,

          appBar: AppBar(
            centerTitle: true,
            backgroundColor: primaryColor,
            title: Text(appName),
          ),
          body: Center(
            child: Stack(
              children: [
                Align(
                  alignment:Alignment.center,
                  child: Form(
                          key: BlocProvider.of<LoginCubit>(context).formKey,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[



                                    ///Email
                                    Container(
                                    margin: EdgeInsets.only(top:50.0,right: 20,left: 20),
                                    child : TxtField(controller: BlocProvider.of<LoginCubit>(context).emailController,
                                    hintText: "Email",validator: (value) {
                                    if (value.toString().isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value.toString()) || value == null) {
                                    return 'Enter a valid email!';
                                    }
                                    },prefixIcon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged:  (String str) {
                                    },),),


                                    ///Password
                                    Container(
                                    margin: EdgeInsets.only(top:8.0,right: 20,left: 20),
                                    child : TxtField(controller: BlocProvider.of<LoginCubit>(context).passwordController,
                                    hintText: "Password",
                                    obscureText: BlocProvider.of<LoginCubit>(context).obscureText,
                                    validator: (value) {
                                    if (value.toString().isEmpty) {
                                    return 'Please enter a valid password!';
                                    }
                                    // else if(value.toString().length < 8)
                                    // {
                                    // return 'Password must be more than 8 character';
                                    //
                                    //}
                                    },suffixWidget: GestureDetector(
                                    onTap: BlocProvider.of<LoginCubit>(context).togglePassword,
                                    child: BlocProvider.of<LoginCubit>(context).obscureText?
                                    Icon( Icons.visibility_off,
                                    size: 20.0,
                                    color: Colors.white,
                                    ):Icon( Icons.visibility,
                                    size: 20.0,
                                    color: Colors.white,
                                    ),
                                    ),prefixIcon:  Icons.lock_outline_sharp,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged:  (String str) {
                                    },),),




                                    SizedBox(height: height/40,),

                                    TxtButton(color: primaryColor,
                                              text: "Login".toUpperCase(),
                                              horizontalPadding: 45,verticalPadding: 20,
                                              onPressed: () async{

                                                BlocProvider.of<LoginCubit>(context).loginUser(context);

                                              },
                                            ),


                            SizedBox(height: height/30,),



                          createNewAccount,



                                  ]
                              ),
                            ),
                ),


                ShowLoading(isLoading: BlocProvider.of<LoginCubit>(context).isLoading,),


              ],
            ),
          )


                ),


          ));

    }));
  }

  // bool _isLoggedIn = false;
  //
  // Map userProfile;
}


