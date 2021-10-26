import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tue_26oct/modules/auth/register/cubit/cubit.dart';
import 'package:tue_26oct/modules/auth/register/cubit/states.dart';
import 'package:tue_26oct/modules/home/home_page.dart';
import 'package:tue_26oct/utilities/colors.dart';
import 'package:tue_26oct/utilities/constants.dart';
import 'package:tue_26oct/widget/buttons_widget.dart';
import 'package:tue_26oct/widget/fields_widget.dart';
import 'package:tue_26oct/widget/profile_image_widget.dart';
import 'package:tue_26oct/widget/shared_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}
class _Register extends State<Register> {

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return new BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) async {

           if(state is RegisterSuccess){

             showToast(msg: 'Registration completed successfully');

             navigateTo(context, HomePage());


           }


          },
          builder: (context, state) => WillPopScope(
         onWillPop: ()async{

           Navigator.pop(context);

           return true;
         },
      child:Container(

        child:new Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: primaryColor,
            title: Text(appName),
          ),

          resizeToAvoidBottomInset: false,

          body:Center(
            child:Stack(
              children: [
               Form(
                      key: BlocProvider.of<RegisterCubit>(context).formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                          ProfileImageWidget(cubit: BlocProvider.of<RegisterCubit>(context)
                            ,onPressed: (){BlocProvider.of<RegisterCubit>(context).pickImage();}),

                        Container(
                          margin: EdgeInsets.only(top:25.0,right: 20,left: 20),
                          child : TxtField(controller: BlocProvider.of<RegisterCubit>(context).nameController,
                          hintText: "Name",validator: (value) {
                            if (value.toString().isEmpty || value == null) {
                            return 'Please enter your name!';
                            }
                            else if(double.tryParse(value) !=null)
                            {
                            return 'Name must be text only';
                            }
                            },prefixIcon: Icons.person,
                            keyboardType: TextInputType.name,
                            onChanged:  (String str) {
                            },),),

                            Container(
                            margin: EdgeInsets.only(top:8.0,right: 20,left: 20),
                            child : TxtField(controller: BlocProvider.of<RegisterCubit>(context).phoneController,
                            hintText: "Phone",validator: (value) {
                                  if (value.toString().isEmpty || value == null ) {
                                    return 'Please enter a your phone number !';
                                  }
                                  else if(!(value.length == 11))
                                  {
                                    return 'Phone number must be 11 numbers';
                                  }
                                  else if(!(value.substring(0,2) == "01"))
                                  {
                                    return 'Phone number must start with 01';
                                  }
                                },prefixIcon: Icons.local_phone,
                            keyboardType: TextInputType.phone,
                            onChanged:  (String str) {
                            },),),

                          Container(
                          margin: EdgeInsets.only(top:8.0,right: 20,left: 20),
                          child : TxtField(controller: BlocProvider.of<RegisterCubit>(context).emailController,
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

                        Container(
                        margin: EdgeInsets.only(top:8.0,right: 20,left: 20),
                        child : TxtField(controller: BlocProvider.of<RegisterCubit>(context).passwordController,
                        hintText: "Password",validator: (value) {
                            if (value.toString().isEmpty) {
                            return 'Please enter a valid password!';
                            }
                            else if(value.toString().length < 8)
                            {
                            return 'Password must be more than 8 character';
                            }
                            },obscureText:BlocProvider.of<RegisterCubit>(context).obscureText,

                              suffixWidget: GestureDetector(
                              onTap: BlocProvider.of<RegisterCubit>(context).togglePassword,
                              child: BlocProvider.of<RegisterCubit>(context).obscureText?
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


                        SizedBox(height: 40,),

                        TxtButton(color: primaryColor,
                                      text: "Register".toUpperCase(),
                                    horizontalPadding: 45,verticalPadding: 20,
                                    onPressed: () async{

                                      BlocProvider.of<RegisterCubit>(context)
                                          .registerUser(context);

                                       },
                                    ),


                        ],
                      ),
                    ),


                ShowLoading(isLoading: BlocProvider.of<RegisterCubit>(context).isLoading,),


              ],
            ),
          ),
        ),
      ),
    )));
  }

}