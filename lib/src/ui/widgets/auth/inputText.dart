import 'package:flutter/material.dart';
import 'package:sillicon_films/src/config/app_styles.dart';

class InputText extends StatefulWidget {
  late String label;
  late TextEditingController controller;
  ValueChanged update = (value){};
  bool? password;
  IconData? prefixIcon;
  IconData? suffixIcon;
  InputText(this.label,this.controller, this.update,{this.password = false, this.prefixIcon, this.suffixIcon, Key? key}) : super(key: key);


  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool _hidden = false;

  @override
  void initState() {
    // TODO: implement initState
    _hidden = widget.password!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _hidden ? true : false,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          filled: true,
          label: Text(widget.label),
          labelStyle: TextStyle(color: AppStyles.onPrimaryContainer),
          fillColor: AppStyles.primaryContainer,

          prefixIcon: widget.prefixIcon!=null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.suffixIcon!=null ? IconButton(icon: Icon(widget.suffixIcon),
            onPressed: (){
            print("tap");
            setState((){
              _hidden = !_hidden;
              print(_hidden);
            });
            }, ) : null,
        ),
      ),
    );
  }
}
