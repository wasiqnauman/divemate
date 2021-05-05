import 'package:divemate/theme.dart';
import 'package:flutter/material.dart';

// widgets for the login/signup screen

Widget createTextField(
    String _label, Function _val, Function _onSave, bool _obscure, {String initVal}) {
  /*
    @params
    _label: label of textfield
    _val: function to validate the input
    _onSave: function when the input is valid
    _obscure: obscure the input or not

    @returns
    a TextFormField widget

    */
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 30.0,
      vertical: 10.0,
    ),
    child: TextFormField(
        obscureText: _obscure,
        decoration: InputDecoration(labelText: _label),
        validator: _val,
        onSaved: _onSave,
        initialValue: initVal,),
  );
}

Widget createButton(String _label, Function _action) {
  /*
    @params
    _label: label of textfield
    _action: function when the button the pressed

    @returns
    a TextButton widget
    
    */
  return Container(
    width: 250.0,
    child: TextButton(
        onPressed: _action,
        style: buttonStyleDark,
        child: Text(
          _label,
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        )),
  );
}
