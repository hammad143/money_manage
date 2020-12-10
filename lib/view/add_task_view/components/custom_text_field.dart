import 'package:flutter/material.dart';
import 'package:money_management/util/responsive_and_text_pkg.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final int maxLength;
  final bool autoFocus;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function(String) onFormSubmit, validator;
  const CustomTextFormField({Key key, this.focusNode, this.onFormSubmit, this.hintText, this.maxLength, this.validator, this.controller, this.autoFocus, this.keyboardType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLength:  maxLength,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      style: Style.textStyle1.copyWith(color: Colors.black87),
      decoration: InputDecoration(
        hintStyle: TextStyle(
            color: Colors.black54,
            fontSize: Responsive.textScaleFactor * 4.5),
        hintText: hintText,
      ),
    );
  }

}
