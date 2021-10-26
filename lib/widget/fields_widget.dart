import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TxtField extends StatelessWidget {

  final controller;
  final validator;
  final onChanged;
  final hintText;
  final prefixIcon;
  final keyboardType;
  final obscureText;
  final suffixWidget;
  final isPhone;

  const TxtField({Key key, this.controller,
    this.validator,this.onChanged, this.hintText
    ,this.prefixIcon,this.keyboardType, this.obscureText=false,
    this.suffixWidget,this.isPhone=false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
          // inputFormatters: <TextInputFormatter>[
          //   FilteringTextInputFormatter.allow(RegExp(!isPhone?"[0-9a-zA-Z]":'[0-9]')),
          // ],
          obscureText:obscureText,
          controller: controller,
          keyboardType: keyboardType,
          style: new TextStyle(fontSize:18.0, color: Colors.white),
          validator: validator,
          onChanged: onChanged,
          maxLines: 1,
          maxLength: 50,
          decoration: InputDecoration(
            hintText: hintText,
            counterText: "",
            hintStyle: TextStyle(fontSize: 14.0, color: Colors.white),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.white,
            ),
            suffixIcon:suffixWidget,
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.transparent, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
          ),
        );
  }
}
